#######################################################
# List All tables of schema
#######################################################

set pages 999 lines 100
col table_name format a40	
select OWNER,TABLE_NAME,PARTITIONED from dba_tables where owner='&owner' order by PARTITIONED;


#######################################################
# List partitioned tables
#######################################################

set pages 999 lines 100
col table_name format a40
select	table_name,	partitioning_type type,	partition_count partitions,INTERVAL
from	dba_part_tables
where	owner = '&owner'
order by 1
/

#######################################################
# List a tables partitions
#######################################################

set pages 999 lines 180
col high_value format a60
col tablespace_name format a20
select	partition_name
,	tablespace_name
,	high_value
from	dba_tab_partitions
where	table_owner = '&owner'
and	table_name = '&table_name'
order by partition_position
/

#######################################################
# List a tables partitions
#######################################################
select a.table_name,a.partitioned,PARTITION_COUNT,SUBPARTITIONING_TYPE,DEF_SUBPARTITION_COUNT,
PARTITION_COUNT*(case DEF_SUBPARTITION_COUNT 
when 0 then 1
else DEF_SUBPARTITION_COUNT
end) total_part from dba_tables a,dba_part_tables b where a.owner='&owner'
and a.table_name=b.table_name 
order by 1;

#######################################################
# Show partition sizes for the specified table
#######################################################

set pages 999 lines 100
col tablespace_name format a20
col num_rows format 999,999,999
select	p.partition_name
,	p.tablespace_name
,	p.num_rows
,	ceil(s.bytes / 1024 / 1204) mb
from	dba_tab_partitions p
,	dba_segments s
where	p.table_owner = s.owner
and	p.partition_name = s.partition_name
and 	p.table_name = s.segment_name
and	p.table_owner = '&owner'
and	p.table_name = '&table_name'
order by partition_position
/


#######################################################
#	Reports partitioned tables from dba_part_tables
#######################################################


accept 1 prompt "Enter table owner: [Enter for ALL]: "
accept 2 prompt "Enter table name: [Enter for ALL]: "


set feedback off
alter session set nls_date_format='MON-DD hh24:mi:ss';
set feedback on


clear breaks
clear columns
clear computes
ttitle "Table Partitions"

set trims on
set pages 80
set verify off
set lines 80
--col table_name  format a30 trunc heading "Owner.Table"
col table_name  format a35 heading "Owner.Table"


spool s_tab_part.log

select owner||'.'||table_name table_name
, PARTITIONING_TYPE
, SUBPARTITIONING_TYPE 
, PARTITION_COUNT
FROM dba_part_tables
WHERE DECODE(UPPER('&&1'),NULL,'x',owner) = NVL(UPPER('&&1'),'x')
AND   DECODE(UPPER('&&2'),NULL,'x',table_name) = NVL(UPPER('&&2'),'x')
ORDER BY 1,2
/

set lines 300
col high_value format a10
col composite format a3 heading "CMP"
col partition_position format 999 heading "Pos"
col subpartition_count format 999 heading "Cnt"
col init_kb format 999999 heading "Init KB"
col next_kb format 999999 heading "Next KB"
col num_rows format 9999999 heading "Num Rows"
col pct_increase format 999 heading "Pct|Inc"
col partition_name format a30 heading "Part Name"
col tablespace_name format a10 heading "Tabsp Name"
break on table_name skip 1

SELECT
 table_owner||'.'||table_name table_name
,composite
,partition_name
,subpartition_count
--,high_value
,partition_position
,tablespace_name
,initial_extent/1024 init_kb
,next_extent/1024 next_kb
,pct_increase
,num_rows
,last_analyzed
FROM dba_tab_partitions
WHERE DECODE(UPPER('&&1'),NULL,'x',table_owner) = NVL(UPPER('&&1'),'x')
AND   DECODE(UPPER('&&2'),NULL,'x',table_name) = NVL(UPPER('&&2'),'x')
ORDER BY 1,3
/

spool off

undefine 1
undefine 2


#######################################################
#	List all details of a single partition
#######################################################
column	columntitle  format a80 newline
column	columnname  format a50 newline
column	columnvalue format a40	
set	heading off

select		'Column Name           				Column Value'						columntitle,
		'~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~'	columntitle,
