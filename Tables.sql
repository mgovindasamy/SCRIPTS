#######################################################
#	List all details of a table
#######################################################
column  columntitle  format a80 newline
column  columnname  format a50 newline
column  columnvalue format a40
set     heading off

select          'Column Name                                    Column Value'                                           columntitle,
'~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~'     columntitle,
'OWNER                                  :' columnname, OWNER    columnvalue,
'TABLE_NAME                             :' columnname, TABLE_NAME       columnvalue,
'TABLESPACE_NAME                        :' columnname, TABLESPACE_NAME  columnvalue,
'CLUSTER_NAME                           :' columnname, CLUSTER_NAME     columnvalue,
'IOT_NAME                               :' columnname, IOT_NAME columnvalue,
'STATUS                                 :' columnname, STATUS   columnvalue,
'PCT_FREE                               :' columnname,  to_char(PCT_FREE)       columnvalue,
'PCT_USED                               :' columnname,  to_char(PCT_USED)       columnvalue,
'INI_TRANS                              :' columnname,  to_char(INI_TRANS)      columnvalue,
'MAX_TRANS                              :' columnname,  to_char(MAX_TRANS)      columnvalue,
'INITIAL_EXTENT                         :' columnname,  to_char(INITIAL_EXTENT) columnvalue,
'NEXT_EXTENT                            :' columnname,  to_char(NEXT_EXTENT)    columnvalue,
'MIN_EXTENTS                            :' columnname,  to_char(MIN_EXTENTS)    columnvalue,
'MAX_EXTENTS                            :' columnname,  to_char(MAX_EXTENTS)    columnvalue,
'PCT_INCREASE                           :' columnname,  to_char(PCT_INCREASE)   columnvalue,
'FREELISTS                              :' columnname,  to_char(FREELISTS)      columnvalue,
'FREELIST_GROUPS                        :' columnname,  to_char(FREELIST_GROUPS)        columnvalue,
'LOGGING                                :' columnname, LOGGING  columnvalue,
'BACKED_UP                              :' columnname, BACKED_UP        columnvalue,
'NUM_ROWS                               :' columnname,  to_char(NUM_ROWS)       columnvalue,
'BLOCKS                                 :' columnname,  to_char(BLOCKS) columnvalue,
'EMPTY_BLOCKS                           :' columnname,  to_char(EMPTY_BLOCKS)   columnvalue,
'AVG_SPACE                              :' columnname,  to_char(AVG_SPACE)      columnvalue,
'CHAIN_CNT                              :' columnname,  to_char(CHAIN_CNT)      columnvalue,
'AVG_ROW_LEN                            :' columnname,  to_char(AVG_ROW_LEN)    columnvalue,
'AVG_SPACE_FREELIST_BLOCKS              :' columnname,  to_char(AVG_SPACE_FREELIST_BLOCKS)      columnvalue,
'NUM_FREELIST_BLOCKS                    :' columnname,  to_char(NUM_FREELIST_BLOCKS)    columnvalue,
'DEGREE                                 :' columnname, DEGREE   columnvalue,
'INSTANCES                              :' columnname, INSTANCES        columnvalue,
'CACHE                                  :' columnname, CACHE    columnvalue,
'TABLE_LOCK                             :' columnname, TABLE_LOCK       columnvalue,
'SAMPLE_SIZE                            :' columnname,  to_char(SAMPLE_SIZE)    columnvalue,
'LAST_ANALYZED                          :' columnname,  to_char(LAST_ANALYZED)  columnvalue,
'PARTITIONED                            :' columnname, PARTITIONED      columnvalue,
'IOT_TYPE                               :' columnname, IOT_TYPE columnvalue,
'TEMPORARY                              :' columnname, TEMPORARY        columnvalue,
'SECONDARY                              :' columnname, SECONDARY        columnvalue,
'NESTED                                 :' columnname, NESTED   columnvalue,
'BUFFER_POOL                            :' columnname, BUFFER_POOL      columnvalue,
'FLASH_CACHE                            :' columnname, FLASH_CACHE      columnvalue,
'CELL_FLASH_CACHE                       :' columnname, CELL_FLASH_CACHE columnvalue,
'ROW_MOVEMENT                           :' columnname, ROW_MOVEMENT     columnvalue,
'GLOBAL_STATS                           :' columnname, GLOBAL_STATS     columnvalue,
'USER_STATS                             :' columnname, USER_STATS       columnvalue,
'DURATION                               :' columnname, DURATION columnvalue,
'SKIP_CORRUPT                           :' columnname, SKIP_CORRUPT     columnvalue,
'MONITORING                             :' columnname, MONITORING       columnvalue,
'CLUSTER_OWNER                          :' columnname, CLUSTER_OWNER    columnvalue,
'DEPENDENCIES                           :' columnname, DEPENDENCIES     columnvalue,
'COMPRESSION                            :' columnname, COMPRESSION      columnvalue,
'COMPRESS_FOR                           :' columnname, COMPRESS_FOR     columnvalue,
'DROPPED                                :' columnname, DROPPED  columnvalue,
'READ_ONLY                              :' columnname, READ_ONLY        columnvalue,
'SEGMENT_CREATED                        :' columnname, SEGMENT_CREATED  columnvalue,
'RESULT_CACHE                           :' columnname, RESULT_CACHE     columnvalue,
'~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~'     columntitle
from            DBA_TABLES
where		table_name = '&table_name'
and owner='&owner';

