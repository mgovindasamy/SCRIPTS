set lines 190 pages 150
col "#" for 99
col SNAPID for 9999999
col INSTID for 99
col VERSCNT for 99
break on PlanHV on report 
SELECT --ROWNUM "#",
       v.snap_id "SnapID",
       TO_CHAR(v.end_interval_time, 'YYYY-MM-DD/HH24:MI:SS') "Snaphot",
       v.instance_number "InstID",
       v.plan_hash_value "PlanHV",
       v.version_count "VersCnt",
       v.executions_delta "Execs",
       v.rows_processed_delta "RowsProc",
       --v.fetches_delta "Fetch",
       --v.loads_delta "Loads",
       --v.invalidations_delta "Inval",
       --v.parse_calls_delta "ParseCalls",
       v.buffer_gets_delta "BufferGets",
       v.disk_reads_delta "DiskReads",
       v.direct_writes_delta "DirectWrites",
       TO_CHAR(ROUND(v.elapsed_time_delta / 1e6, 3), '99999999999990D990') "ElapsedTime(s)",
       TO_CHAR(ROUND(v.cpu_time_delta / 1e6, 3), '99999999999990D990') "CPUTime(s)",
       TO_CHAR(ROUND(v.iowait_delta / 1e6, 3), '99999999999990D990') "IOTime(s)",
      -- TO_CHAR(ROUND(v.ccwait_delta / 1e6, 3), '99999999999990D990') "ConcTime(s)",
      -- TO_CHAR(ROUND(v.apwait_delta / 1e6, 3), '99999999999990D990') "ApplTime(s)",
       --TO_CHAR(ROUND(v.clwait_delta / 1e6, 3), '99999999999990D990') "ClusTime(s)",
       --TO_CHAR(ROUND(v.plsexec_time_delta / 1e6, 3), '99999999999990D990') "PLSQLTime(s)",
       --TO_CHAR(ROUND(v.javexec_time_delta / 1e6, 3), '99999999999990D990') "JavaTime(s)",
       v.optimizer_mode "OptimizerMode",
       --v.optimizer_cost "Cost",
      -- v.optimizer_env_hash_value "OptEnvHV",
       --v.parsing_schema_name "ParsingSchema",
       --v.module "Module",
       --v.action "Action",
       --v.sql_profile "Profile",
	   null
  FROM (
SELECT /*+ NO_MERGE */
       h.snap_id,
       s.end_interval_time,
       h.instance_number,
       h.plan_hash_value,
       h.optimizer_cost,
       h.optimizer_mode,
       h.optimizer_env_hash_value,
       h.version_count,
       h.module,
       h.action,
       h.sql_profile,
       h.parsing_schema_name,
       h.fetches_delta,
       h.executions_delta,
       h.loads_delta,
       h.invalidations_delta,
       h.parse_calls_delta,
       h.disk_reads_delta,
       h.buffer_gets_delta,
       h.rows_processed_delta,
       h.cpu_time_delta,
       h.elapsed_time_delta,
       h.iowait_delta,
       h.clwait_delta,
       h.apwait_delta,
       h.ccwait_delta,
       h.direct_writes_delta,
       h.plsexec_time_delta,
       h.javexec_time_delta
  FROM dba_hist_sqlstat h,
       dba_hist_snapshot s
 WHERE h.dbid =(select dbid from v$database)
   AND h.plan_hash_value = '&1'
   AND h.snap_id = s.snap_id
   AND h.dbid = s.dbid
   AND h.instance_number = s.instance_number
 ORDER BY
       s.end_interval_time desc,
       h.instance_number,
       h.plan_hash_value ) v
	   where rownum<201
	   order by "Snaphot" asc;
	   
set feed on
undef 1
