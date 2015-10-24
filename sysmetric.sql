
col "Time+Delta" for a14
col metric for a56
col "Total All Instance" for a20
col "Avg Per Instance" for a20

set linesize 190
set pagesize 1000
set wrap off 
REM truncates the metric field to max length

select "Time+Delta", "Metric", 
       CASE
       WHEN "Total" > POWER(2,50) THEN ROUND("Total"/POWER(2,50),1)||' P'
       WHEN "Total" > POWER(2,40) THEN ROUND("Total"/POWER(2,40),1)||' T'
       WHEN "Total" > POWER(2,30) THEN ROUND("Total"/POWER(2,30),1)||' G'
       WHEN "Total" > POWER(2,20) THEN ROUND("Total"/POWER(2,20),1)||' M'
       WHEN "Total" > POWER(2,10) THEN ROUND("Total"/POWER(2,10),1)||' K'
       WHEN "Total" > 0 THEN "Total"||'  ' END "Total All Instance",
       CASE
       WHEN "Total"/inst_count > POWER(2,50) THEN ROUND("Total"/inst_count/POWER(2,50),1)||' P'
       WHEN "Total"/inst_count > POWER(2,40) THEN ROUND("Total"/inst_count/POWER(2,40),1)||' T'
       WHEN "Total"/inst_count > POWER(2,30) THEN ROUND("Total"/inst_count/POWER(2,30),1)||' G'
       WHEN "Total"/inst_count > POWER(2,20) THEN ROUND("Total"/inst_count/POWER(2,20),1)||' M'
       WHEN "Total"/inst_count > POWER(2,10) THEN ROUND("Total"/inst_count/POWER(2,10),1)||' K'
       WHEN "Total"/inst_count > 0 THEN "Total"/inst_count||'  ' END  "Avg Per Instance"
from (
 select to_char(min(begin_time),'hh24:mi:ss')||' /'||round(avg(intsize_csec/100),0)||'s' "Time+Delta",
	   metric_name "Metric",
       --metric_name||' - '||metric_unit "Metric", 
       nvl(sum(value_inst1),0)+nvl(sum(value_inst2),0)+nvl(sum(value_inst3),0)+nvl(sum(value_inst4),0)+
       nvl(sum(value_inst5),0)+nvl(sum(value_inst6),0)+nvl(sum(value_inst7),0)+nvl(sum(value_inst8),0)+
       nvl(sum(value_inst9),0)+nvl(sum(value_inst10),0)+nvl(sum(value_inst11),0)+nvl(sum(value_inst12),0) "Total",
       sum(value_inst1) inst1, sum(value_inst2) inst2, sum(value_inst3) inst3, sum(value_inst4) inst4,
       sum(value_inst5) inst5, sum(value_inst6) inst6, sum(value_inst7) inst7, sum(value_inst8) inst8,
	   sum(value_inst9) inst9, sum(value_inst10) inst10, sum(value_inst11) inst11, sum(value_inst12) inst12,max(inst_count) inst_count
 from
  ( select begin_time,intsize_csec,metric_name,metric_unit,metric_id,group_id,(select count(*) from gv$instance) inst_count,
       case inst_id when 1 then round(value,1) end value_inst1,
       case inst_id when 2 then round(value,1) end value_inst2,
       case inst_id when 3 then round(value,1) end value_inst3,
       case inst_id when 4 then round(value,1) end value_inst4,
       case inst_id when 5 then round(value,1) end value_inst5,
       case inst_id when 6 then round(value,1) end value_inst6,
       case inst_id when 7 then round(value,1) end value_inst7,
       case inst_id when 8 then round(value,1) end value_inst8,
       case inst_id when 9 then round(value,1) end value_inst9,
       case inst_id when 10 then round(value,1) end value_inst10,
       case inst_id when 11 then round(value,1) end value_inst11,
       case inst_id when 12 then round(value,1) end value_inst12
  from gv$sysmetric
  where metric_name in ('Host CPU Utilization (%)','Current OS Load', 'Physical Write Total IO Requests Per Sec',
        'Physical Write Total Bytes Per Sec', 'I/O Requests per Second', 'I/O Megabytes per Second',
        'Physical Read Total Bytes Per Sec', 'Physical Read Total IO Requests Per Sec',
        'CPU Usage Per Sec','Network Traffic Volume Per Sec','Logons Per Sec','Redo Generated Per Sec',
        'User Transaction Per Sec','Average Active Sessions','Average Synchronous Single-Block Read Latency','DB Block Changes Per Sec'
		,'Cell Physical IO Interconnect Bytes','Total PGA Allocated','Temp Space Used','PQ QC Session Count','PQ Slave Session Count','User Calls Per Sec')
  )
 group by metric_id,group_id,metric_name,metric_unit
 order by metric_name
);

set wrap on 