--Below 11g
select          'Column Name                                    Column Value'                                           columntitle,
'~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~'     columntitle,
'OWNER                                  :' columnname, OWNER    columnvalue,
'TABLE_NAME                             :' columnname, TABLE_NAME       columnvalue,
'TABLESPACE_NAME                        :' columnname, TABLESPACE_NAME  columnvalue,
'CLUSTER_NAME                           :' columnname, CLUSTER_NAME     columnvalue,
'IOT_NAME                               :' columnname, IOT_NAME columnvalue,
'STATUS                                 :' columnname, STATUS   columnvalue,
'PCT_FREE                               :' columnname,  to_char(PCT_FREE)       columnvalue,
'PCT_USED                               :' columnname,  to_char(PCT_USED)       columnvalue,
'INI_TRANS                              :' columnname,  to_char(INI_TRANS)      columnvalue,
'MAX_TRANS                              :' columnname,  to_char(MAX_TRANS)      columnvalue,
'INITIAL_EXTENT                         :' columnname,  to_char(INITIAL_EXTENT) columnvalue,
'NEXT_EXTENT                            :' columnname,  to_char(NEXT_EXTENT)    columnvalue,
'MIN_EXTENTS                            :' columnname,  to_char(MIN_EXTENTS)    columnvalue,
'MAX_EXTENTS                            :' columnname,  to_char(MAX_EXTENTS)    columnvalue,
'PCT_INCREASE                           :' columnname,  to_char(PCT_INCREASE)   columnvalue,
'FREELISTS                              :' columnname,  to_char(FREELISTS)      columnvalue,
'FREELIST_GROUPS                        :' columnname,  to_char(FREELIST_GROUPS)        columnvalue,
'LOGGING                                :' columnname, LOGGING  columnvalue,
'BACKED_UP                              :' columnname, BACKED_UP        columnvalue,
'NUM_ROWS                               :' columnname,  to_char(NUM_ROWS)       columnvalue,
'BLOCKS                                 :' columnname,  to_char(BLOCKS) columnvalue,
'EMPTY_BLOCKS                           :' columnname,  to_char(EMPTY_BLOCKS)   columnvalue,
'AVG_SPACE                              :' columnname,  to_char(AVG_SPACE)      columnvalue,
'CHAIN_CNT                              :' columnname,  to_char(CHAIN_CNT)      columnvalue,
'AVG_ROW_LEN                            :' columnname,  to_char(AVG_ROW_LEN)    columnvalue,
'AVG_SPACE_FREELIST_BLOCKS              :' columnname,  to_char(AVG_SPACE_FREELIST_BLOCKS)      columnvalue,
'NUM_FREELIST_BLOCKS                    :' columnname,  to_char(NUM_FREELIST_BLOCKS)    columnvalue,
'DEGREE                                 :' columnname, DEGREE   columnvalue,
'INSTANCES                              :' columnname, INSTANCES        columnvalue,
'CACHE                                  :' columnname, CACHE    columnvalue,
'TABLE_LOCK                             :' columnname, TABLE_LOCK       columnvalue,
'SAMPLE_SIZE                            :' columnname,  to_char(SAMPLE_SIZE)    columnvalue,
'LAST_ANALYZED                          :' columnname,  to_char(LAST_ANALYZED)  columnvalue,
'PARTITIONED                            :' columnname, PARTITIONED      columnvalue,
'IOT_TYPE                               :' columnname, IOT_TYPE columnvalue,
'TEMPORARY                              :' columnname, TEMPORARY        columnvalue,
'SECONDARY                              :' columnname, SECONDARY        columnvalue,
'NESTED                                 :' columnname, NESTED   columnvalue,
'BUFFER_POOL                            :' columnname, BUFFER_POOL      columnvalue,
'ROW_MOVEMENT                           :' columnname, ROW_MOVEMENT     columnvalue,
'GLOBAL_STATS                           :' columnname, GLOBAL_STATS     columnvalue,
'USER_STATS                             :' columnname, USER_STATS       columnvalue,
'DURATION                               :' columnname, DURATION columnvalue,
'SKIP_CORRUPT                           :' columnname, SKIP_CORRUPT     columnvalue,
'MONITORING                             :' columnname, MONITORING       columnvalue,
'CLUSTER_OWNER                          :' columnname, CLUSTER_OWNER    columnvalue,
'DEPENDENCIES                           :' columnname, DEPENDENCIES     columnvalue,
'COMPRESSION                            :' columnname, COMPRESSION      columnvalue,
'DROPPED                                :' columnname, DROPPED  columnvalue,
'~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~'     columntitle
from            DBA_TABLES
where		table_name = '&table_name'
and owner='&owner'
/


