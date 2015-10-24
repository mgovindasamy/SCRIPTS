
##########################################
#To Create a  TEMPORARY TABLESPACE
##########################################

CREATE TEMPORARY TABLESPACE TEMP TEMPFILE '/dev/vx/rdsk/RAC-PEWM-DG/pewm_temp05' SIZE 1G AUTOEXTEND OFF;

##########################################
#To Make TEMP DEFAULT TEMPORARY TABLESPACE
##########################################
ALTER DATABASE DEFAULT TEMPORARY TABLESPACE TEMP;

ALTER USER  TEMPORARY TABLESPACE TEMP;

##########################################
#To ADD space to TEMPORARY TABLESPACE
##########################################

ALTER DATABASE TEMPFILE '/dev/vx/rdsk/RAC-PEWM-DG/pewm_temp01'  RESIZE 10g;

##########################################
#To ADD FILE to TEMPORARY TABLESPACE
##########################################

undef TABLESPACE_NAME
set line 160 pages 160
col FILE_NAME for a100
select TABLESPACE_NAME,FILE_NAME||'('||FILE_ID||')' FILE_NAME,BYTES/1024/1024 BYTES_MB,STATUS from dba_temp_files 
where TABLESPACE_NAME=Decode(Upper('&&TABLESPACE_NAME'),'ALL',dba_temp_files.TABLESPACE_NAME ,Upper('&&TABLESPACE_NAME'))
order by TABLESPACE_NAME,FILE_NAME;


ALTER TABLESPACE <tablespace_name> ADD TEMPFILE '<path_and_file_name>' SIZE;

##########################################
#To Drop TEMPORARY TABLESPACE
##########################################

DROP TABLESPACE TEMP INCLUDING CONTENTS AND DATAFILES;

##########################################
#To rename TEMPORARY TABLESPACE
##########################################
ALTER TABLESPACE TEMP2 RENAME TO TEMP;

##########################################
#To DROP FILE from TEMPORARY TABLESPACE 
##########################################

--make offline
ALTER DATABASE TEMPFILE '/dev/vx/rdsk/RAC-PEWM-DG/pewm_temp03'  OFFLINE;

--Drop
ALTER DATABASE TEMPFILE '/dev/vx/rdsk/RAC-PEWM-DG/pewm_temp01' DROP INCLUDING DATAFILES;

##########################################
#TO FIND DEFAULT_TEMP_TABLESPACE
##########################################

col PROPERTY_NAME for a24
SELECT PROPERTY_NAME,PROPERTY_VALUE FROM DATABASE_PROPERTIES where PROPERTY_NAME='DEFAULT_TEMP_TABLESPACE';

##########################################
#TO FIND ALL TEMP TABLESPACES AND TEMPFILES
##########################################

SELECT TABLESPACE_NAME,STATUS,CONTENTS FROM DBA_TABLESPACES WHERE CONTENTS='TEMPORARY';

col FILE_NAME for a80
select TABLESPACE_NAME,FILE_NAME||'('||FILE_ID||')' FILE_NAME,BYTES/1024/1024 BYTES_MB,STATUS from dba_temp_files 
where TABLESPACE_NAME=Decode(Upper('&&TABLESPACE_NAME'),'ALL',dba_temp_files.TABLESPACE_NAME ,Upper('&&TABLESPACE_NAME'));

##########################################
#TO FORM TEMP TABLESPACES GROUPS
##########################################

ALTER TABLESPACE TEMP TABLESPACE GROUP GROUP1;
ALTER TABLESPACE ESTT001 TABLESPACE GROUP GROUP1;

##########################################
#TO REMOVE TEMP TABLESPACES FROM A GROUP
##########################################

ALTER TABLESPACE TEMP TABLESPACE GROUP '';

##########################################
#TO CHECK TEMP TABLESPACES GROUPS
##########################################

SELECT GROUP_NAME, TABLESPACE_NAME FROM DBA_TABLESPACE_GROUPS;

/*########################################## Issues with TEMP tablespace ##########################################*/