'TABLE_OWNER                            :' columnname, TABLE_OWNER      columnvalue,
'TABLE_NAME                             :' columnname, TABLE_NAME       columnvalue,
'COMPOSITE                              :' columnname, COMPOSITE        columnvalue,
'PARTITION_NAME                         :' columnname, PARTITION_NAME   columnvalue,
'HIGH_VALUE                             :' columnname, HIGH_VALUE       columnvalue,
'TABLESPACE_NAME                        :' columnname, TABLESPACE_NAME  columnvalue,
'LOGGING                                :' columnname, LOGGING  columnvalue,
'COMPRESSION                            :' columnname, COMPRESSION      columnvalue,
'COMPRESS_FOR                           :' columnname, COMPRESS_FOR     columnvalue,
'LAST_ANALYZED                          :' columnname, LAST_ANALYZED    columnvalue,
'BUFFER_POOL                            :' columnname, BUFFER_POOL      columnvalue,
'FLASH_CACHE                            :' columnname, FLASH_CACHE      columnvalue,
'CELL_FLASH_CACHE                       :' columnname, CELL_FLASH_CACHE columnvalue,
'GLOBAL_STATS                           :' columnname, GLOBAL_STATS     columnvalue,
'USER_STATS                             :' columnname, USER_STATS       columnvalue,
'IS_NESTED                              :' columnname, IS_NESTED        columnvalue,
'PARENT_TABLE_PARTITION                 :' columnname, PARENT_TABLE_PARTITION   columnvalue,
'INTERVAL                               :' columnname, INTERVAL columnvalue,
'SEGMENT_CREATED                        :' columnname, SEGMENT_CREATED  columnvalue,
'SUBPARTITION_COUNT                     :' columnname,  to_char(SUBPARTITION_COUNT)     columnvalue,
'HIGH_VALUE_LENGTH                      :' columnname,  to_char(HIGH_VALUE_LENGTH)      columnvalue,
'PARTITION_POSITION                     :' columnname,  to_char(PARTITION_POSITION)     columnvalue,
'PCT_FREE                               :' columnname,  to_char(PCT_FREE)       columnvalue,
'PCT_USED                               :' columnname,  to_char(PCT_USED)       columnvalue,
'INI_TRANS                              :' columnname,  to_char(INI_TRANS)      columnvalue,
'MAX_TRANS                              :' columnname,  to_char(MAX_TRANS)      columnvalue,
'INITIAL_EXTENT                         :' columnname,  to_char(INITIAL_EXTENT) columnvalue,
'NEXT_EXTENT                            :' columnname,  to_char(NEXT_EXTENT)    columnvalue,
'MIN_EXTENT                             :' columnname,  to_char(MIN_EXTENT)     columnvalue,
'MAX_EXTENT                             :' columnname,  to_char(MAX_EXTENT)     columnvalue,
'MAX_SIZE                               :' columnname,  to_char(MAX_SIZE)       columnvalue,
'PCT_INCREASE                           :' columnname,  to_char(PCT_INCREASE)   columnvalue,
'FREELISTS                              :' columnname,  to_char(FREELISTS)      columnvalue,
'FREELIST_GROUPS                        :' columnname,  to_char(FREELIST_GROUPS)        columnvalue,
'NUM_ROWS                               :' columnname,  to_char(NUM_ROWS)       columnvalue,
'BLOCKS                         		:' columnname,  to_char(BLOCKS) columnvalue,
'EMPTY_BLOCKS                           :' columnname,  to_char(EMPTY_BLOCKS)   columnvalue,
'AVG_SPACE                              :' columnname,  to_char(AVG_SPACE)      columnvalue,
'CHAIN_CNT                              :' columnname,  to_char(CHAIN_CNT)      columnvalue,
'AVG_ROW_LEN                            :' columnname,  to_char(AVG_ROW_LEN)    columnvalue,
'SAMPLE_SIZE                            :' columnname,  to_char(SAMPLE_SIZE)    columnvalue,
		'~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~'	columntitle
from		DBA_TAB_PARTITIONS
where		table_name ='&table_name'
and PARTITION_NAME='&PARTITION_NAME'
;

#######################################################
#	Reports table subpartition details
#######################################################


accept 1 prompt "Enter table owner: [Enter for ALL]: "
accept 2 prompt "Enter table name: [Enter for ALL]: "


set feedback off
alter session set nls_date_format='MON-DD hh24:mi:ss';
set feedback on


clear breaks
clear computes
ttitle "Subpartitions"

set trims on
set pages 60
set verify off
set lines 132
col table_name  format a25 trunc heading "Owner.Table"
col part        format a10       heading "Partition"
col subpart     format a24       heading "Tablespace.Subpart"
col num_rows    format 99999999  heading "Num Of Rows"
col blocks      format 99999     heading "Blks"
col eblocks     format 99999     heading "Empty|Blks"
col avg_row_len format 99999     heading "Avg|Row|Len"
col sample_size format 99999     heading "Sample|Size"

break on table_name skip 2
compute sum of num_rows on table_name

  SELECT table_owner||'.'||table_name table_name,
         partition_name part,
         tablespace_name||'.'||subpartition_name subpart,
         num_rows,
         avg_row_len,
         blocks,
         empty_blocks eblocks,
         last_analyzed "Last Analyzed",
         sample_size
    FROM dba_tab_subpartitions
   WHERE DECODE(UPPER('&&1'),NULL,'x',table_owner) = NVL(UPPER('&&1'),'x')
     AND DECODE(UPPER('&&2'),NULL,'x',table_name) = NVL(UPPER('&&2'),'x')
