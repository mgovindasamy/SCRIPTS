select count(*)
        from v$bh
        where objd= (select data_object_id from user_objects where object_name='T')
                and status='xcur';
				
				
select decode(status,'free', 'Free', 'xcur', 'Read and Modified',
                    'cr','Read and Not Modified', 'read', 'Currently Being Read',
                    'Other')  buffer_state,
       count(*) buffer_count
  from v$bh
 group by decode(status,'free', 'Free', 'xcur', 'Read and Modified',
                    'cr','Read and Not Modified', 'read', 'Currently Being Read',
                    'Other');
					
SELECT a.INST_ID, decode(b.tablespace_name,null,'UNUSED',b.tablespace_name) ts_name,					
        a.file# file_number,
   COUNT(a.block#) Blocks,
 COUNT (DISTINCT a.file# || a.block#) Distinct_blocks
    FROM GV$BH a, dba_data_files b
    WHERE a.file#=b.file_id(+)
    GROUP BY a.INST_ID, a.file#,decode(b.tablespace_name,null,'UNUSED',b.tablespace_name)
    order by a.inst_id
 /
 
 select       ss.sql_id,
            sum(ss.PX_SERVERS_EXECS_total) px_servers,
            decode(sum(ss.io_offload_elig_bytes_total),0,'No','Yes') offloadelig,
            decode(sum(ss.io_offload_elig_bytes_total),0,'Yes','No') impx,
            sum(ss.io_offload_elig_bytes_total)/1024/1024 offloadbytes,
            sum(ss.elapsed_time_total)/1000000/sum(ss.px_servers_execs_total) elps,
            dbms_lob.substr(st.sql_text,60,1) st
    from dba_hist_sqlstat ss, dba_hist_sqltext st
    where ss.px_servers_execs_total > 0
    and ss.sql_id=st.sql_id
    and upper(st.sql_text) like '%CACHED2%'
    group by ss.sql_id,dbms_lob.substr(st.sql_text,60,1)
    order by 5
/



V$SQLSTATS

select       ss.sql_id,
            sum(ss.PX_SERVERS_EXECUTIONS) px_servers,
            decode(sum(ss.IO_CELL_OFFLOAD_ELIGIBLE_BYTES),0,'No','Yes') offloadelig,
            decode(sum(ss.IO_CELL_OFFLOAD_ELIGIBLE_BYTES),0,'Yes','No') impx,
            sum(ss.IO_CELL_OFFLOAD_ELIGIBLE_BYTES)/1024/1024 offloadbytes,
            sum(ss.ELAPSED_TIME)/1000000/sum(ss.PX_SERVERS_EXECUTIONS) elps,
            dbms_lob.substr(st.sql_text,60,1) st
    from V$SQLSTATS ss, V$SQLtext st
    where ss.PX_SERVERS_EXECUTIONS > 0
    and ss.sql_id=st.sql_id
    and upper(st.sql_text) like '%CACHED2%'
    group by ss.sql_id,dbms_lob.substr(st.sql_text,60,1)
    order by 5
/


select   ss.sql_id,
            sum(ss.executions_total) execs,
            sum(ss.PX_SERVERS_EXECS_total)/decode(sum(ss.executions_total),0,1) px_servers,
            decode(sum(ss.io_offload_elig_bytes_total),0,'No','Yes') offloadelig,
            decode(sum(ss.io_offload_elig_bytes_total),0,'Yes','No') impx,
            sum(ss.io_offload_elig_bytes_total)/1024/1024 offloadbytes,
sum(ss.elapsed_time_total)/1000000/decode(sum(ss.executions_total),0,1)/sum(ss.px_servers_execs_total) elps,
            dbms_lob.substr(st.sql_text,30,1) st
    from dba_hist_sqlstat ss, dba_hist_sqltext st
   where ss.px_servers_execs_total > 0
   and ss.sql_id=st.sql_id
   and upper(st.sql_text) like '%CACHED2%'
   group by ss.sql_id,dbms_lob.substr(st.sql_text,30,1)
   order by 5
 /
