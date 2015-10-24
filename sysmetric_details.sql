

set linesize 190
set pagesize 1000

col "Time+Delta" for a14
col "Metric" for a70  trunc
col "Total" for a9
col metric_name for a20 trunc
col "Total All Instance" for a9 head "Total All|Instance"
col "Avg Per Instance" for a9 head "Avg Per|Instance"

col INST1 for a8 head "Inst 1"
col INST2 for a9 head "Inst 2"
col INST3 for a9 head "Inst 3"
col INST4 for a9 head "Inst 4"
col INST5 for a9 head "Inst 5"
col INST6 for a9 head "Inst 6"
col INST7 for a9 head "Inst 7"
col INST8 for a9 head "Inst 8"
col INST9 for a9 head "Inst 9"
col INST10 for a9 head "Inst 10"
col INST11 for a9 head "Inst 11"
col INST12 for a9 head "Inst 12"


select "Time+Delta", "Metric",
       CASE
       WHEN INST1 > POWER(2,50) THEN ROUND(INST1/POWER(2,50),1)||' P'
       WHEN INST1 > POWER(2,40) THEN ROUND(INST1/POWER(2,40),1)||' T'
       WHEN INST1 > POWER(2,30) THEN ROUND(INST1/POWER(2,30),1)||' G'
       WHEN INST1 > POWER(2,20) THEN ROUND(INST1/POWER(2,20),1)||' M'
       WHEN INST1 > POWER(2,10) THEN ROUND(INST1/POWER(2,10),1)||' K'
       WHEN INST1 > 0 THEN INST1||'  ' END  INST1,
       CASE
       WHEN INST2 > POWER(2,50) THEN ROUND(INST2/POWER(2,50),1)||' P'
       WHEN INST2 > POWER(2,40) THEN ROUND(INST2/POWER(2,40),1)||' T'
       WHEN INST2 > POWER(2,30) THEN ROUND(INST2/POWER(2,30),1)||' G'
       WHEN INST2 > POWER(2,20) THEN ROUND(INST2/POWER(2,20),1)||' M'
       WHEN INST2 > POWER(2,10) THEN ROUND(INST2/POWER(2,10),1)||' K'
       WHEN INST2 > 0 THEN INST2||'  ' END INST2,
       CASE
       WHEN INST3 > POWER(2,50) THEN ROUND(INST3/POWER(2,50),1)||' P'
       WHEN INST3 > POWER(2,40) THEN ROUND(INST3/POWER(2,40),1)||' T'
       WHEN INST3 > POWER(2,30) THEN ROUND(INST3/POWER(2,30),1)||' G'
       WHEN INST3 > POWER(2,20) THEN ROUND(INST3/POWER(2,20),1)||' M'
       WHEN INST3 > POWER(2,10) THEN ROUND(INST3/POWER(2,10),1)||' K'
       WHEN INST3 > 0 THEN INST3||'  ' END  INST3,
       CASE
       WHEN INST4 > POWER(2,50) THEN ROUND(INST4/POWER(2,50),1)||' P'
       WHEN INST4 > POWER(2,40) THEN ROUND(INST4/POWER(2,40),1)||' T'
       WHEN INST4 > POWER(2,30) THEN ROUND(INST4/POWER(2,30),1)||' G'
       WHEN INST4 > POWER(2,20) THEN ROUND(INST4/POWER(2,20),1)||' M'
       WHEN INST4 > POWER(2,10) THEN ROUND(INST4/POWER(2,10),1)||' K'
       WHEN INST4 > 0 THEN INST4||'  ' END  INST4,
       CASE
       WHEN INST5 > POWER(2,50) THEN ROUND(INST5/POWER(2,50),1)||' P'
       WHEN INST5 > POWER(2,40) THEN ROUND(INST5/POWER(2,40),1)||' T'
       WHEN INST5 > POWER(2,30) THEN ROUND(INST5/POWER(2,30),1)||' G'
       WHEN INST5 > POWER(2,20) THEN ROUND(INST5/POWER(2,20),1)||' M'
       WHEN INST5 > POWER(2,10) THEN ROUND(INST5/POWER(2,10),1)||' K'
       WHEN INST5 > 0 THEN INST5||'  ' END  INST5,
       CASE
       WHEN INST6 > POWER(2,50) THEN ROUND(INST6/POWER(2,50),1)||' P'
       WHEN INST6 > POWER(2,40) THEN ROUND(INST6/POWER(2,40),1)||' T'
       WHEN INST6 > POWER(2,30) THEN ROUND(INST6/POWER(2,30),1)||' G'
       WHEN INST6 > POWER(2,20) THEN ROUND(INST6/POWER(2,20),1)||' M'
       WHEN INST6 > POWER(2,10) THEN ROUND(INST6/POWER(2,10),1)||' K'
       WHEN INST6 > 0 THEN INST6||'  ' END  INST6,
       CASE
       WHEN INST7 > POWER(2,50) THEN ROUND(INST7/POWER(2,50),1)||' P'
       WHEN INST7 > POWER(2,40) THEN ROUND(INST7/POWER(2,40),1)||' T'
       WHEN INST7 > POWER(2,30) THEN ROUND(INST7/POWER(2,30),1)||' G'
       WHEN INST7 > POWER(2,20) THEN ROUND(INST7/POWER(2,20),1)||' M'
       WHEN INST7 > POWER(2,10) THEN ROUND(INST7/POWER(2,10),1)||' K'
       WHEN INST7 > 0 THEN INST7||'  ' END  INST7,
       CASE
       WHEN INST8 > POWER(2,50) THEN ROUND(INST8/POWER(2,50),1)||' P'
       WHEN INST8 > POWER(2,40) THEN ROUND(INST8/POWER(2,40),1)||' T'
       WHEN INST8 > POWER(2,30) THEN ROUND(INST8/POWER(2,30),1)||' G'
       WHEN INST8 > POWER(2,20) THEN ROUND(INST8/POWER(2,20),1)||' M'
       WHEN INST8 > POWER(2,10) THEN ROUND(INST8/POWER(2,10),1)||' K'
       WHEN INST8 > 0 THEN INST8||'  ' END  INST8 /* ,
       CASE
       WHEN INST9 > POWER(2,50) THEN ROUND(INST9/POWER(2,50),1)||' P'
       WHEN INST9 > POWER(2,40) THEN ROUND(INST9/POWER(2,40),1)||' T'
       WHEN INST9 > POWER(2,30) THEN ROUND(INST9/POWER(2,30),1)||' G'
       WHEN INST9 > POWER(2,20) THEN ROUND(INST9/POWER(2,20),1)||' M'
       WHEN INST9 > POWER(2,10) THEN ROUND(INST9/POWER(2,10),1)||' K'
       WHEN INST9 > 0 THEN INST9||'  ' END  INST9,
       CASE
       WHEN INST10 > POWER(2,50) THEN ROUND(INST10/POWER(2,50),1)||' P'
       WHEN INST10 > POWER(2,40) THEN ROUND(INST10/POWER(2,40),1)||' T'
       WHEN INST10 > POWER(2,30) THEN ROUND(INST10/POWER(2,30),1)||' G'
       WHEN INST10 > POWER(2,20) THEN ROUND(INST10/POWER(2,20),1)||' M'
       WHEN INST10 > POWER(2,10) THEN ROUND(INST10/POWER(2,10),1)||' K'
       WHEN INST10 > 0 THEN INST10||'  ' END  INST10,
       CASE
       WHEN INST11 > POWER(2,50) THEN ROUND(INST11/POWER(2,50),1)||' P'
       WHEN INST11 > POWER(2,40) THEN ROUND(INST11/POWER(2,40),1)||' T'
       WHEN INST11 > POWER(2,30) THEN ROUND(INST11/POWER(2,30),1)||' G'
       WHEN INST11 > POWER(2,20) THEN ROUND(INST11/POWER(2,20),1)||' M'
       WHEN INST11 > POWER(2,10) THEN ROUND(INST11/POWER(2,10),1)||' K'
       WHEN INST11 > 0 THEN INST11||'  ' END  INST11,
       CASE
       WHEN INST12 > POWER(2,50) THEN ROUND(INST12/POWER(2,50),1)||' P'
       WHEN INST12 > POWER(2,40) THEN ROUND(INST12/POWER(2,40),1)||' T'
       WHEN INST12 > POWER(2,30) THEN ROUND(INST12/POWER(2,30),1)||' G'
       WHEN INST12 > POWER(2,20) THEN ROUND(INST12/POWER(2,20),1)||' M'
       WHEN INST12 > POWER(2,10) THEN ROUND(INST12/POWER(2,10),1)||' K'
       WHEN INST12 > 0 THEN INST12||'  ' END  INST12 */ 	   ,
       CASE
       WHEN "Total"/inst_count > POWER(2,50) THEN ROUND("Total"/inst_count/POWER(2,50),1)||' P'
       WHEN "Total"/inst_count > POWER(2,40) THEN ROUND("Total"/inst_count/POWER(2,40),1)||' T'
       WHEN "Total"/inst_count > POWER(2,30) THEN ROUND("Total"/inst_count/POWER(2,30),1)||' G'
       WHEN "Total"/inst_count > POWER(2,20) THEN ROUND("Total"/inst_count/POWER(2,20),1)||' M'
       WHEN "Total"/inst_count > POWER(2,10) THEN ROUND("Total"/inst_count/POWER(2,10),1)||' K'
       WHEN "Total"/inst_count > 0 THEN ROUND("Total"/inst_count,1)||'  ' END  "Avg Per Instance", 
       CASE
       WHEN "Total" > POWER(2,50) THEN ROUND("Total"/POWER(2,50),1)||' P'
       WHEN "Total" > POWER(2,40) THEN ROUND("Total"/POWER(2,40),1)||' T'
       WHEN "Total" > POWER(2,30) THEN ROUND("Total"/POWER(2,30),1)||' G'
       WHEN "Total" > POWER(2,20) THEN ROUND("Total"/POWER(2,20),1)||' M'
       WHEN "Total" > POWER(2,10) THEN ROUND("Total"/POWER(2,10),1)||' K'
       WHEN "Total" > 0 THEN "Total"||'  ' END "Total All Instance"
