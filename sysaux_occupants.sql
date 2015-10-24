 --http://jhdba.wordpress.com/tag/vsysaux_occupants/
 
 
--#########################################
--v sysaux_occupants
--######################################### 
 select OCCUPANT_NAME,round(SPACE_USAGE_KBYTES/1024) SPACE_MB from V$SYSAUX_OCCUPANTS where round(SPACE_USAGE_KBYTES/1024)>1000;

 
 

column "item"            format a25
column "space used (gb)" format 999.99
column "schema"          format a25
column "move procedure"  format a40
 
select
   occupant_name "item",
   space_usage_kbytes/1048576 "space used (gb)",
   schema_name "schema",
   move_procedure "move procedure"
from
   v$sysaux_occupants
order by 1;
--#########################################
--How long old stats are kept
--#########################################
select dbms_stats.get_stats_history_retention from dual;

--#########################################
Set retention of old stats to 10 days

--#########################################
exec dbms_stats.alter_stats_history_retention(10);

--######################################### 
--Purge stats older than 10 days (best to do this in stages if there is a lot of data (sysdate-30,sydate-25 etc)
--######################################### 
	
exec DBMS_STATS.PURGE_STATS(SYSDATE-10);

--######################################### 
--Show available stats that have not been purged
--######################################### 
	
select dbms_stats.get_stats_history_availability from dual;

--######################################### 
--show top obejects in sysaux tablespace 
--######################################### 
--

col Mb form 9,999,999
col SEGMENT_NAME form a40
col SEGMENT_TYPE form a40
with mod as (select   segment_name,segment_type,sum(bytes/1024/1024) Mb from dba_segments
where  tablespace_name = 'SYSAUX' group by segment_name,segment_type order by  Mb desc)
select * from mod where rownum<11;



--######################################### 
--Show how big the tabel/indexes are ready for a rebuild after stats have been purged
--######################################### 
--
col Mb form 9,999,999
col SEGMENT_NAME form a40
col SEGMENT_TYPE form a6
set lines 120
select sum(bytes/1024/1024) Mb, segment_name,segment_type from dba_segments
where  tablespace_name = 'SYSAUX'
and segment_name like '%OPTSTAT%'
and (segment_type='TABLE'
or segment_type='INDEX')
group by segment_name,segment_type order by 1 asc




 select trunc(SAVTIME), count(*) from WRI$_OPTSTAT_HISTGRM_HISTORY group by trunc(SAVTIME) order by 1;
 
 
--######################################### 
--if your sysaux tablespace is growing, you can find out which components are occupying more space by running @?/rdbms/admin/awrinfo.sql
--
--######################################### 
 @?/rdbms/admin/awrinfo.sql 
