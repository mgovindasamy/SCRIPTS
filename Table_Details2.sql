@store
ACCEPT object_owner PROMPT 'Enter owner name :'
ACCEPT object_name PROMPT 'Enter table name :'
PROMPT 'Preparing report!'
SET ECHO OFF
SET LONG 1000000
SET LONGCHUNKSIZE 1000000
SET LINESIZE 1000
SET PAGESIZE 1000
SET SERVEROUT ON 
SET TRIM ON
SET TERMOUT OFF
SET TRIMSPOOL ON
SET FEEDBACK OFF
SET VERIFY OFF
set  mark html on TABLE "border='1' align='left-center' style='background-color:#f7f7d7'" ENTMAP OFF SPOOL ON PREFORMAT OFF
spool table_details2.html

PROMPT <h1> Table Details for &object_owner  &object_name </h1>
PROMPT
PROMPT /* Table column detials */
PROMPT
COL data_type for a20
COL nullable for a8
COL data_default for a30
COL COMMENTS for a85
COL column_id for 999

SELECT   c.column_name,
         CASE
            WHEN data_type = 'CHAR'
               THEN    data_type
                    || '('
                    || c.char_length
                    || DECODE (char_used, 'B', ' BYTE', 'C', ' CHAR', NULL)
                    || ')'
            WHEN data_type = 'VARCHAR'
               THEN    data_type
                    || '('
                    || c.char_length
                    || DECODE (char_used, 'B', 'BYTE', 'C', ' CHAR', NULL)
                    || ')'
            WHEN data_type = 'VARCHAR2'
               THEN    data_type
                    || '('
                    || c.char_length
                    || DECODE (char_used, 'B', ' BYTE', 'C', ' CHAR', NULL)
                    || ')'
            WHEN data_type = 'NCHAR'
               THEN    data_type
                    || '('
                    || c.char_length
                    || DECODE (char_used, 'B', ' BYTE', 'C', ' CHAR', NULL)
                    || ')'
            WHEN data_type = 'NUMBER'
               THEN CASE
                      WHEN c.data_precision IS NULL AND c.data_scale IS NULL
                         THEN 'NUMBER'
                      WHEN c.data_precision IS NULL
                      AND c.data_scale IS NOT NULL
                         THEN 'NUMBER(38,' || c.data_scale || ')'
                      ELSE    data_type
                           || '('
                           || c.data_precision
                           || ','
                           || c.data_scale
                           || ')'
                   END
            WHEN data_type = 'NVARCHAR'
               THEN    data_type
                    || '('
                    || c.char_length
                    || DECODE (char_used, 'B', ' BYTE', 'C', ' CHAR', NULL)
                    || ')'
            WHEN data_type = 'NVARCHAR2'
               THEN    data_type
                    || '('
                    || c.char_length
                    || DECODE (char_used, 'B', ' BYTE', 'C', ' CHAR', NULL)
                    || ')'
            ELSE data_type
         END data_type,
         DECODE (nullable, 'Y', 'Yes', 'No') nullable, c.data_default,
         column_id, com.comments
    FROM SYS.dba_tab_columns c, SYS.dba_col_comments com
   WHERE c.owner = '&object_owner'
     AND c.table_name = '&object_name'
     AND c.table_name = com.table_name
     AND c.owner = com.owner
     AND c.column_name = com.column_name
ORDER BY column_id;


PROMPT
PROMPT /* Constraints */
PROMPT

SELECT   c.constraint_name,
         DECODE (c.constraint_type,
                 'P', 'Primary_Key',
                 'U', 'Unique',
                 'R', 'Foreign_Key',
                 'C', 'Check',
                 c.constraint_type
                ) constraint_type,
         c.search_condition, c.r_owner,
         (SELECT r.table_name
            FROM dba_constraints r
           WHERE c.r_owner = r.owner
             AND c.r_constraint_name = r.constraint_name) r_table_name,
         c.r_constraint_name, c.delete_rule, c.status, c.DEFERRABLE,
         c.validated, c.GENERATED, c.bad, c.RELY, c.last_change,
         c.index_owner, c.index_name, c.invalid, c.view_related
    FROM dba_constraints c
   WHERE c.owner = '&object_owner' AND c.table_name = '&object_name'
ORDER BY c.constraint_name;

PROMPT
PROMPT /* Constraints details */
PROMPT 
 break on constraint_name skip 1