REM ########################################################################
REM ##   1. The list of all foreign keys of the given table.
REM ##   2. The list of all foreign keys that references the given table.
REM ##   3. Self referential integrity constraints
REM #######################################################################

set linesize 110
set verify   off
set pagesize 40

break on owner on table_name on constraint_name on r_constraint_name

column owner format a5
column r_owner format a5
column column_name format a12
column tt noprint
column position heading P format 9
column table_name format a15
column r_table_name format a15
column constraint_name format a15
column r_constraint_name format a15

select
        a.tt,
        a.owner,
        b.table_name,
        a.constraint_name,
        b.column_name,
        b.position,
        a.r_constraint_name,
        c.column_name,
        c.position,
        c.table_name r_table_name,
        a.r_owner
from
        (select
                owner,
                constraint_name,
                r_constraint_name,
                r_owner,1 tt
        from
                dba_constraints
        where
                owner=upper('&&owner')
                and table_name=upper('&&table_name')
                and constraint_type!='C'
        union
        select
                owner,
                constraint_name,
                r_constraint_name,
                r_owner,2
        from
                dba_constraints
        where
                (r_constraint_name,r_owner) in
                (select
                        constraint_name,
                        owner
                from
                        dba_constraints
                where
                        owner=upper('&owner')
                        and table_name=upper('&table_name'))
        ) a,
        dba_cons_columns b,
        dba_cons_columns c
where
        b.constraint_name=a.constraint_name
        and b.owner=a.owner
        and c.constraint_name=a.r_constraint_name
        and c.owner=a.r_owner
        and b.position=c.position
order   by 1,2,3,4,5
/

set verify on

clear columns
clear breaks

undef owner
undef table_name

################################################
## Drop a column from compressed table - without drop and recreated
################################################
create table t compress as select * from all_users;

Table created.

 alter table t add x number;

Table altered.

--physically drop, no:

alter table t drop column x;
alter table t drop column x
                          *
ERROR at line 1:
ORA-39726: unsupported add/drop column operation on compressed tables

but make it "disappear"
 alter table t set unused column x;

Table altered.

yes, which if you ask me is OK since you would have to rewrite the entire segment to 
truly get rid of the data anyway (and recompress it).  So follow that with:

 alter table t drop unused columns;

Table altered.

and it is gone



################################################
## Get Table growth trend
################################################
set linesize 121
col timepoint format a40

SELECT *
FROM TABLE(dbms_space.object_growth_trend('DATPRD', 'DBTS_PREDICTION', 'TABLE'));
