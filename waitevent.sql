select cast(min(sn.begin_interval_time) over (partition by sn.dbid,sn.snap_id) as date) snap_time,  --workaround to uniform snap_time over all instances in RAC
 --ss.dbid,  --uncomment if you have multiple dbid in your AWR
 sn.instance_number,
    ss.event_name,
 ss.wait_class,
 ss.total_waits,
    ss.time_waited_micro,
 ss.total_waits - lag(ss.total_waits) over (partition by ss.dbid,ss.instance_number,ss.event_id order by sn.snap_id nulls first) Delta_waits,
 ss.time_waited_micro - lag(ss.time_waited_micro) over (partition by ss.dbid,ss.instance_number,ss.event_id order by sn.snap_id nulls first) Delta_timewaited,
 round((ss.total_waits - lag(ss.total_waits) over (partition by ss.dbid,ss.instance_number,ss.event_id order by sn.snap_id nulls first)) /
       (extract(hour from END_INTERVAL_TIME-begin_interval_time)*3600 
              -extract(hour from sn.snap_timezone - lag(sn.snap_timezone) over (partition by ss.dbid,ss.instance_number,ss.event_id order by sn.snap_id nulls first) )*3600 --deals with daylight savings time change
              + extract(minute from END_INTERVAL_TIME-begin_interval_time)* 60
              + extract(second from END_INTERVAL_TIME-begin_interval_time)),2 ) Waits_per_sec,
 round((ss.time_waited_micro - lag(ss.time_waited_micro) over (partition by ss.dbid,ss.instance_number,ss.event_id order by sn.snap_id nulls first)) /
       (extract(hour from END_INTERVAL_TIME-begin_interval_time)*3600
              -extract(hour from sn.snap_timezone - lag(sn.snap_timezone) over (partition by ss.dbid,ss.instance_number,ss.event_id order by sn.snap_id nulls first) )*3600 --deals with daylight savings time change
              + extract(minute from END_INTERVAL_TIME-begin_interval_time)* 60
              + extract(second from END_INTERVAL_TIME-begin_interval_time)),2 ) Rate_timewaited,  -- time_waited_microsec/clock_time_sec
    round((ss.time_waited_micro - lag(ss.time_waited_micro) over (partition by ss.dbid,ss.instance_number,ss.event_id order by sn.snap_id nulls first)) /
           nullif(ss.total_waits - lag(ss.total_waits) over (partition by ss.dbid,ss.instance_number,ss.event_id order by sn.snap_id nulls first),0),2) Avg_wait_time_micro
from dba_hist_system_event ss,
     dba_hist_snapshot sn
where
    sn.snap_id = ss.snap_id
and sn.dbid = ss.dbid
and ss.event_name='DFS lock handle'
and sn.instance_number = ss.instance_number
--and sn.begin_interval_time &delta_time_where_clause
order by sn.snap_id