from (
 select to_char(min(begin_time),'hh24:mi:ss')||' /'||round(avg(intsize_csec/100),0)||'s' "Time+Delta",
       --metric_name "Metric",
	   metric_name||' - '||metric_unit "Metric", 
       nvl(sum(value_inst1),0)+nvl(sum(value_inst2),0)+nvl(sum(value_inst3),0)+nvl(sum(value_inst4),0)+
       nvl(sum(value_inst5),0)+nvl(sum(value_inst6),0)+nvl(sum(value_inst7),0)+nvl(sum(value_inst8),0)+
       nvl(sum(value_inst9),0)+nvl(sum(value_inst10),0)+nvl(sum(value_inst11),0)+nvl(sum(value_inst12),0) "Total",
       sum(value_inst1) inst1, sum(value_inst2) inst2, sum(value_inst3) inst3, sum(value_inst4) inst4,
       sum(value_inst5) inst5, sum(value_inst6) inst6,sum(value_inst7) inst7, sum(value_inst8) inst8,
	   sum(value_inst9) inst9, sum(value_inst10) inst10,sum(value_inst11) inst11, sum(value_inst12) inst12,max(inst_count) inst_count
 from
  ( select begin_time,intsize_csec,metric_name,metric_unit,metric_id,group_id,(select count(inst_id) from gv$instance) inst_count,
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

prompt Metric col truncated