ORDER BY 1,2,subpartition_position
;

spool s_tab_subpart.log
/
spool off


undefine 1
undefine 2

#######################################################
REM	I use this script on tables that are not yet
REM	partitioned but need to be partitioned.
REM	It allows me to figure out number of subpartitions.
#######################################################
REM	STRATEGY:
REM 	+------------------------------------------+
REM 	Goal:
REM 	        20 EXTENTS per SUBPARTITION
REM 	Rule:   
REM 	        2sp     for 0-40        EXTENT TABLE
REM 	        8sp     for 41-160      EXTENT TABLE
REM 	        16sp    for 161+        EXTENT TABLE
REM 	+------------------------------------------+

set pages 66
set lines 132
set trims on
set verify off

col sub_part format 99 heading "Sp"
accept owner prompt "Enter value for object owner: "


col seg_type format a15
col segment_name format a35

select owner||'.'||substr(SEGMENT_TYPE,1,10) seg_type
,      SEGMENT_NAME
,      '16' sub_part
,      EXTENTS
,      ROUND(EXTENTS/16) ext_per_sub
,      bytes/1024/1024 mbytes
,      bytes/1024 kbytes
from   dba_segments
where  owner='&&owner'
and    segment_name like '&&tab_name_like'
and    EXTENTS > 160
and    segment_type not like 'INDEX%'
UNION ALL
select owner||'.'||substr(SEGMENT_TYPE,1,10) seg_type
,      SEGMENT_NAME
,      '8' sub_part
,      EXTENTS
,      ROUND(EXTENTS/8) ext_per_sub
,      bytes/1024/1024 mbytes
,      bytes/1024 kbytes
from   dba_segments
where  owner='&&owner'
and    segment_name like '&&tab_name_like'
and    (EXTENTS <= 160 and EXTENTS > 40)
and    segment_type not like 'INDEX%'
UNION ALL
select owner||'.'||substr(SEGMENT_TYPE,1,10) seg_type
,      SEGMENT_NAME
,      '2' sub_part
,      EXTENTS
,      ROUND(EXTENTS/2) ext_per_sub
,      bytes/1024/1024 mbytes
,      bytes/1024 kbytes
from   dba_segments
where  owner='&&owner'
and    segment_name like '&&tab_name_like'
and    EXTENTS <= 40
and    segment_type not like 'INDEX%'
order by 1
,        2

spool SEGS_size_&&owner..&&tab_name_like..log
/
/*
+------------------------------------------+
Goal:
        20 EXTENTS per SUBPARTITION
Rule:   
        2sp     for 0-40        EXTENT TABLE
        8sp     for 41-160      EXTENT TABLE
        16sp    for 161+        EXTENT TABLE
+------------------------------------------+
*/
spool off


undefine owner

##########################################################
List Table partitions type and 
their high value for all non-sys tables
##########################################################

set line 190 pages 1244
set serverout on
DECLARE
   v_table_name    VARCHAR2 (4000);
   v_part_type     VARCHAR2 (4000);
   v_part_col      VARCHAR2 (4000);
   v_high_value    VARCHAR2 (4000);
   v_high_value2   VARCHAR2 (4000);
BEGIN
         DBMS_OUTPUT.put_line (   RPAD ('TABLE_NAME', 50, ' ')
                               || '			'
                               || RPAD ('PART_TYPE', 20, ' ')
                               || '			'
                               || RPAD ('PART_COL', 30, ' ')
                               || '			'
                               || RPAD ('high_value', 30, ' ')
                               || CHR (13)
                               || CHR (10)
                              );
   FOR rec IN (SELECT b.table_owner || '.' || b.table_name table_name,
                      high_value
                 FROM dba_tab_partitions b,
                      (SELECT   table_owner, table_name,
                                MAX (partition_position) partition_position
                           FROM dba_tab_partitions
                          WHERE table_owner NOT LIKE 'SYS%'
                       GROUP BY table_owner, table_name) a
                WHERE b.partition_position = a.partition_position
                  AND a.table_owner = b.table_owner
                  AND a.table_name = b.table_name)
   LOOP
      v_table_name := rec.table_name;
      v_high_value := rec.high_value;

      SELECT partitioning_type || '->' || subpartitioning_type
        INTO v_part_type
        FROM dba_part_tables
       WHERE owner || '.' || table_name = v_table_name;

      SELECT unique a.column_name || '(' || b.data_type || ')'
        INTO v_part_col
        FROM dba_part_key_columns a, dba_tab_columns b
       WHERE a.column_name = b.column_name
         AND a.owner = b.owner
         AND a.NAME = b.table_name
         AND b.owner || '.' || b.table_name = v_table_name
         AND a.owner || '.' || a.NAME = v_table_name;

      IF REGEXP_SUBSTR (v_high_value, '[^ ]+', 1, 2) LIKE '20%'
      THEN

         DBMS_OUTPUT.put_line (   RPAD (v_table_name, 50, ' ')
                               || '			'
                               || RPAD (v_part_type, 20, ' ')
                               || '			'
                               || RPAD (v_part_col, 30, ' ')
                               || '			'
                               || RPAD (REGEXP_SUBSTR (v_high_value, '[^ ]+', 1, 2), 30, ' ')
                              );
      ELSE
         DBMS_OUTPUT.put_line (   RPAD (v_table_name, 50, ' ')
                               || '			'
                               || RPAD (v_part_type, 20, ' ')
                               || '			'
                               || RPAD (v_part_col, 30, ' ')
                               || '			'
                               || RPAD (v_high_value, 30, ' ')
                              );
      END IF;
   END LOOP;
