create or replace view SQL_SHARED_CURSOR
as select * from sys.v$sql_shared_cursor;

create or replace function version_rpt(p_sql_id varchar2 default null,p_hash number default null) return DBMS_DEBUG_VC2COLL PIPELINED is
 type vc_arr is table of varchar2(32767) index by binary_integer;
 type num_arr is table of number index by binary_integer;

 v_version varchar2(100);
 v_colname vc_arr;
 v_Ycnt num_arr;
 v_count number:=-1;
 v_no number;
 v_all_no number:=-1;
 
 v_query varchar2(4000);
 v_sql_id varchar2(15):=p_sql_id;
 v_addr varchar2(100);
 V_coladdr varchar2(100);
 v_hash number:=p_hash;
 v_mem number;
 v_parses number;
 
 theCursor number;
 columnValue char(1);
 status number;
 
 v_driver varchar2(1000);
 TYPE cursor_ref IS REF CURSOR;
 vc cursor_ref;
 
 v_bind_dumped boolean:=false;
 
BEGIN

 select version into v_version from v$instance;

 if v_sql_id is not null then
  open vc for 'select sql_text query,hash_value hash,rawtohex(ADDRESS) addr , sql_id , SHARABLE_MEM,PARSE_CALLS '
           || ' from v$sqlarea where sql_id=:v_sql_id '
       using v_sql_id ;
 else 
   SELECT max(COLUMN_NAME),max(decode(column_name,'SQL_ID','SQL_ID',NULL)) 
     into V_coladdr,v_sql_id
     from cols 
    where table_name='SQL_SHARED_CURSOR'
     and column_name in ('KGLHDPAR','ADDRESS','SQL_ID');
  if v_version like '9%' then
   open vc for
    'select sql_text query,hash_value,rawtohex(ADDRESS) addr,null sql_id,SHARABLE_MEM,PARSE_CALLS '
    ||' from v$sqlarea where hash_value=:v_hash'
   using v_hash;
  else
   open vc for
    'select sql_text query,hash_value,rawtohex(ADDRESS) addr,sql_id,SHARABLE_MEM,PARSE_CALLS'
    ||' from v$sqlarea where hash_value=:v_hash '
   using v_hash;
  end if;
 end if;

 PIPE ROW('Version Count Report Version 3.0 -- Today''s Date '||to_char(sysdate,'dd-mon-yy hh24:mi')) ;
 
 loop
 
    fetch vc into v_query,v_hash,v_addr,v_sql_id,v_mem,v_parses;
    exit when vc%notfound; 

     v_colname.delete;
     v_Ycnt.delete;
     v_count:=-1;
     v_no:=0;
     v_all_no:=-1;

         PIPE ROW('================================================================');
	 PIPE ROW('Addr: '||v_addr||'  Hash_Value: '||v_hash||'  SQL_ID '||v_sql_id);
	 PIPE ROW('Sharable_Mem: '||v_mem||' bytes   Parses: '||v_parses);
	 PIPE ROW('Stmt: '); 
	 for i in 0 .. trunc(length(v_query)/64) loop
	  PIPE ROW(i||' '||substr(v_query,1+i*64,64)); 
	 end loop; 
 
	 v_query:='';

	 SELECT COLUMN_NAME,0 bulk collect into v_colname,v_Ycnt
	   from cols 
	  where table_name='SQL_SHARED_CURSOR'
	    and DATA_LENGTH=1
	 order by column_id;

	 for i in 1 .. v_colname.count loop
	  v_query:= v_query ||','|| v_colname(i);
	 end loop;
	 v_query:= 'SELECT '||substr(v_query,2) || ' FROM SQL_SHARED_CURSOR ';

	 if v_sql_id is not null then
	  v_query:=v_query ||' WHERE SQL_ID='''||v_sql_id||'''';
	 else
	  v_query:=v_query ||' WHERE '||v_coladdr||'=HEXTORAW('''||V_ADDR||''')';     
	 end if;
               
	 begin
	  theCursor := dbms_sql.open_cursor;
	  sys.dbms_sys_sql.parse_as_user( theCursor, v_Query, dbms_sql.native );

	  for i in 1 .. v_colname.count loop
	   dbms_sql.define_column( theCursor, i, columnValue, 8000 );
	  end loop;

	  status := dbms_sql.execute(theCursor);

	  while (dbms_sql.fetch_rows(theCursor) >0) loop
	   v_no:=0;
	   v_count:=v_count+1;
	   for i in 1..v_colname.count loop
	    dbms_sql.column_value(theCursor, i, columnValue);

	    if columnValue='Y' then
	     v_Ycnt(i):=v_Ycnt(i)+1;
	    else
	     v_no:=v_no+1;
	    end if;
	   end loop;
	   if v_no=v_colname.count then
	    v_all_no:=v_all_no+1;
	   end if;
	  end loop;
	  dbms_sql.close_cursor(theCursor);
	 end;
	 PIPE ROW('');
	 PIPE ROW('Versions Summary');
	 PIPE ROW('----------------');
	 for i in 1 .. v_colname.count loop
	  if v_Ycnt(i)>0 then 
	   PIPE ROW(v_colname(i)||' :'||v_Ycnt(i));
	  end if;
	 end loop;
	 If v_all_no>1 then 
	  PIPE ROW('Versions with ALL Columns as "N" :'||v_all_no);
	 end if;
	 PIPE ROW('Total Versions:'||v_count);
	 PIPE ROW(' ');
 
 end loop;
 
  for i in 1 .. v_colname.count loop
 
   if v_Ycnt(i)>0 then 

    PIPE ROW('-----------------------------');
    PIPE ROW('Details for '||v_colname(i)||' :');
    PIPE ROW('');
    if ( v_colname(i) in ('BIND_MISMATCH','USER_BIND_PEEK_MISMATCH','BIND_EQUIV_FAILURE','BIND_UACS_DIFF')  
            or  (v_version like '11.1%' and v_colname(i)='ROW_LEVEL_SEC_MISMATCH')) then
     if v_bind_dumped=true then -- Dump only once 
      PIPE ROW('Details shown already.');
     else
      v_bind_dumped:=true;
      if v_version like '9%' then
       PIPE ROW('No details for '||v_version);
      else
       PIPE ROW('Consolidated details for :');
       PIPE ROW('BIND_MISMATCH,USER_BIND_PEEK_MISMATCH,BIND_UACS_DIFF and');
       PIPE ROW('BIND_EQUIV_FAILURE (Mislabled as ROW_LEVEL_SEC_MISMATCH BY bug 6964441 in 11gR1)');
       PIPE ROW('');
       declare 
        v_position num_arr;
        v_maxlen num_arr;
        v_minlen num_arr;
        v_dtype num_arr;
        v_prec num_arr;
        v_scale num_arr;
        v_n num_arr;
       
       begin
        v_query:='select position,min(max_length),max(max_length),datatype,precision,scale,count(*) n'
               ||' from v$sql_bind_capture where sql_id=:v_sql_id'
               ||' group by sql_id,position,datatype,precision,scale'
               ||' order by sql_id,position,datatype,precision,scale';
        
        EXECUTE IMMEDIATE v_query
        bulk collect into v_position, v_minlen, v_maxlen , v_dtype ,v_prec ,v_scale , v_n 
        using v_sql_id;
        
        PIPE ROW('from v$sql_bind_capture');
        PIPE ROW('COUNT(*) POSITION MIN(MAX_LENGTH) MAX(MAX_LENGTH) DATATYPE (PRECISION,SCALE)');
        PIPE ROW('======== ======== =============== =============== ======== ================');
        for c in 1 .. v_position.count loop
         PIPE ROW( to_char(v_n(c),'9999999')||' '||to_char(v_position(c),'9999999')||' '|| to_char(v_minlen(c),'99999999999999')
                  ||' '|| to_char(v_maxlen(c),'99999999999999')
                  ||' '|| to_char(v_dtype(c),'9999999')||' ('|| v_prec(c)||','||v_scale(c)||')' );       
        end loop;

        if v_version like '11%' then            
         v_query:='select sum(decode(IS_OBSOLETE,''Y'', 1, 0)),sum(decode(IS_BIND_SENSITIVE ,''Y'',1, 0))'
                ||',sum(decode(IS_BIND_AWARE,''Y'',1,0)),sum(decode(IS_SHAREABLE,''Y'',1,0))'
                ||' from v$sql where sql_id = :v_sql_id';     
       
         EXECUTE IMMEDIATE v_query
         bulk collect into v_position, v_minlen, v_maxlen , v_dtype  
         using v_sql_id;

         PIPE ROW('');
         PIPE ROW('SUM(DECODE(column,Y, 1, 0) FROM V$SQL');
         PIPE ROW('IS_OBSOLETE IS_BIND_SENSITIVE IS_BIND_AWARE IS_SHAREABLE');
         PIPE ROW('=========== ================= ============= ============');
         for c in 1 .. v_position.count loop
          PIPE ROW(to_char(v_position(c),'9999999999')||' '|| to_char(v_minlen(c),'9999999999999999')
                  ||' '|| to_char(v_maxlen(c),'999999999999')
                  ||' '|| to_char(v_dtype(c),'99999999999'));       
         end loop;       
        end if;     
       end;
      end if;    
     end if;
    elsif v_colname(i) ='OPTIMIZER_MODE_MISMATCH' then     
      for c in (select OPTIMIZER_MODE,count(*) n from v$sql where hash_value=v_hash group by OPTIMIZER_MODE) loop
       PIPE ROW(c.n||' versions with '||c.OPTIMIZER_MODE);  
      end loop;
    elsif v_colname(i) ='OPTIMIZER_MISMATCH' then 
      if v_version like '9%' then
       PIPE ROW('No details available for '||v_version);
      else 
       declare
        v_param vc_arr;
        v_value vc_arr;
        v_n num_arr;
       begin
        v_query:='select o.NAME,o.VALUE ,count(*) n '
                   ||'from V$SQL_OPTIMIZER_ENV o,sql_shared_cursor s '
                   ||'where ISDEFAULT=''NO'' '
                   ||'  and OPTIMIZER_MISMATCH=''Y'' '
                   ||'  and s.sql_id=:v_sql_id '
                   ||'  and o.sql_id=s.sql_id '
                   ||'  and o.CHILD_ADDRESS=s.CHILD_ADDRESS '
                   ||' group by o.NAME,o.VALUE ';
        EXECUTE IMMEDIATE v_query
        bulk collect into v_param,v_value,v_n using v_sql_id ;
      
        for c in 1 .. v_param.count loop
         PIPE ROW(v_n(c)||' versions with '||v_param(c)||' = '||v_value(c));
        end loop;
       end;
      end if; 
    else
     PIPE ROW('No details available');
    end if;
   end if;
 end loop;
 IF v_version not like '9%' then 
  PIPE ROW('####');
  PIPE ROW('To further debug Ask Oracle Support for the appropiate level LLL.');
  if v_version in ('10.2.0.1.0','10.2.0.2.0','10.2.0.3.0') THEN 
   PIPE ROW('and read note:457225.1 Cannot turn off Trace after setting CURSORTRACE EVENT');
  end if;
  PIPE ROW('alter session set events ');
  PIPE ROW(' ''immediate trace name cursortrace address '||v_hash||', level LLL'';');
  PIPE ROW('To turn it off do use address 1, level 2147483648');
 end if;
 PIPE ROW('================================================================'); 
 exception
  when others then
   PIPE ROW('Error :'||sqlerrm);
   PIPE ROW('for Addr: '||v_addr||'  Hash_Value: '||v_hash||'  SQL_ID '||v_sql_id);
end;  
/