How Do You Find Who And What SQL Is Using Temp Segments [ID 317441.1


##########################################
#To see temp tablespace free SPACE
##########################################

select TABLESPACE_NAME, sum(BYTES_USED)/1024/1024 BYTES_USED_MB, sum(BYTES_FREE)/1024/1024 BYTES_FREE_MB 
from gV$TEMP_SPACE_HEADER
group by TABLESPACE_NAME;


##########################################
#To See Temp Segments usage by SQLs
##########################################

set line 160 pages 120
col username for a25
col segtype for a25
col extents for 999999
col blocks for 99999999
col tablespace for a20
col SQL_TEXT for a25

break on username skip 1 
select unique  u.username, u.segtype, u.extents, u.blocks,u.tablespace, s.sql_id
--s.sql_fulltext,
--substr(s.sql_fulltext,1,25) SQL_TEXT
from gv$tempseg_usage u, gv$sql s 
where s.sql_id = u.sql_id 
and s.inst_id=u.inst_id and u.tablespace='&TEMP'
--and s.sql_id='cx6czrntmv79s'
order by u.username,u.extents;


SELECT sysdate,a.username, a.sid, a.serial#, a.osuser, b.blocks, c.sql_text
FROM v$session a, v$tempseg_usage b, v$sqlarea c
WHERE b.tablespace = 'TEMP'
and a.saddr = b.session_addr
AND c.address= a.sql_address
AND c.hash_value = a.sql_hash_value


##########################################
#To See Temp Segments usage session
##########################################

select sid,
       serial#,
       username,
       LOGON_TIME,
       CURRENT_TIME,
       SLAVES_CNT,
       TEMP_SIZE_IN_MB
from ia.session_info
order by TEMP_SIZE_IN_MB
;

##########################################
#To See Temp Segments usage Lob data
##########################################
--instance
select TABLESPACE,CONTENTS,segtype,extents,blocks, sum(mb) temp_used_mb from (
SELECT   u.TABLESPACE, u.CONTENTS, u.segtype, u.extents, u.blocks,
         ROUND (((u.blocks * p.VALUE) / 1024 / 1024), 2) mb
    FROM v$session s, v$sort_usage u, SYS.v_$system_parameter p
   WHERE s.saddr = u.session_addr AND UPPER (p.NAME) = 'DB_BLOCK_SIZE'
ORDER BY mb DESC
) group by TABLESPACE,CONTENTS,segtype,extents,blocks;

--rac
BREAK on report
COMPUTE sum of temp_used_mb on report skip 1
SELECT   inst_id, TABLESPACE, CONTENTS, segtype, extents, blocks,
         SUM (mb) temp_used_mb
    FROM (SELECT   s.inst_id, u.TABLESPACE, u.CONTENTS, u.segtype, u.extents,
                   u.blocks,
                   ROUND (((u.blocks * p.VALUE) / 1024 / 1024), 2) mb
              FROM gv$session s, gv$sort_usage u, SYS.v_$system_parameter p
             WHERE s.saddr = u.session_addr
               AND UPPER (p.NAME) = 'DB_BLOCK_SIZE'
               AND s.inst_id = u.inst_id
          ORDER BY mb DESC)
GROUP BY inst_id, TABLESPACE, CONTENTS, extents,segtype, blocks
ORDER BY inst_id, temp_used_mb;

##########################################
#how many extents are allocated and actually used per Tempfile 
##########################################

break on tablespace_name on INST_ID skip 1
compute sum label "Total" of MB_ALLOCATED MB_USED MB_FREE on tablespace_name INST_ID

select INST_ID,tablespace_name,
       file_id,
       extents_cached extents_allocated,
       extents_used,
       bytes_cached/1024/1024 mb_allocated,
       bytes_used/1024/1024 mb_used,
	  (bytes_cached-bytes_used)/1024/1024 mb_free
from gv$temp_extent_pool order by 1,2;


##########################################################
#Creator of Sort Segment / usage of temp segments
##########################################################
--CONTENTS column shows whether the segment is  
--created in a temporary or permanent tablespace.

set line 160 pages 160 
col sid_serial for a12
col username for a25
col osuser for a25
col spid for 999999
col module for a5
col program for a5
col tablespace for a25

break on report
compute sum label "Total" of gb_USED on report

SELECT  S.username,S.osuser,substr(S.module,1,5) module,substr(S.program,1,5) program,T.tablespace,
		S.sid || ',' || S.serial# sid_serial, P.spid, COUNT(*) sort_ops,
		round(SUM (T.blocks) * TBS.block_size / 1024 / 1024 / 1024 , 2)  gb_used
FROM     v$sort_usage T, v$session S, dba_tablespaces TBS, v$process P
WHERE    T.session_addr = S.saddr
AND      S.paddr = P.addr
AND      T.tablespace = TBS.tablespace_name
--AND 	S.username='DATPRD'
GROUP BY S.sid, S.serial#, S.username, S.osuser, P.spid, S.module,
         S.program, TBS.block_size, T.tablespace
ORDER BY USERNAME,gb_used;


select sum(gb_used) from (
SELECT  S.username,S.osuser,substr(S.module,1,5) module,substr(S.program,1,5) program,T.tablespace,
		S.sid || ',' || S.serial# sid_serial, P.spid, COUNT(*) sort_ops,
		round(SUM (T.blocks) * TBS.block_size / 1024 / 1024 / 1024 , 2)  gb_used
FROM     gv$sort_usage T, gv$session S, dba_tablespaces TBS, gv$process P
WHERE    T.session_addr = S.saddr
AND 	 t.inst_id=s.inst_id
AND 	 t.inst_id=p.inst_id
AND      S.paddr = P.addr
AND      T.tablespace = TBS.tablespace_name
--AND 	S.username='DATPRD'
GROUP BY S.sid, S.serial#, S.username, S.osuser, P.spid, S.module,
         S.program, TBS.block_size, T.tablespace
ORDER BY USERNAME,gb_used
);
/*
select 
   srt.tablespace, 
   srt.segfile#, 
   srt.segblk#, 
   srt.blocks, 
   srt.CONTENTS,
   a.sid, 
   a.serial#, 
   a.username, 
   a.osuser, 
   a.status 
from 
   v$session    a,
   v$sort_usage srt 
where 
   a.saddr = srt.session_addr 
order by 
   srt.tablespace, srt.segfile#, srt.segblk#, 
   srt.blocks;
*/


##########################################################
#1.Check the status of the sort segment utilization 
##########################################################
--ORA-1652 Error Troubleshooting [ID 793380.1]

SELECT   A.tablespace_name tablespace, D.mb_total,
         SUM (A.used_blocks * D.block_size) / 1024 / 1024 mb_used,
         D.mb_total - SUM (A.used_blocks * D.block_size) / 1024 / 1024 mb_free
FROM     v$sort_segment A,
         (
         SELECT   B.name, C.block_size, SUM (C.bytes) / 1024 / 1024 mb_total
         FROM     v$tablespace B, v$tempfile C
         WHERE    B.ts#= C.ts#
         GROUP BY B.name, C.block_size
         ) D
WHERE    A.tablespace_name = D.name
GROUP by A.tablespace_name, D.mb_total;


##########################################################
#2.If USED_BLOCKS = TOTAL_BLOCKS 
--find which user and statement is using the temporary sort segment by following

--NOTE(1) : Indications are that the SQL retrieval does not work for parallel query slaves ... only the parent process 
--NOTE(2) : This query will not assist in determination of the amount of space consumed in a temporary tablespace ... 
--if this is desired ... then other queries on v$sort_usage or v$tempseg_usage ... should be used 
##########################################################

SELECT a.username, a.sid, a.serial#, a.osuser, b.tablespace, b.blocks, c.sql_text
FROM v$session a, v$tempseg_usage b, v$sqlarea c
WHERE a.saddr = b.session_addr
AND c.address= a.sql_address
AND c.hash_value = a.sql_hash_value
ORDER BY b.tablespace, b.blocks;



##########################################################
#CHECK if RESUMABLE session are persent
##########################################################

select user_id,SESSION_ID, STATUS, START_TIME, SUSPEND_TIME, SQL_TEXT, ERROR_NUMBER, ERROR_MSG  from dba_resumable;


##########################################################
#End to end check for temp usage
##########################################################
set trimout on;
set linesize 255;
set pagesize 50000;
set echo on;
--
pro Temporary tablespace utilization query by tablespace (level 1, summary).
--
-- TsNm is the tablespace name.
-- II is the database instance number.
-- CuUsCnt is the current user session count.
-- TsMbA is the tablespace allocated size in megabytes.
-- TsMbU is the tablespace used size in megabytes.
-- TsMbF is the tablespace free size in megabytes.
-- TsMbU% is the percentage of tablespace allocated size used.
-- TsMbF% is the percentage of tablespace allocated size free.
-- SsMbA is the segment reported allocated size in megabytes.
-- SsMbU is the segment reported used size in megabytes.
-- SsMbMaxU is the segment reported maximum/highwater used size in megabytes.
-- SsMbMaxSU is the segment reported maximum/highwater sort used size in megabytes.
-- SsMbF is the segment reported free size in megabytes.
-- SsMbU% is the percentage of segment reported allocated size used.
-- SsMbF% is the percentage of segment reported allocated size free.
-- SuMbA is the usage reported allocated size in megabytes.
-- SuMbU is the usage reported used size in megabytes.
-- SuMbF is the usage reported free size in megabytes.
-- SuMbU% is the percentage of usage reported allocated size used.
-- SuMbF% is the percentage of usage reported allocated size free.
-- StatI is the state indicating OK or ALERT.
--
set echo off;
/* Formatted on 2013/11/18 18:05 (Formatter Plus v4.8.8) */
WITH ts AS
     (SELECT ts.tablespace_name tsnm, ts.block_size tsbs
        FROM dba_tablespaces ts
       WHERE ts.CONTENTS = 'TEMPORARY'),
     tsa AS
     (SELECT   ts.tsnm tsnm, (SUM (tf.BYTES) / (1024 * 1024)) tsmba
          FROM ts ts, dba_temp_files tf
         WHERE ts.tsnm = tf.tablespace_name
      GROUP BY ts.tsnm),
     tsu AS
     (SELECT   ts.tsnm tsnm,
               (SUM (ss.total_blocks * ts.tsbs) / (1024 * 1024)) tsmbu
          FROM ts ts, gv$sort_segment ss
         WHERE ts.tsnm = ss.tablespace_name
      GROUP BY ts.tsnm),
     ss AS
     (SELECT ts.tsnm tsnm, ss.inst_id ii, ss.current_users cuuscnt,
             ((ss.total_blocks * ts.tsbs) / (1024 * 1024)) ssmba,
             ((ss.used_blocks * ts.tsbs) / (1024 * 1024)) ssmbu,
             ((ss.max_used_blocks * ts.tsbs) / (1024 * 1024)) ssmbmaxu,
             ((ss.max_sort_blocks * ts.tsbs) / (1024 * 1024)) ssmbmaxsu,
             ((ss.free_blocks * ts.tsbs) / (1024 * 1024)) ssmbf
        FROM ts ts, gv$sort_segment ss
       WHERE ts.tsnm = ss.tablespace_name),
     sua AS
     (SELECT ts.tsnm tsnm, ss.inst_id ii,
             (  tsa.tsmba
              - (  (  NVL ((SELECT SUM (ss1.free_blocks) ssblkf
                              FROM gv$sort_segment ss1
                             WHERE ss1.tablespace_name = ss.tablespace_name
                               AND ss1.inst_id != ss.inst_id),
                           0
                          )
                    * ts.tsbs
                   )
                 / (1024 * 1024)
                )
             ) sumba
        FROM ts ts, tsa tsa, gv$sort_segment ss
       WHERE ts.tsnm = tsa.tsnm AND ts.tsnm = ss.tablespace_name),
     suu AS
     (SELECT   ts.tsnm tsnm, su.inst_id ii,
               (SUM (su.blocks * ts.tsbs) / (1024 * 1024)) sumbu
          FROM ts ts, gv$sort_usage su
         WHERE ts.tsnm = su.TABLESPACE(+)
      GROUP BY ts.tsnm, su.inst_id)
SELECT   CAST (SUBSTR (ss.tsnm, 1, 15) AS VARCHAR2 (15)) "TsNm",
         CAST (LPAD (TRIM (TO_CHAR (ss.ii)), 2) AS VARCHAR2 (2)) "II",
         CAST (LPAD (TRIM (TO_CHAR (ss.cuuscnt)), 7) AS VARCHAR2 (7))
                                                                    "CuUsCnt",
         CAST (LPAD (TRIM (TO_CHAR (tsa.tsmba, '9999999')), 7) AS VARCHAR2 (7)
              ) "  TsMbA",
         CAST (LPAD (TRIM (TO_CHAR (tsu.tsmbu, '9999999')), 7) AS VARCHAR2 (7)
              ) "  TsMbU",
         CAST (LPAD (TRIM (TO_CHAR ((tsa.tsmba - tsu.tsmbu), '9999999')), 7) AS VARCHAR2 (7)
              ) "  TsMbF",
         CAST (LPAD (TRIM (TO_CHAR ((100 * (tsu.tsmbu / tsa.tsmba)), '990.99')
                          ),
                     6
                    ) AS VARCHAR2 (6)
              ) "TsMbU%",
         CAST (LPAD (TRIM (TO_CHAR ((  100
                                     * ((tsa.tsmba - tsu.tsmbu) / tsa.tsmba)
                                    ),
                                    '990.99'
                                   )
                          ),
                     6
                    ) AS VARCHAR2 (6)
              ) "TsMbF%",
         CAST (LPAD (TRIM (TO_CHAR (ss.ssmba, '9999999')), 7) AS VARCHAR2 (7)
              ) "  SsMbA",
         CAST (LPAD (TRIM (TO_CHAR (ss.ssmbu, '9999999')), 7) AS VARCHAR2 (7)
              ) "  SsMbU",
         CAST (LPAD (TRIM (TO_CHAR (ss.ssmbmaxu, '9999999')), 8) AS VARCHAR2 (8)
              ) "SsMbMaxU",
         CAST (LPAD (TRIM (TO_CHAR (ss.ssmbmaxsu, '9999999')), 9) AS VARCHAR2 (9)
              ) "SsMbMaxSU",
         CAST (LPAD (TRIM (TO_CHAR (ss.ssmbf, '9999999')), 7) AS VARCHAR2 (7)
              ) "  SsMbF",
         CAST (LPAD (TRIM (TO_CHAR ((100 * (ss.ssmbu / ss.ssmba)), '990.99')),
                     6
                    ) AS VARCHAR2 (6)
              ) "SsMbU%",
         CAST (LPAD (TRIM (TO_CHAR ((100 * ((ss.ssmba - ss.ssmbu) / ss.ssmba)
                                    ),
                                    '990.99'
                                   )
                          ),
                     6
                    ) AS VARCHAR2 (6)
              ) "SsMbF%",
         CAST (LPAD (TRIM (TO_CHAR (sua.sumba, '9999999')), 7) AS VARCHAR2 (7)
              ) "  SuMbA",
         CAST (LPAD (TRIM (TO_CHAR (suu.sumbu, '9999999')), 7) AS VARCHAR2 (7)
              ) "  SuMbU",
         CAST (LPAD (TRIM (TO_CHAR ((sua.sumba - suu.sumbu), '9999999')), 7) AS VARCHAR2 (7)
              ) "  SuMbF",
         CAST (LPAD (TRIM (TO_CHAR ((100 * (suu.sumbu / sua.sumba)), '990.99')
                          ),
                     6
                    ) AS VARCHAR2 (6)
              ) "SuMbU%",
         CAST (LPAD (TRIM (TO_CHAR ((  100
                                     * ((sua.sumba - suu.sumbu) / sua.sumba)
                                    ),
                                    '990.99'
                                   )
                          ),
                     6
                    ) AS VARCHAR2 (6)
              ) "SuMbF%",
         CAST
            (DECODE (SIGN (  (100 * (suu.sumbu / sua.sumba))
                           - NVL (&use_pct_threshold_def_90, 90)
                          ),
                     -1, 'OK',
                     'ALERT'
                    ) AS VARCHAR2 (5)
            ) "StatI"
    FROM ts ts, ss ss, tsa tsa, tsu tsu, sua sua, suu suu
   WHERE ts.tsnm = ss.tsnm
     AND ss.tsnm = tsa.tsnm
     AND ss.tsnm = tsu.tsnm
     AND ss.tsnm = sua.tsnm
     AND ss.ii = sua.ii
     AND ss.tsnm = suu.tsnm
     AND ss.ii = suu.ii
ORDER BY 1 ASC, 2 ASC;

set echo on;
--
pro Temporary tablespace utilization query by session metric (level 2, metrics).
--
-- TsNm is the tablespace name.
-- II is the database instance number.
-- MtrTy is the type of session metric where:
--   01-SegTy is tablespace utilization by segment type.
--   02-DuNm is tablespace utilization by database user name.
--   03-CuNm is tablespace utilization by client user name.
--   04-CuNod is tablespace utilization by client node.
--   05-CuPrg is tablespace utilization by client program.
--   06-Stat is tablespace utilization by by session status.
--   07-DuSID is tablespace utilization by session SID.
--   08-SqlID is tablespace utilization by session SQL ID.
-- Mtr is the metric name.
-- MtrCnt is the number of sort usage entries for the metric.
-- TsMbA is the tablespace allocated size in megabytes.
-- SsMbA is the segment reported allocated size in megabytes.
-- MtrMbU is the total metric used size in megabytes.
-- MtrTsMbU% is the percent of the total metric used size within the tablespace.
-- MtrSsMbU% is the percent of the total metric used size within the segment.
-- MtrRnk is the rank of the total metric used size within the tablespace.
--
set echo off;
/* Formatted on 2013/11/18 18:05 (Formatter Plus v4.8.8) */
WITH ts AS
     (SELECT ts.tablespace_name tsnm, ts.block_size tsbs
        FROM dba_tablespaces ts
       WHERE ts.CONTENTS = 'TEMPORARY'),
     tsa AS
     (SELECT   ts.tsnm tsnm, (SUM (tf.BYTES) / (1024 * 1024)) tsmba
          FROM ts ts, dba_temp_files tf
         WHERE ts.tsnm = tf.tablespace_name
      GROUP BY ts.tsnm),
     ss AS
     (SELECT ts.tsnm tsnm, ss.inst_id ii, ss.current_users cuuscnt,
             ((ss.total_blocks * ts.tsbs) / (1024 * 1024)) ssmba,
             ((ss.used_blocks * ts.tsbs) / (1024 * 1024)) ssmbu,
             ((ss.max_used_blocks * ts.tsbs) / (1024 * 1024)) ssmbmaxu,
             ((ss.max_sort_blocks * ts.tsbs) / (1024 * 1024)) ssmbmaxsu,
             ((ss.free_blocks * ts.tsbs) / (1024 * 1024)) ssmbf
        FROM ts ts, gv$sort_segment ss
       WHERE ts.tsnm = ss.tablespace_name),
     su AS
     (SELECT su.TABLESPACE tsnm, su.inst_id ii, su.segtype segty,
             su.sql_id sqlid, su.sqlhash sqlhs, TO_CHAR (us.SID) SID,
             (us.username || '[' || TRIM (TO_CHAR (us.SID)) || ']') dusid,
             us.username dunm, TO_CHAR (ps.spid) dupid, us.osuser cunm,
             us.process cupid, us.machine cunod, us.program cuprg,
             us.status stat, TO_CHAR (us.logon_time,
                                      'YYYYMMDD.HH24MISS') lgtm,
             TO_CHAR (us.last_call_et) lcet,
             ((su.blocks * ts.tsbs) / (1024 * 1024)) segmbu,
             SUM ((su.blocks * ts.tsbs) / (1024 * 1024)) OVER (PARTITION BY su.TABLESPACE, su.inst_id, us.SID)
                                                                        dumbu
        FROM gv$sort_usage su, gv$session us, gv$process ps, ts ts
       WHERE su.session_addr = us.saddr
         AND su.inst_id = us.inst_id
         AND us.paddr = ps.addr(+)
         AND us.inst_id = ps.inst_id(+)
         AND su.TABLESPACE = ts.tsnm),
     smt AS
     (SELECT   su.tsnm tsnm, su.ii ii, '01-SegTy' mtrty,
               SUBSTR (su.segty, 1, 30) mtr, COUNT (*) mtrcnt,
               SUM (su.segmbu) segmbu
          FROM su su
      GROUP BY su.tsnm, su.ii, su.segty
      UNION ALL
      SELECT   su.tsnm tsnm, su.ii ii, '02-DuNm' mtrty,
               SUBSTR (su.dunm, 1, 30) mtr, COUNT (*) mtrcnt,
               SUM (su.segmbu) segmbu
          FROM su su
      GROUP BY su.tsnm, su.ii, su.dunm
      UNION ALL
      SELECT   su.tsnm tsnm, su.ii ii, '03-CuNm' mtrty,
               SUBSTR (su.cunm, 1, 30) mtr, COUNT (*) mtrcnt,
               SUM (su.segmbu) segmbu
          FROM su su
      GROUP BY su.tsnm, su.ii, su.cunm
      UNION ALL
      SELECT   su.tsnm tsnm, su.ii ii, '04-CuNod' mtrty,
               SUBSTR (su.cunod, 1, 30) mtr, COUNT (*) mtrcnt,
               SUM (su.segmbu) segmbu
          FROM su su
      GROUP BY su.tsnm, su.ii, su.cunod
      UNION ALL
      SELECT   su.tsnm tsnm, su.ii ii, '05-CuPrg' mtrty,
               SUBSTR (su.cuprg, 1, 30) mtr, COUNT (*) mtrcnt,
               SUM (su.segmbu) segmbu
          FROM su su
      GROUP BY su.tsnm, su.ii, su.cuprg
      UNION ALL
      SELECT   su.tsnm tsnm, su.ii ii, '06-Stat' mtrty,
               SUBSTR (su.stat, 1, 30) mtr, COUNT (*) mtrcnt,
               SUM (su.segmbu) segmbu
          FROM su su
      GROUP BY su.tsnm, su.ii, su.stat
      UNION ALL
      SELECT   su.tsnm tsnm, su.ii ii, '07-DuSID' mtrty,
               SUBSTR (su.dusid, 1, 30) mtr, COUNT (*) mtrcnt,
               SUM (su.segmbu) segmbu
          FROM su su
      GROUP BY su.tsnm, su.ii, su.dusid
      UNION ALL
      SELECT   su.tsnm tsnm, su.ii ii, '08-SqlID' mtrty,
               SUBSTR (su.sqlid, 1, 30) mtr, COUNT (*) mtrcnt,
               SUM (su.segmbu) segmbu
          FROM su su
      GROUP BY su.tsnm, su.ii, su.sqlid)
SELECT   CAST (SUBSTR (smt.tsnm, 1, 15) AS VARCHAR2 (15)) "TsNm",
         CAST (LPAD (TRIM (TO_CHAR (smt.ii)), 2) AS VARCHAR2 (2)) "II",
         CAST (smt.mtrty AS VARCHAR2 (10)) "MtrTy",
         CAST (smt.mtr AS VARCHAR2 (30)) "Mtr",
         CAST (LPAD (TRIM (TO_CHAR (smt.mtrcnt)), 6) AS VARCHAR2 (6))
                                                                     "MtrCnt",
         CAST (LPAD (TRIM (TO_CHAR (tsa.tsmba, '9999999')), 7) AS VARCHAR2 (7)
              ) "  TsMbA",
         CAST (LPAD (TRIM (TO_CHAR (ss.ssmba, '9999999')), 7) AS VARCHAR2 (7)
              ) "  SsMbA",
         CAST
             (LPAD (TRIM (TO_CHAR (smt.segmbu, '9999990.99')), 10) AS VARCHAR2 (10)
             ) "    MtrMbU",
         CAST
            (LPAD (TRIM (TO_CHAR ((100 * (smt.segmbu / tsa.tsmba)),
                                  '990.9999'
                                 )
                        ),
                   9
                  ) AS VARCHAR2 (9)
            ) "MtrTsMbU%",
         CAST
            (LPAD (TRIM (TO_CHAR ((100 * (smt.segmbu / ss.ssmba)), '990.9999')
                        ),
                   9
                  ) AS VARCHAR2 (9)
            ) "MtrSsMbU%",
         CAST
            (LPAD
                (TRIM
                    (TO_CHAR
                        (DENSE_RANK () OVER (PARTITION BY smt.tsnm, smt.ii, smt.mtrty ORDER BY smt.segmbu DESC)
                        )
                    ),
                 6
                ) AS VARCHAR2 (6)
            ) "MtrRnk"
    FROM smt smt, tsa tsa, ss ss
   WHERE smt.tsnm = tsa.tsnm AND smt.tsnm = ss.tsnm AND smt.ii = ss.ii
ORDER BY 1 ASC, 2 ASC, 3 ASC, 11 ASC, 4 ASC;

set echo on;
--
pro Temporary tablespace utilization query by session and segment type (level 3, detail).
--
-- II is the database instance number.
-- TsNm is the tablespace name.
-- DuSID is the database session ID.
-- SegTy is the database session tablespace utilization segment type. 
-- TsMbA is the tablespace allocated size in megabytes.
-- SsMbA is the segment reported allocated size in megabytes.
-- SegMbU is the sub-segment used size in megabytes for the database session.
-- SegTsMbU% is the percent of the sub-segment used size for the database session within the tablespace.
-- SegSsMbU% is the percent of the sub-segment used size for the database session within the segment.
-- DuMbU is the total used size in megabytes for all the database session sub-segments with the tablespace.
-- DuRnk is the rank of the total sub-segment used size for the database session within the tablespace.
-- DuSIDInfo is a list of the following attributes for the database session:
--   Database user name and SID.
--   Database process ID.
--   Client user name.
--   Client process ID.
--   Client node.
--   Client program.
--   Session status.
--   SQL ID associated with the segment.
--   SQL hash associated with the segment.
--   Login timestamp.
--   Last client database call in seconds.
--
/* Formatted on 2013/11/18 18:04 (Formatter Plus v4.8.8) */
SET echo off;
WITH ts AS
     (SELECT ts.tablespace_name tsnm, ts.block_size tsbs
        FROM dba_tablespaces ts
       WHERE ts.CONTENTS = 'TEMPORARY'),
     tsa AS
     (SELECT   ts.tsnm tsnm, (SUM (tf.BYTES) / (1024 * 1024)) tsmba
          FROM ts ts, dba_temp_files tf
         WHERE ts.tsnm = tf.tablespace_name
      GROUP BY ts.tsnm),
     ss AS
     (SELECT ts.tsnm tsnm, ss.inst_id ii, ss.current_users cuuscnt,
             ((ss.total_blocks * ts.tsbs) / (1024 * 1024)) ssmba,
             ((ss.used_blocks * ts.tsbs) / (1024 * 1024)) ssmbu,
             ((ss.max_used_blocks * ts.tsbs) / (1024 * 1024)) ssmbmaxu,
             ((ss.max_sort_blocks * ts.tsbs) / (1024 * 1024)) ssmbmaxsu,
             ((ss.free_blocks * ts.tsbs) / (1024 * 1024)) ssmbf
        FROM ts ts, gv$sort_segment ss
       WHERE ts.tsnm = ss.tablespace_name),
     su AS
     (SELECT su.TABLESPACE tsnm, su.inst_id ii, su.segtype segty,
             su.sql_id sqlid, su.sqlhash sqlhs, TO_CHAR (us.SID) SID,
             (us.username || '[' || TRIM (TO_CHAR (us.SID)) || ']') dusid,
             us.username dunm, TO_CHAR (ps.spid) dupid, us.osuser cunm,
             us.process cupid, us.machine cunod, us.program cuprg,
             us.status stat, TO_CHAR (us.logon_time,
                                      'YYYYMMDD.HH24MISS') lgtm,
             TO_CHAR (us.last_call_et) lcet,
             ((su.blocks * ts.tsbs) / (1024 * 1024)) segmbu,
             SUM ((su.blocks * ts.tsbs) / (1024 * 1024)) OVER (PARTITION BY su.TABLESPACE, su.inst_id, us.SID)
                                                                        dumbu
        FROM gv$sort_usage su, gv$session us, gv$process ps, ts ts
       WHERE su.session_addr = us.saddr
         AND su.inst_id = us.inst_id
         AND us.paddr = ps.addr(+)
         AND us.inst_id = ps.inst_id(+)
         AND su.TABLESPACE = ts.tsnm)
SELECT   CAST (SUBSTR (su.tsnm, 1, 15) AS VARCHAR2 (15)) "TsNm",
         CAST (LPAD (TRIM (TO_CHAR (su.ii)), 2) AS VARCHAR2 (2)) "II",
         CAST (LPAD (TRIM (SUBSTR (su.SID, 1, 6)), 6) AS VARCHAR2 (6))
                                                                     " DuSID",
         CAST (SUBSTR (su.segty, 1, 10) AS VARCHAR2 (10)) "SegTy",
         CAST (LPAD (TRIM (TO_CHAR (tsa.tsmba, '9999999')), 7) AS VARCHAR2 (7)
              ) "  TsMbA",
         CAST (LPAD (TRIM (TO_CHAR (ss.ssmba, '9999999')), 7) AS VARCHAR2 (7)
              ) "  SsMbA",
         CAST
             (LPAD (TRIM (TO_CHAR (su.segmbu, '9999990.99')), 10) AS VARCHAR2 (10)
             ) "    SegMbU",
         CAST
             (LPAD (TRIM (TO_CHAR ((100 * (su.segmbu / tsa.tsmba)),
                                   '990.9999'
                                  )
                         ),
                    9
                   ) AS VARCHAR2 (9)
             ) "SegTsMbU%",
         CAST
             (LPAD (TRIM (TO_CHAR ((100 * (su.segmbu / ss.ssmba)), '990.9999')
                         ),
                    9
                   ) AS VARCHAR2 (9)
             ) "SegSsMbU%",
         CAST
             (LPAD (TRIM (TO_CHAR (su.dumbu, '9999990.99')), 10) AS VARCHAR2 (10)
             ) "     DuMbU",
         CAST
            (LPAD
                (TRIM
                    (TO_CHAR
                        (DENSE_RANK () OVER (PARTITION BY su.tsnm, su.ii ORDER BY su.dumbu DESC)
                        )
                    ),
                 5
                ) AS VARCHAR2 (5)
            ) "DuRnk",
         CAST (SUBSTR ((   TRIM (su.dusid)
                        || ','
                        || TRIM (su.dupid)
                        || ','
                        || TRIM (su.cunm)
                        || ','
                        || TRIM (su.cupid)
                        || ','
                        || TRIM (su.cunod)
                        || ','
                        || TRIM (su.cuprg)
                        || ','
                        || TRIM (su.stat)
                        || ','
                        || TRIM (su.sqlid)
                        || ','
                        || TRIM (su.sqlhs)
                        || ','
                        || TRIM (su.lgtm)
                        || ','
                        || TRIM (su.lcet)
                       ),
                       1,
                       150
                      ) AS VARCHAR2 (150)
              ) "DuSIDInfo"
    FROM su su, tsa tsa, ss ss
   WHERE su.tsnm = tsa.tsnm AND su.tsnm = ss.tsnm AND su.ii = ss.ii
ORDER BY 1 ASC, 2 ASC, 11 ASC, 3 ASC, 4 ASC;

  
##############################################
## Temp space used by a query 
##############################################

--for more that50gb used in last todays:-

SELECT
    sql_id,SQL_EXEC_ID,
    MAX (sample_time_min),
    MAX (gig)
FROM (  SELECT CAST (sample_time AS DATE) sample_time_min, --> here we are avoiding microsecond part in the sample_time, which will help us group samples from multiple RAC node to nearest second
                      sql_id,SQL_EXEC_ID,
                      ROUND (SUM (TEMP_SPACE_ALLOCATED) / (1024 * 1024 * 1024)) gig
             FROM gv$active_Session_history -->this will give me only 1 second granular data
            WHERE sample_time > SYSDATE - 1
            and sql_id='983zr72dt6sd1'
     GROUP BY CAST (sample_time AS DATE),SQL_EXEC_ID,
                      sql_id)
WHERE gig > 10
GROUP BY TRUNC (sample_time_min), sql_id,SQL_EXEC_ID
ORDER BY sql_id,TRUNC (sample_time_min);


select max(TEMP_SPACE_ALLOCATED), SAMPLE_ID from 
(select sum(TEMP_SPACE_ALLOCATED)/1024/1024/1024 TEMP_SPACE_ALLOCATED,
sql_id,SAMPLE_ID from gv$active_Session_history where SESSION_ID in  ('2538') 
group by sql_id,SAMPLE_ID
order by TEMP_SPACE_ALLOCATED desc
) where TEMP_SPACE_ALLOCATED >10 and rownum<100
group by SAMPLE_ID
order by SAMPLE_ID;


select round(max(TEMP_SPACE_ALLOCATED)) TEMP_SPACE_ALLOCATED, SAMPLE_ID,sql_id from 
(select sum(TEMP_SPACE_ALLOCATED)/1024/1024/1024 TEMP_SPACE_ALLOCATED,
sql_id,SAMPLE_ID from dba_hist_active_sess_history 
--where sql_id in  ('02037un0vttcz') 
group by sql_id,SAMPLE_ID
order by TEMP_SPACE_ALLOCATED desc
) where TEMP_SPACE_ALLOCATED >10 and rownum<100
group by SAMPLE_ID,sql_id
order by TEMP_SPACE_ALLOCATED ;

--http://www.antognini.ch/2009/05/wrong-information-about-temporary-space-usage/
SELECT max_tempseg_size, last_tempseg_size
FROM v$sql_plan_statistics_all
WHERE (sql_id, child_number) IN (SELECT prev_sql_id, prev_child_number
                                 FROM v$session
                                 WHERE sid = sys_context('userenv','sid'))
AND max_tempseg_size IS NOT NULL;
  
########################################################
## Queries using more than 10mb of temp
########################################################
break on sql_id skip 1
SELECT a.sql_id,gv$session.inst_id, sid, serial#, username, logon_time,
ROUND((SYSDATE-logon_time)*1440) timeonline_min, a.*, c.tempsize_GB
FROM gv$session, (
  SELECT inst_id, sql_id, ROUND(SUM(tempseg_size) /1024/1024/1024) tempsize_GB
  FROM gv$sql_workarea_active
  WHERE tempseg_size > 10000000
  GROUP BY inst_id, sql_id) c, (
    SELECT inst_id instance_number,sql_id, --sql_text,
    ROUND((conc_wait_sec_exec / elap_sec_exec)*100) con_perc,
    ROUND((clu_wait_sec_exec / elap_sec_exec)*100) clust_perc,
    ROUND((user_io_wait_sec_exec / elap_sec_exec)*100) io_perc,
    conc_wait_sec_exec, clu_wait_sec_exec, user_io_wait_sec_exec,
    cpu_time_sec_exec, elap_sec_exec, buffer_gets,
    ROUND((buffer_gets*32678)/1024/1024/1024) buffer_gb,
    disk_reads, rows_processed, module,service, action
    FROM (
      SELECT inst_id, sql_id, sql_text,
      ROUND((concurrency_wait_time/1000000)/DECODE(executions,NULL,1,0,1, executions),2) conc_wait_sec_exec,
      ROUND((cluster_wait_time/1000000)/DECODE(executions,NULL,1,0,1,executions),2) clu_wait_sec_exec,
      ROUND((user_io_wait_time/1000000)/DECODE(executions,NULL,1,0,1,executions),2) user_io_wait_sec_exec,
      ROUND((direct_writes/DECODE(executions,NULL,1,0,1,executions)),2) direct_writes_exec,
      ROUND((cpu_time/1000000)/DECODE(executions,NULL,1,0,1,executions),2) cpu_time_sec_exec,
      ROUND(( elapsed_time/1000000)/DECODE(executions,NULL,1,0,1,executions),2) elap_sec_exec,
      ROUND((io_interconnect_bytes/DECODE(executions,NULL,1,0,1,executions)),2) io_inter_by_exec,
      concurrency_wait_time, cluster_wait_time, user_io_wait_time, direct_writes,
      cpu_time, elapsed_time, io_interconnect_bytes,
      ROUND(sorts/DECODE(executions,NULL,1,0,1,executions),2) sort_exec,
      fetches, rows_processed, executions, parse_calls,
      ROUND(disk_reads/DECODE(executions,NULL,1,0,1,executions),2) disk_exec,
      ROUND(buffer_gets/DECODE(executions,NULL,1, 0,1,executions),2) buff_exec,
      service, module, action, buffer_gets, disk_reads
      FROM gv$sql
      WHERE users_opening > 0
      --AND elapsed_time/DECODE(executions, NULL, 1, 0, 1, executions) >= 30000000
	  )
    ) a
WHERE a.sql_id=gv$session.sql_id
AND a.instance_number = gv$session.inst_id
AND a.sql_id = c.sql_id
AND a.instance_number = c.inst_id
order by a.sql_id;
 


DBA_HIST_ACTIVE_SESS_HISTORY and DBA_HIST_SQL_PLAN and get SESSION_ID and TEMP_SPACE


select sample_time,session_id,session_serial#,sql_id,temp_space_allocated/1024/1024 temp_mb,
  temp_space_allocated/1024/1024-lag(temp_space_allocated/1024/1024,1,0) over (order by sample_time) as temp_diff
  --from dba_hist_active_sess_history
  from v$active_session_history
  where
  session_id=&1
  and session_serial#=&2
  order by sample_time asc
  /

select cast(sample_time as date) 





select round(max(TEMP_SPACE_ALLOCATED)) TEMP_SPACE_ALLOCATED, cast(sample_time as date) ,sql_id from 
(select sum(TEMP_SPACE_ALLOCATED)/1024/1024/1024 TEMP_SPACE_ALLOCATED,
sql_id,cast(sample_time as date)  from dba_hist_active_sess_history 
--where sql_id in  ('02037un0vttcz') 
group by sql_id,cast(sample_time as date) 
order by TEMP_SPACE_ALLOCATED desc
) where TEMP_SPACE_ALLOCATED >10 and rownum<100
group by cast(sample_time as date) ,sql_id
order by TEMP_SPACE_ALLOCATED ;



select user_id,action,sql_id,cast(sample_time as date) sample_time,  round(sum(TEMP_SPACE_ALLOCATED)/&_gb) TEMP_SPACE_ALLOCATED  
FROM gv$active_session_history WHERE sample_time between sysdate-1/24/2  and sysdate
and sql_id='25a9518wzpc3k'
group by   user_id,action,sql_id,cast(sample_time as date)
--having round(sum(TEMP_SPACE_ALLOCATED)/&_gb)>48
order by sample_time
/

a7dqpm8gyqq8q

select sql_id,cast(sample_time as date) sample_time,  round(sum(TEMP_SPACE_ALLOCATED)/&_gb) TEMP_SPACE_ALLOCATED  
FROM dba_hist_active_sess_history WHERE sample_time between sysdate-1   and sysdate
and sql_id='bn3yy4dnvb2k3'
group by  sql_id,cast(sample_time as date)
having round(sum(TEMP_SPACE_ALLOCATED)/&_gb)>10
order by sample_time
/

select sql_id,cast(sample_time as date) sample_time,  round(sum(TEMP_SPACE_ALLOCATED)/&_gb) TEMP_SPACE_ALLOCATED  
FROM gv$active_session_history WHERE sample_time between sysdate-1/24/2 and sysdate and sql_id='8rkgst0d96xh2'
group by  sql_id,cast(sample_time as date)
--having round(sum(TEMP_SPACE_ALLOCATED)/&_gb)>10
order by sample_time
/



select round(max(TEMP_SPACE_ALLOCATED)) TEMP_SPACE_ALLOCATED, cast(sample_time as date) ,sql_id from 
(select sum(TEMP_SPACE_ALLOCATED)/1024/1024/1024 TEMP_SPACE_ALLOCATED,
sql_id,cast(sample_time as date)   from dba_hist_active_sess_history 
where sql_id in  ('2rv7xp0hmxzu3') 
group by sql_id,cast(sample_time as date) 
order by TEMP_SPACE_ALLOCATED desc
) where TEMP_SPACE_ALLOCATED >10 and rownum<100
group by cast(sample_time as date) ,sql_id
order by TEMP_SPACE_ALLOCATED ;


select sql_id,trunc(sample_time), MAX(temp_space_usage/(1024*1024*1024)) MAX_TEMP_SPACE_IN_MB
  from 
    ( 
        select sql_id, sample_time, sum(temp_space_allocated) temp_space_usage
          from dba_hist_active_sess_history 
         where  sample_time > sysdate - 7
         and temp_space_allocated is not null
		 and SQL_PLAN_HASH_VALUE=3668368920
         group by sql_id,sample_time
         order by 3 desc
        ) 
        group by sql_id,trunc(sample_time)
        order by 2 desc
		
  SELECT sample_time,
         session_id,
         session_serial#,
         sql_id,
         temp_space_allocated / 1024 / 1024 temp_mb,
         temp_space_allocated / 1024 / 1024
         - LAG (temp_space_allocated / 1024 / 1024, 1, 0)
              OVER (ORDER BY sample_time)
            AS temp_diff
    FROM dba_hist_active_sess_history
   --from v$active_session_history
   WHERE session_id = &1 AND session_serial# = &2
ORDER BY sample_time ASC
/




  SELECT sample_time,
         session_id,
         session_serial#,
         sql_id,
         temp_space_allocated / 1024 / 1024 temp_mb,
         temp_space_allocated / 1024 / 1024
         - LAG (temp_space_allocated / 1024 / 1024, 1, 0)
              OVER (ORDER BY sample_time)
            AS temp_diff
    --from dba_hist_active_sess_history
    FROM v$active_session_history
   WHERE session_id = &1 AND session_serial# = &2
ORDER BY sample_time ASC;


#########################################
select sql_id,cast(sample_time as date) sample_time,  round(sum(TEMP_SPACE_ALLOCATED)/&_gb) TEMP_SPACE_ALLOCATED  
FROM gv$active_session_history WHERE sample_time between sysdate-1/24/2 and sysdate and sql_id='8rkgst0d96xh2'
group by  sql_id,cast(sample_time as date)
--having round(sum(TEMP_SPACE_ALLOCATED)/&_gb)>10
order by sample_time
/




select cast(sample_time as date) sample_time,  round(sum(TEMP_SPACE_ALLOCATED)/POWER(2,30)) TEMP_SPACE_ALLOCATED  
FROM gv$active_session_history WHERE sample_time between sysdate-0.00347 and sysdate and sql_id='8rkgst0d96xh2'
group by  sql_id,cast(sample_time as date)
having round(sum(TEMP_SPACE_ALLOCATED)/POWER(2,30))>250
order by sample_time
/


select cast(sample_time as date) sample_time,  round(sum(TEMP_SPACE_ALLOCATED)/POWER(2,30)) TEMP_SPACE_ALLOCATED  
FROM gv$active_session_history WHERE sample_time between sysdate-0.00347 and sysdate
group by  sql_id,cast(sample_time as date)
having round(sum(TEMP_SPACE_ALLOCATED)/POWER(2,30))>250
order by sample_time
/


select cast(sample_time as date) sample_time,  round(sum(TEMP_SPACE_ALLOCATED)/POWER(2,30)) TEMP_SPACE_ALLOCATED  
FROM gv$active_session_history WHERE sample_time between sysdate-0.00347 and sysdate
group by  sql_id,cast(sample_time as date)
having round(sum(TEMP_SPACE_ALLOCATED)/POWER(2,30))>250
order by sample_time
/



########################################################################
######################## scheduled in prod #############################
########################################################################
set line 190 pages 9999
alter session set nls_date_format = 'DD-MON-YYYY HH24:MI:SS';
alter session set nls_timestamp_format = 'DD-MON-YYYY HH24:MI:SS.FF';
alter session set nls_timestamp_tz_format = 'DD-MON-YYYY HH24:MI:SS.FF TZH:TZM';

col TOTAL_TEMP_ALLOC_PER_SEC_GB hea "Total Temp|Allo By sec| In Gig"
col TEMP_USED_BY_THIS_SQL_GB hea    "Total Used|By This SQL| In Gig"
col PCT_TEMP_USED_BY_THIS_SQL hea   "Temp Used |By This SQL| In PCT"
break on sample_time on report 
WITH mod0                                                    --grab 5mins data
     AS (SELECT a.*, CAST (sample_time AS DATE) sample_time_norm --normalized sample_time for RAC
           FROM gv$active_session_history a
          WHERE sample_time BETWEEN SYSDATE - 0.00347 AND SYSDATE
                AND TEMP_SPACE_ALLOCATED > 0),
     mod1                                --compute total temp usage per second
     AS (  SELECT sample_time_norm,
                  SUM (TEMP_SPACE_ALLOCATED) TOTAL_TEMP_ALLOC_PER_SEC
             FROM mod0
           HAVING SUM (mod0.TEMP_SPACE_ALLOCATED) > 0
         GROUP BY sample_time_norm),
     mod2
     AS (  SELECT                       --compute Temp used by individual SQLs
                 mod0.sample_time_norm,
                  mod0.user_id,
                  mod0.sql_id,
                  mod0.sql_exec_id,
                  mod0.sql_exec_start,
                  TOTAL_TEMP_ALLOC_PER_SEC,
                  SUM (mod0.temp_space_allocated) TEMP_USED_BY_THIS_SQL,
                  ROUND (
                     (SUM (mod0.temp_space_allocated)
                      / TOTAL_TEMP_ALLOC_PER_SEC)
                     * 100)
                     PCT_TEMP_USED_BY_THIS_SQL
             FROM mod0, mod1
            WHERE mod0.sample_time_norm = mod1.sample_time_norm
         GROUP BY mod0.sample_time_norm,
                  mod0.user_id,
                  mod0.sql_id,
                  mod0.sql_exec_id,
                  mod0.sql_exec_start,
                  TOTAL_TEMP_ALLOC_PER_SEC)
  SELECT mod2.sample_time_norm sample_time,
         u.username,
         mod2.sql_id,
         --mod2.sql_exec_id,
         mod2.sql_exec_start,
         ROUND (TOTAL_TEMP_ALLOC_PER_SEC / POWER (2, 30))
            TOTAL_TEMP_ALLOC_PER_SEC_GB,
         ROUND (mod2.TEMP_USED_BY_THIS_SQL / POWER (2, 30))
            TEMP_USED_BY_THIS_SQL_GB,
         PCT_TEMP_USED_BY_THIS_SQL
    FROM mod2, dba_users u
   WHERE (ROUND (TOTAL_TEMP_ALLOC_PER_SEC / POWER (2, 30)) >= 300
          OR ROUND (mod2.TEMP_USED_BY_THIS_SQL / POWER (2, 30)) >= 150)
         AND mod2.user_id = u.user_id(+)
ORDER BY mod2.sample_time_norm,PCT_TEMP_USED_BY_THIS_SQL desc;