END;
/

WITH seg AS
     (SELECT   owner, table_name,
               ROUND (SUM (BYTES) / 1024 / 1024 / 1024, 2) size_gb
          FROM (SELECT segment_name table_name, owner, BYTES
                  FROM dba_segments
                 WHERE segment_type IN
                           ('TABLE', 'TABLE PARTITION', 'TABLE SUBPARTITION')
                   AND owner = '&&1'
                UNION ALL
                SELECT l.table_name, l.owner, s.BYTES
                  FROM dba_lobs l, dba_segments s
                 WHERE s.segment_name = l.segment_name
                   AND s.owner = l.owner
                   AND s.segment_type IN
                          ('LOBSEGMENT', 'LOB SUBPARTITION', 'LOB PARTITION')
                   AND s.owner = '&&1')
      GROUP BY table_name, owner
        HAVING SUM (BYTES) / 1024 / 1024 > 10)
SELECT   a.owner || '.' || a.table_name NAME, a.partitioning_type,
         a.subpartitioning_type, a.partition_count, a.def_subpartition_count,
         b.column_name part_key_col, c.column_name subpart_key_col, a.status,
         a.def_tablespace_name, a.def_pct_free, a.def_initial_extent,
         d.initial_extent / 1024 / 1024 || 'M' initial_extent,
         a.def_next_extent, d.next_extent / 1024 / 1024 || 'M' next_extent,
         a.def_logging, a.def_compression, a.def_compress_for, a.INTERVAL,
         size_gb
    FROM dba_part_tables a,
         dba_part_key_columns b,
         dba_subpart_key_columns c,
         dba_segments d,
         seg e
   WHERE a.table_name = b.NAME(+)
     AND a.table_name = c.NAME(+)
     AND a.table_name = d.segment_name(+)
     AND a.table_name = e.table_name(+)
     AND a.owner = '&&1'
GROUP BY a.owner,
         a.table_name,
         a.partitioning_type,
         a.subpartitioning_type,
         a.partition_count,
         a.def_subpartition_count,
         b.column_name,
         c.column_name,
         a.status,
         a.def_tablespace_name,
         a.def_pct_free,
         a.def_initial_extent,
         d.initial_extent,
         a.def_next_extent,
         d.next_extent,
         a.def_logging,
         a.def_compression,
         a.def_compress_for,
         a.INTERVAL,
         e.size_gb;
		 
--For 10gb

WITH seg AS
     (SELECT   owner, table_name,
               ROUND (SUM (BYTES) / 1024 / 1024 / 1024, 2) size_gb
          FROM (SELECT segment_name table_name, owner, BYTES
                  FROM dba_segments
                 WHERE segment_type IN
                           ('TABLE', 'TABLE PARTITION', 'TABLE SUBPARTITION')
                   AND owner = '&&1'
                UNION ALL
                SELECT l.table_name, l.owner, s.BYTES
                  FROM dba_lobs l, dba_segments s
                 WHERE s.segment_name = l.segment_name
                   AND s.owner = l.owner
                   AND s.segment_type IN
                          ('LOBSEGMENT', 'LOB SUBPARTITION', 'LOB PARTITION')
                   AND s.owner = '&&1')
      GROUP BY table_name, owner
        --HAVING SUM (BYTES) / 1024 / 1024 > 10
		)
SELECT   a.owner || '.' || a.table_name NAME, a.partitioning_type,
         a.subpartitioning_type, a.partition_count, a.def_subpartition_count,
         b.column_name part_key_col, c.column_name subpart_key_col, a.status,
         a.def_tablespace_name, a.def_pct_free, a.def_initial_extent,
         d.initial_extent / 1024 / 1024 || 'M' initial_extent,
         a.def_next_extent, d.next_extent / 1024 / 1024 || 'M' next_extent,
         a.def_logging, a.def_compression, 
		 --a.def_compress_for, 
		 --a.INTERVAL,
         size_gb
    FROM dba_part_tables a,
         dba_part_key_columns b,
         dba_subpart_key_columns c,
         dba_segments d,
         seg e
   WHERE a.table_name = b.NAME(+)
     AND a.table_name = c.NAME(+)
     AND a.table_name = d.segment_name(+)
     AND a.table_name = e.table_name(+)
     AND a.owner = '&&1'