SELECT   cols.constraint_name constraint_name, cols.column_name column_name,
         cols.POSITION column_position
    FROM dba_constraints cons, dba_cons_columns cols
   WHERE                               --cons.constraint_type in ('U','P') AND
         cons.constraint_name = cols.constraint_name
     AND cons.owner = cols.owner
     AND cols.table_name = '&object_name'
     AND cons.owner = '&object_owner'
     AND cols.constraint_name IN (
             SELECT c.constraint_name
               FROM dba_constraints c
              WHERE c.owner = '&object_owner'
                    AND c.table_name = '&object_name')
ORDER BY cols.POSITION;
clear break
PROMPT
PROMPT /*  Table Grants */
PROMPT 
 
SELECT PRIVILEGE, grantee, grantable, grantor, column_name object_name
  FROM dba_col_privs
 WHERE owner = '&object_owner' AND table_name = '&object_name'
UNION ALL
SELECT PRIVILEGE, grantee, grantable, grantor, table_name object_name
  FROM dba_tab_privs
 WHERE owner = '&object_owner' AND table_name = '&object_name';

PROMPT 
PROMPT /*  Table statistics */
PROMPT


SELECT num_rows, blocks, avg_row_len, sample_size, last_analyzed,
       last_analyzed last_analyzed_since
  FROM SYS.dba_all_tables
 WHERE owner = '&object_owner' AND table_name = '&object_name';

PROMPT 
PROMPT /*  Table Column statistics */
PROMPT
 SELECT *
  FROM SYS.dba_tab_col_statistics
 WHERE owner = '&object_owner' AND table_name = '&object_name';

PROMPT    
PROMPT	/* Table Triggers */
PROMPT
	
	SELECT dt.trigger_name, dt.trigger_type, owner trigger_owner,
       dt.triggering_event, dt.status
  FROM SYS.dba_triggers dt
 WHERE dt.table_owner = '&object_owner' AND dt.table_name = '&object_name';

PROMPT 
PROMPT /* Dependencies */
PROMPT
 
 SELECT owner, NAME, TYPE, referenced_owner, referenced_name, referenced_type
  FROM dba_dependencies
 WHERE owner = '&object_owner' AND referenced_name = '&object_name';


PROMPT
PROMPT /* Table Details */
PROMPT
 
 SELECT o.created, o.last_ddl_time, t.*, c.comments
  FROM (SELECT owner, table_name, tablespace_name, cluster_name, iot_name,
               status, pct_free, pct_used, ini_trans, max_trans,
               initial_extent, next_extent, min_extents, max_extents,
               pct_increase, FREELISTS, freelist_groups, LOGGING, backed_up,
               num_rows, blocks, empty_blocks, avg_space, chain_cnt,
               avg_row_len, avg_space_freelist_blocks, num_freelist_blocks,
               LTRIM (DEGREE) DEGREE, LTRIM (INSTANCES) INSTANCES,
               LTRIM (CACHE) CACHE, table_lock, sample_size, last_analyzed,
               partitioned, iot_type, object_id_type, table_type_owner,
               table_type, TEMPORARY, secondary, NESTED, BUFFER_POOL,
               row_movement, global_stats, user_stats, DURATION, skip_corrupt,
               MONITORING, cluster_owner, dependencies, compression,
               compress_for, dropped
          FROM dba_all_tables a
         WHERE owner = '&object_owner' AND table_name = '&object_name') t,
       (SELECT owner, object_name, created, last_ddl_time
          FROM SYS.dba_objects
         WHERE object_name = '&object_name'
           AND owner = '&object_owner'
           AND object_type = 'TABLE') o,
       (SELECT owner, table_name, comments
          FROM dba_tab_comments
         WHERE owner = '&object_owner' AND table_name = '&object_name') c
 WHERE t.owner = o.owner
   AND t.table_name = o.object_name
   AND t.owner = c.owner(+)
   AND t.table_name = c.table_name(+);


