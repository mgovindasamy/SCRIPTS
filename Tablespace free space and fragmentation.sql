###################################################
##  prompt Tablespace free space and fragmentation
###################################################

set linesize 150
        column tablespace_name format a20 heading 'Tablespace'
     column sumb format 999,999,999
     column extents format 9999
     column bytes format 999,999,999,999
     column largest format 999,999,999,999
     column Tot_Size format 999,999 Heading 'Total| Size(Mb)'
     column Tot_Free format 999,999,999 heading 'Total Free(MB)'
     column Pct_Free format 999.99 heading '% Free'
     column Chunks_Free format 9999 heading 'No Of Ext.'
     column Max_Free format 999,999,999 heading 'Max Free(Kb)'
     set echo off
     PROMPT  FREE SPACE AVAILABLE IN TABLESPACES
     select a.tablespace_name,sum(a.tots/1048576) Tot_Size,
     sum(a.sumb/1048576) Tot_Free,
     sum(a.sumb)*100/sum(a.tots) Pct_Free,
     sum(a.largest/1024) Max_Free,sum(a.chunks) Chunks_Free
     from
     (
     select tablespace_name,0 tots,sum(bytes) sumb,
     max(bytes) largest,count(*) chunks
     from dba_free_space a
     group by tablespace_name
     union
     select tablespace_name,sum(bytes) tots,0,0,0 from
      dba_data_files
     group by tablespace_name) a
     group by a.tablespace_name
order by pct_free;


SET line 160
SET pages 154
SET pause OFF undef tablespace_name
column pct_increase format 999 heading "PCT|INCR"
column "% Used" format 999.99
column "MB free" format 99999990.99
column "MB total" format 99999990.99
column "total blks" format 99999990
column "Extents" format 99999990
column tablespace_name format a30 heading TABLESPACE
column autoextensible format a6 heading "Auto|Extend"
column EXTENT_MANAGEMENT format a10 heading "Extend|Mgmt"
column SEGMENT_SPACE_MANAGEMENT format a6 heading "SegSpc|Mgmt"
column ALLOCATION_TYPE format a9 heading "Allocation|Type"
column CONTENTS format a9 heading "Allocation|Type"
column EXTENTS format 99999990 heading "NoOf|Extents" Jus L
column FREE_CHUNKS format 99999990 heading "Free|Chunck" Jus L
column LARGEST_CHUNK_MB format 99999990 heading "Largest|Chunck(Mb)" Jus L
column FRAGMENTATION_INDEX format 99999990 heading "Fragment|Index" Jus L
BREAK ON report
compute SUM OF "GB total" ON report
compute SUM OF "GB free" ON report
SELECT    d.name,df.tablespace_name                                  ,
      ROUND(NVL(fs.GB,df.GB-NVL(ds.GB,0)),2) "GB free"        ,
      ROUND(df.GB,2) "GB total"                               ,
      (df.GB-NVL(fs.GB,df.GB-NVL(ds.GB,0)))*100/df.GB "% Used",
      fil2.CONTENTS                                           ,
      fil.AUTOEXTENSIBLE                                      ,
      fil2.EXTENT_MANAGEMENT                                  ,
      fil2.SEGMENT_SPACE_MANAGEMENT                           ,
      fil2.ALLOCATION_TYPE                                    ,
      NVL(ds.sum_ex,0) Extents                                ,
      NVL(free_chunks,0) free_chunks                          ,
      NVL(largest_chunk_mb,0) largest_chunk_mb                ,
      NVL(fragmentation_index,0) fragmentation_index
   FROM
      (SELECT    tablespace_name,
            SUM(bytes)/1024/1024/1024 GB
         FROM dba_temp_files
         GROUP BY tablespace_name
      UNION
      SELECT    tablespace_name,
            SUM(bytes)/1024/1024/1024 GB
         FROM dba_data_files
         GROUP BY tablespace_name
      ) df                            ,
      (SELECT DISTINCT tablespace_name, AUTOEXTENSIBLE FROM dba_data_files
      UNION
      SELECT DISTINCT tablespace_name , AUTOEXTENSIBLE FROM dba_temp_files
      ) fil                           ,
      (SELECT DISTINCT tablespace_name,
            CONTENTS                  ,
            SEGMENT_SPACE_MANAGEMENT  ,
            ALLOCATION_TYPE           ,
            EXTENT_MANAGEMENT
         FROM dba_tablespaces
      ) fil2                            ,
      (SELECT    tablespace_name        ,
            SUM(bytes)/1024/1024/1024 GB,
            SUM(extents) sum_ex
         FROM dba_segments
         GROUP BY tablespace_name
      ) ds                                                                                                    ,
      (SELECT    tablespace_name                                                                              ,
            SUM(bytes)/1024/1024/1024 GB                                                                      ,
            COUNT(*) free_chunks                                                                              ,
            DECODE( ROUND((MAX(bytes) / 1048576),2), NULL,0, ROUND((MAX(bytes) / 1048576),2)) largest_chunk_mb,
            NVL(ROUND(sqrt(MAX(blocks)/SUM(blocks))*(100/sqrt(sqrt(COUNT(blocks)) )),2), 0) fragmentation_index
         FROM dba_free_space
         GROUP BY tablespace_name
      ) fs,
	  (select name from v$database) d
   WHERE df.tablespace_name  = fs.tablespace_name (+)
      AND df.tablespace_name = ds.tablespace_name (+)
      AND df.tablespace_name = fil.tablespace_name (+)
      AND df.tablespace_name = fil2.tablespace_name (+)
      AND df.tablespace_name LIKE '%&tablespace_name%'
   ORDER BY "% Used" DESC;