GROUP BY a.owner,
         a.table_name,
         a.partitioning_type,
         a.subpartitioning_type,
         a.partition_count,
         a.def_subpartition_count,
         b.column_name,
         c.column_name,
         a.status,
         a.def_tablespace_name,
         a.def_pct_free,
         a.def_initial_extent,
         d.initial_extent,
         a.def_next_extent,
         d.next_extent,
         a.def_logging,
         a.def_compression,
         --a.def_compress_for,
         --a.INTERVAL,
         e.size_gb;
		 
#######################################################################################
break on report
compute sum of sum_size_in_mb on report
SELECT /*+ parallel(a,12) */ segment_name, segment_type,count(segment_name) seg_count,round(max(BYTES)/1024/1024) max_size_in_mb,
round(avg(BYTES)/1024/1024) avg_size_in_mb, round(sum(BYTES)/1024/1024) sum_size_in_mb
  FROM dba_segments a
 WHERE (   segment_name = 'OLTP' and owner='DATPRD'
        OR segment_name IN (
                         SELECT segment_name
                           FROM dba_lobs
                          WHERE table_name =  'OLTP' and owner='DATPRD'
                         UNION
                         SELECT index_name
                           FROM dba_lobs
                          WHERE table_name =  'OLTP' and owner='DATPRD')
       )
group by segment_name, segment_type
order by SEGMENT_NAME, segment_type;



#######################################################################################2

ALTER TABLE TROUTEHUB_ORDERS_WITH_PART SET INTERVAL();

ALTER TABLE TROUTEHUB_ORDERS_WITH_PART SET INTERVAL(NUMTODSINTERVAL(1,'MONTH'));

ALTER TABLE IQDBO.TROUTEHUB_ORDERS_WITH_PART ADD PARTITION TP20062012 VALUES LESS THAN (TO_DATE('2012-06-22 00:00:00', 'SYYYY-MM-DD HH24:MI:SS'));

ALTER TABLE IQDBO.TROUTEHUB_ORDERS_WITH_PART DROP PARTITION TP20062012;

ALTER TABLE IQDBO.TROUTEHUB_ORDERS_WITH_PART EXCHANGE PARTITION SYS_P241 WITH TABLE IQDBO.TROUTEHUB_ORDERS_WITHOUT_PART;

ALTER TABLE IQDBO.TROUTEHUB_ORDERS_WITH_PART RENAME PARTITION SYS_P241 TO TP20120620;

ALTER TABLE  ORD_DOREP.T_APFS_FILE_SUM  ADD PARTITION TP201303  VALUES LESS THAN (TO_DATE('2013-04-01 00:00:00', 'SYYYY-MM-DD HH24:MI:SS'));
ALTER TABLE  ORD_DOREP.T_APFS_FILE_SUM  ADD PARTITION TP201304  VALUES LESS THAN (TO_DATE('2013-05-01 00:00:00', 'SYYYY-MM-DD HH24:MI:SS'));
ALTER TABLE  ORD_DOREP.T_APFS_FILE_SUM  ADD PARTITION TP201305  VALUES LESS THAN (TO_DATE('2013-06-01 00:00:00', 'SYYYY-MM-DD HH24:MI:SS'));


##########################################################
##Manually add table partition per day
##########################################################