PROMPT
PROMPT   /* Table index*/
PROMPT
   
   SELECT ind.index_owner, ind.index_name, ind.uniqueness, ind.status,
       ind.index_type, ind.TEMPORARY, ind.partitioned, ind.funcidx_status,
       ind.join_index, ind.COLUMNS, ie.column_expression
  FROM (SELECT   index_owner, table_owner, index_name, uniqueness, status,
                 index_type, TEMPORARY, partitioned, funcidx_status,
                 join_index,
                    MAX (DECODE (POSITION, 1, column_name))
                 || MAX (DECODE (POSITION, 2, ', ' || column_name))
                 || MAX (DECODE (POSITION, 3, ', ' || column_name))
                 || MAX (DECODE (POSITION, 4, ', ' || column_name)) COLUMNS
            FROM (SELECT di.owner index_owner, dc.table_owner, dc.index_name,
                         di.uniqueness, di.status, di.index_type,
                         di.TEMPORARY, di.partitioned, di.funcidx_status,
                         di.join_index, dc.column_name,
                         dc.column_position POSITION
                    FROM dba_ind_columns dc, dba_indexes di
                   WHERE di.table_owner = '&object_owner'
                     AND di.table_name = '&object_name'
                     AND dc.index_name = di.index_name
                     AND dc.index_owner = di.owner)
        GROUP BY index_owner,
                 table_owner,
                 index_name,
                 uniqueness,
                 status,
                 index_type,
                 TEMPORARY,
                 partitioned,
                 funcidx_status,
                 join_index) ind,
       dba_ind_expressions ie
 WHERE ind.index_name = ie.index_name(+) AND ind.index_owner = ie.index_owner(+);

PROMPT 
PROMPT /* Indexed column Details */
PROMPT
 
  break on INDEX_OWNER on index_name skip 1
 SELECT *
  FROM dba_ind_columns
 WHERE table_name = '&object_name'
   AND (index_name, index_owner) IN (
          SELECT ind.index_name, ind.index_owner
            FROM (SELECT   index_owner, table_owner, index_name, uniqueness,
                           status, index_type, TEMPORARY, partitioned,
                           funcidx_status, join_index,
                              MAX (DECODE (POSITION, 1, column_name))
                           || MAX (DECODE (POSITION, 2, ', ' || column_name))
                           || MAX (DECODE (POSITION, 3, ', ' || column_name))
                           || MAX (DECODE (POSITION, 4, ', ' || column_name))
                                                                      COLUMNS
                      FROM (SELECT di.owner index_owner, dc.table_owner,
                                   dc.index_name, di.uniqueness, di.status,
                                   di.index_type, di.TEMPORARY,
                                   di.partitioned, di.funcidx_status,
                                   di.join_index, dc.column_name,
                                   dc.column_position POSITION
                              FROM dba_ind_columns dc, dba_indexes di
                             WHERE di.table_owner = '&object_owner'
                               AND di.table_name = '&object_name'
                               AND dc.index_name = di.index_name
                               AND dc.index_owner = di.owner)
                  GROUP BY index_owner,
                           table_owner,
                           index_name,
                           uniqueness,
                           status,
                           index_type,
                           TEMPORARY,
                           partitioned,
                           funcidx_status,
                           join_index) ind,
                 dba_ind_expressions ie
           WHERE ind.index_name = ie.index_name(+) AND ind.index_owner = ie.index_owner(+));
clear break

PROMPT
PROMPT /*Table partitions */
PROMPT

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
     AND a.owner = '&object_owner'
	 AND a.table_name = '&object_name'
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
 
/*
SELECT partition_name, last_analyzed, num_rows, blocks, sample_size,
       high_value
  FROM dba_tab_partitions
 WHERE table_owner = '&object_owner' AND table_name = '&object_name';
*/
PROMPT
PROMPT   /* Table subpartitions */
PROMPT
 PROMPT Suppressed
/* 
   BREAK on partition_name skip 1
SELECT partition_name, subpartition_name, last_analyzed, num_rows, blocks,
       sample_size, high_value
  FROM dba_tab_subpartitions
 WHERE table_owner = '&object_owner'
   AND table_name = '&object_name'
   AND partition_name IN (
           SELECT partition_name
             FROM dba_tab_partitions
            WHERE table_owner = '&object_owner'
                  AND table_name = '&object_name');

clear break				  
*/

PROMPT				  
PROMPT /* Get ddl */
PROMPT Suppressed 
/*
SELECT DBMS_METADATA.get_dependent_ddl ('OBJECT_GRANT',
                                        '&object_name',
                                        '&object_owner'
                                       )
  FROM DUAL
 WHERE 0 !=
            (SELECT COUNT (*)
               FROM all_col_privs
              WHERE table_schema = '&object_owner'
                AND table_name = '&object_name')
          + (SELECT COUNT (*)
               FROM all_tab_privs
              WHERE table_schema = '&object_owner'
                AND table_name = '&object_name');
*/
spool off
host table_details2.html
set trim on
set mark html off
@restore