select 'ALTER TABLE FXSPREAD.QUOTE_BLOTTER_LOG ADD   PARTITION TP'||to_char(sysdate-1,'yyyymmdd')||' VALUES LESS THAN (TO_DATE('''||to_char(trunc(sysdate),'SYYYY-MM-DD HH24:MI:SS')||'''', ',''SYYYY-MM-DD HH24:MI:SS'', ''NLS_CALENDAR=GREGORIAN'')) LOGGING NOCOMPRESS TABLESPACE FNFENSP1TS001 ; ' from dual;

ALTER TABLE FXSPREAD.QUOTE_BLOTTER_LOG ADD   PARTITION TP20130301 VALUES LESS THAN (TO_DATE(' 2013-03-02 00:00:00'
,'SYYYY-MM-DD HH24:MI:SS', 'NLS_CALENDAR=GREGORIAN')) LOGGING NOCOMPRESS TABLESPACE FNFENSP1TS001 ;


DECLARE
   start_date   VARCHAR2 (30);
   end_date     VARCHAR2 (30);
   tmp_date     DATE;
   string varchar2(32000);
BEGIN
   start_date := '20150306';
   end_date := '20150406';
   tmp_date := TO_DATE (start_date, 'yyyymmdd');

   WHILE tmp_date <= TO_DATE (end_date, 'yyyymmdd')
   LOOP
	  --TP20120813
	  --string := 'ALTER TABLE ORD_BATCHLOAD.BFEE_FLEXIBLE_FEES ADD  PARTITION TP'||to_char(tmp_date-1,'yyyymmdd')||' VALUES LESS THAN (TO_DATE('''||to_char(trunc(tmp_date),'SYYYY-MM-DD HH24:MI:SS')||''',''SYYYY-MM-DD HH24:MI:SS'', ''NLS_CALENDAR=GREGORIAN'')) LOGGING COMPRESS TABLESPACE ORD_DEV ; ';
	  --TP2457088_20150306
	  string := 'ALTER TABLE RW1.ACCT_BALANCE_SUM_HST ADD  PARTITION TP'||to_char(tmp_date-1,'j')||'_'||to_char(tmp_date-1,'yyyymmdd')||' VALUES LESS THAN (TO_DATE('''||to_char(trunc(tmp_date),'SYYYY-MM-DD HH24:MI:SS')||''',''SYYYY-MM-DD HH24:MI:SS'', ''NLS_CALENDAR=GREGORIAN'')) LOGGING COMPRESS FOR OLTP TABLESPACE DATA20 ; ';
	        DBMS_OUTPUT.put_line (string);
      tmp_date := tmp_date+ 1;
   END LOOP;
END;
/



##########################################################
##Manually add table partition per month
##########################################################

DECLARE
   start_date   VARCHAR2 (30);
   end_date     VARCHAR2 (30);
   tmp_date     DATE;
   string varchar2(32000);
BEGIN
   start_date := trunc(sysdate-100,'MONTH');
   end_date := trunc(sysdate+360,'MONTH');
   tmp_date := start_date;
    DBMS_OUTPUT.put_line (tmp_date);
    DBMS_OUTPUT.put_line (end_date);
   WHILE tmp_date <= end_date
   LOOP
	  string := 'ALTER TABLE DATPRD.ORA_DEV_INVENTORY  ADD  PARTITION TP'||to_char(tmp_date,'yyyy')||'M'||to_char(tmp_date-10,'mm')||' 
      VALUES LESS THAN (TO_DATE('''||to_char(tmp_date,'SYYYY-MM-DD HH24:MI:SS')||''',''SYYYY-MM-DD HH24:MI:SS'', ''NLS_CALENDAR=GREGORIAN'')) ; ';
	        DBMS_OUTPUT.put_line (string);
      tmp_date := add_months(tmp_date,1);
   END LOOP;
END;
/
##########################################################
--Convert HIGH_VALUE in to date
##########################################################

DECLARE
   CURSOR c1
   IS
      (SELECT table_owner, table_name, partition_name, high_value FROM dba_tab_partitions
        WHERE table_name = 'FNPL_PGR_LG' AND table_owner = 'WAS1DBO');

   v_table_owner      VARCHAR2 (100);
   v_table_name       VARCHAR2 (100);
   v_partition_name   VARCHAR2 (100);
   v_high_value       DATE;
   sql_stmt           VARCHAR2 (1000);
   v_sizemb           NUMBER;
BEGIN
   DBMS_OUTPUT.put_line ( 'table_owner'|| '	' || 'table_name' || '	' || 'partition_name' || '	' || 'high_value' || '	' || 'sizemb' );
   DBMS_OUTPUT.put_line ( ' ' );
   FOR rec IN c1
   LOOP
      sql_stmt := 'select ' || rec.high_value || ' from dual';

      EXECUTE IMMEDIATE sql_stmt INTO v_high_value;

      IF v_high_value > '01-DEC-01'
      THEN
         v_table_owner := rec.table_owner;
         v_table_name := rec.table_name;
         v_partition_name := rec.partition_name;

         SELECT ROUND (BYTES / 1024 / 1024)  INTO v_sizemb
			FROM dba_segments WHERE segment_name = rec.table_name AND owner = rec.table_owner AND partition_name = rec.partition_name; 
         DBMS_OUTPUT.put_line ( v_table_owner|| '	' || v_table_name || '	' || v_partition_name || '	' || v_high_value || '	' || v_sizemb );
      END IF;
   END LOOP;
END;
/

##########################################################
--Partition inventory
##########################################################

set line 190 pages 1244
set serverout on
DECLARE
   v_table_owner   VARCHAR2 (400);
   v_table_name    VARCHAR2 (400);
   v_part_name    VARCHAR2 (400);
   v_part_type     VARCHAR2 (400);
   v_part_sub_type     VARCHAR2 (400);
   --v_part_type_ind     VARCHAR2 (400);
   v_ind_type      VARCHAR2 (400);
   v_part_col      VARCHAR2 (400);
   v_high_value    VARCHAR2 (400);
   v_high_value2   VARCHAR2 (400);
BEGIN
/* 
         DBMS_OUTPUT.put_line (   RPAD ('TABLE_OWNER', 50, ' ')
                               || '|'
                               || RPAD ('TABLE_NAME', 50, ' ')
                               || '|'
                               || RPAD ('PARTITION_NAME', 20, ' ')
                               || '|'
                               || RPAD ('PART_TYPE', 20, ' ')
                               || '|'
                               --|| RPAD ('PART_IND_TYPE', 20, ' ')
                               --|| '|'
                               || RPAD ('IND_TYPE', 20, ' ')
                               || '|'
                               || RPAD ('HIGH_VALUE', 30, ' ')
                               || CHR (13)
                               || CHR (10)
                              );
                             */  
   FOR rec IN (SELECT b.table_owner table_owner, b.table_name table_name,
                      high_value,PARTITION_NAME
                 FROM dba_tab_partitions b,
                      (SELECT   table_owner, table_name,
                                MAX (partition_position) partition_position
                           FROM dba_tab_partitions
                          WHERE table_owner NOT IN ('SYS','SYSTEM')
                       GROUP BY table_owner, table_name) a
                WHERE b.partition_position = a.partition_position
                  AND a.table_owner = b.table_owner
                  AND a.table_name = b.table_name)
   LOOP
      v_table_name := rec.table_name;
      v_table_owner := rec.table_owner;
      v_high_value := rec.high_value;
      v_part_name := rec.PARTITION_NAME;

      SELECT t.partitioning_type , t.subpartitioning_type,
      --nvl(i.partitioning_type,'Nil') || '->' || nvl(i.subpartitioning_type,'Nil'), 
      nvl(min(LOCALITY),'Nil')
        INTO v_part_type,v_part_sub_type,
        --v_part_type_ind,
        v_ind_type
        FROM dba_part_tables t,dba_part_indexes i
       WHERE t.owner =v_table_owner and t.table_name = v_table_name
       and  t.owner =  i.owner(+)
       and  t.table_name =  i.table_name(+)
       group by t.partitioning_type,t.subpartitioning_type
       --,nvl(i.partitioning_type,'Nil') || '->' || nvl(i.subpartitioning_type,'Nil')
       ; 

       
/*       SELECT unique a.column_name || '(' || b.data_type || ')'
        INTO v_part_col
        FROM dba_part_key_columns a, dba_tab_columns b
       WHERE a.column_name = b.column_name
         AND a.owner = b.owner
         AND a.NAME = b.table_name
         AND b.owner || '|' || b.table_name = v_table_name
         AND a.owner || '|' || a.NAME = v_table_name; */
         
       IF REGEXP_SUBSTR (v_high_value, '[^ ]+', 1, 2) LIKE '____-%'
      THEN

         DBMS_OUTPUT.put_line (   v_table_owner
                               || '|'
                               || v_part_name
                               || '|'
                               || v_part_name
                               || '|'
                               || v_part_type
                               || '|'
                               || v_part_sub_type
                               --|| '|'
                               --|| v_part_col
                               || '|'                       
                               --|| v_part_type_ind,
                               --|| '|'
                               || v_ind_type
                               || '|'
                               || REGEXP_SUBSTR (v_high_value, '[^ ]+', 1, 2)
                              );
      ELSE
         DBMS_OUTPUT.put_line (   v_table_owner
                               || '|'
                               || v_table_name
                               || '|'
                               || v_part_name
                               || '|'
                               || v_part_type
                               || '|'
                               || v_part_sub_type
                               --|| '|'
                               --|| v_part_col
                               || '|'                       
                               --|| v_part_type_ind,
                               --|| '|'
                               || v_ind_type
                               || '|'
                               || v_high_value
                              );
      END IF;
   END LOOP;
END;
/
##########################################################

######################
-- year end partition high_value check highvalue
######################

set line 190 pages 1244
set serverout on
DECLARE
   v_table_name    VARCHAR2 (4000);
   v_part_type     VARCHAR2 (4000);
   v_part_col      VARCHAR2 (4000);
   v_high_value    VARCHAR2 (4000);
   v_high_value2   VARCHAR2 (4000);
BEGIN
/*          DBMS_OUTPUT.put_line (   'DB_NAME'
                               || '|'
                               || 'SERVER_HOST'
                               || '|'
                               || RPAD ('TABLE_NAME', 50, ' ')
                               || '|'
                               || RPAD ('PART_TYPE', 20, ' ')
                               || '|'
                               || RPAD ('PART_COL', 30, ' ')
                               || '|'
                               || RPAD ('high_value', 30, ' ')
                               || CHR (13)
                               || CHR (10)
                              ); */
   FOR rec IN (SELECT b.table_owner || '.' || b.table_name table_name,
                      high_value
                 FROM dba_tab_partitions b,
                      (SELECT   table_owner, table_name,
                                MAX (partition_position) partition_position
                           FROM dba_tab_partitions
                          WHERE table_owner NOT LIKE 'SYS%'
						  and HIGH_VALUE_LENGTH<>8						
                       GROUP BY table_owner, table_name) a
                WHERE b.partition_position = a.partition_position
                  AND a.table_owner = b.table_owner
                  AND a.table_name = b.table_name)
   LOOP
      v_table_name := rec.table_name;
      v_high_value := rec.high_value;

      SELECT partitioning_type || '->' || subpartitioning_type
        INTO v_part_type
        FROM dba_part_tables
       WHERE owner || '.' || table_name = v_table_name;

      SELECT unique a.column_name || '(' || b.data_type || ')'
        INTO v_part_col
        FROM dba_part_key_columns a, dba_tab_columns b
       WHERE a.column_name = b.column_name
         AND a.owner = b.owner
         AND a.NAME = b.table_name
         AND b.owner || '.' || b.table_name = v_table_name
         AND a.owner || '.' || a.NAME = v_table_name;

      IF REGEXP_SUBSTR (v_high_value, '[^ ]+', 1, 2) LIKE '20%'
      THEN

         DBMS_OUTPUT.put_line (   sys_context('USERENV', 'DB_NAME')
		                       || '|'
							   || sys_context('USERENV', 'SERVER_HOST')
		                       || '|'
							   || RPAD (v_table_name, 50, ' ')
                               || '|'
                               || RPAD (v_part_type, 20, ' ')
                               || '|'
                               || RPAD (v_part_col, 30, ' ')
                               || '|'
                               || RPAD (REGEXP_SUBSTR (v_high_value, '[^ ]+', 1, 2), 30, ' ')
                              );
      ELSE
         DBMS_OUTPUT.put_line (   sys_context('USERENV', 'DB_NAME')
		                       || '|'
							   || sys_context('USERENV', 'SERVER_HOST')
		                       || '|'
							   || RPAD (v_table_name, 50, ' ')
                               || '|'
                               || RPAD (v_part_type, 20, ' ')
                               || '|'
                               || RPAD (v_part_col, 30, ' ')
                               || '|'
                               || RPAD (v_high_value, 30, ' ')
                              );
      END IF;
   END LOOP;
END;
/

#########################################
--find maxvalue partitions in a schema
#########################################
/* Formatted on 01/30/2014 12:43:05 PM (QP5 v5.163.1008.3004) */
BEGIN
   FOR rec
      IN (WITH MAX
               AS (  SELECT MAX (PARTITION_POSITION) MAX_PARTITION_POSITION,
                            table_name
                       FROM dba_tab_partitions
                      WHERE table_owner = UPPER ('&owner')
                   --AND table_name = UPPER ('TP')
                   GROUP BY table_name)
          SELECT a.table_owner,
                 a.table_name,
                 a.high_value,
                 a.high_value_length
            FROM dba_tab_partitions a, MAX
           WHERE     table_owner = UPPER ('&owner')
                 AND a.table_name = MAX.table_name
                 AND PARTITION_POSITION = MAX_PARTITION_POSITION)
   LOOP
      IF SUBSTR (rec.high_value, 1, rec.high_value_length) = 'MAXVALUE'
      THEN
         DBMS_OUTPUT.put_line (rec.table_owner || ' ' || rec.table_name || ' ' || rec.high_value);
      END IF;
   END LOOP;
END;
/


##################################################
--ORA-39726: unsupported add/drop column operation on compressed tables
--https://activeoracle.wordpress.com/2015/09/28/exadata-ora-39726-unsupported-adddrop-column-operation-on-compressed-tables/
##################################################

> CREATE TABLE sales
  2    ( prod_id       NUMBER(6)
  3    , cust_id       NUMBER
  4    , time_id       DATE
  5    , channel_id    CHAR(1)
  6    , promo_id      NUMBER(6)
  7    , quantity_sold NUMBER(3)
  8    , amount_sold   NUMBER(10,2)
  9    )
 10   PARTITION BY RANGE (time_id)
 11   ( PARTITION sales_q1_2006 VALUES LESS THAN (TO_DATE('01-APR-2006','dd-MON-yyyy'))
 12   , PARTITION sales_q2_2006 VALUES LESS THAN (TO_DATE('01-JUL-2006','dd-MON-yyyy'))
 13   , PARTITION sales_q3_2006 VALUES LESS THAN (TO_DATE('01-OCT-2006','dd-MON-yyyy'))
 14   , PARTITION sales_q4_2006 VALUES LESS THAN (TO_DATE('01-JAN-2007','dd-MON-yyyy'))
 15   );
 
> alter table sales move partition sales_q1_2006 compress for oltp;

Table altered.

> alter table sales add  c1 varchar2(1) default 'n';
alter table sales add  c1 varchar2(1) default 'n'
                       *
ERROR at line 1:
ORA-39726: unsupported add/drop column operation on compressed tables


> alter table sales add  c1 varchar2(1);

Table altered.


> alter table sales move partition sales_q2_2006 compress for query high;

Table altered.

> alter table sales move partition sales_q3_2006 compress for query high;

Table altered.

> alter table sales move partition sales_q4_2006 compress for query high;

Table altered.

> alter table sales add  c2 varchar2(1) default 'n';

Table altered.

>  alter table sales move partition sales_q4_2006 nocompress;

Table altered.

> alter table sales add  c4 varchar2(1) default 'n';

Table altered.
