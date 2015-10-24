@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@
select * from V$SYSMETRIC_HISTORY where metric_name='Current OS Load';

select unique metric_name from   V$SYSMETRIC_HISTORY --where metric_name like '%smart%'; 

select * from V$SYSMETRIC where metric_name='Buffer Cache Hit Ratio';

select * from V$SYSMETRIC;

select * from v$waitclassmetric_history;

select * from v$filemetric_history;


select * from DBSNMP.MGMT_BSLN_METRICS;

select * from DBA_TABLESPACE_USAGE_METRICS;

select * from GV$IOFUNCMETRIC_history where function_name='Smart Scan';


select * from AWRBL_METRIC_TYPE;


select * from  gV$IOSTAT_FUNCTION_DETAIL where function_id=11;

select * from V$STATISTICS_LEVEL;

select * from V$METRIC;

select * from V$METRIC;
select * from GV$METRICGROUP;
select * from GV$METRICNAME;
select * from GV$METRIC_HISTORY;

select * from   V$METRIC m, V$METRICNAME mn
where 
m.group_id=mn.group_id(+)
and m.METRIC_ID=mn.METRIC_ID;

select METRIC_NAME from V$METRIC where group_id in (2,3);
union 
select METRIC_NAME from V$METRIC where group_id in (2,3);

select unique m.BEGIN_TIME,m.end_time,m.INTSIZE_CSEC
, m.GROUP_ID    ,m.ENTITY_ID    ,m.ENTITY_SEQUENCE    ,m.METRIC_ID
, m.METRIC_NAME    , m.VALUE    , m.METRIC_UNIT ,mn.GROUP_NAME ,mg.MAX_INTERVAL
from   V$METRIC m, V$METRICNAME mn, V$METRICGROUP mg
where 
m.group_id=mn.group_id(+)
and m.group_id=mg.group_id(+)
and m.METRIC_ID=mn.METRIC_ID(+)
and m.group_id in (2,3);


select * from v$SESSMETRIC;


select * from v$SYSMETRIC;
select * from V$SYSMETRIC_HISTORY; -- interval,  1hr history 
select * from V$SYSMETRIC_SUMMARY; --1hr interval, 1hr history

a510777@fiodsxs1> select VIEW_DEFINITION from V$FIXED_VIEW_DEFINITION where view_name='GV$SYSMETRIC';

VIEW_DEFINITION
----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

SELECT inst_id, begtime, endtime, intsize_csec,          groupid, metricid, name, value, unit          FROM   x$kewmdrmv          WHERE flag1 = 1 AND groupid in (2,3)

a510777@fiodsxs1> select VIEW_DEFINITION from V$FIXED_VIEW_DEFINITION where view_name='GV$SYSMETRIC_SUMMARY';

VIEW_DEFINITION
----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

SELECT inst_id, begtime, endtime, intsize_csec,            groupid, metricid, name, numintv, max, min,            avg, std, unit          FROM   x$kewmsmdv          WHERE groupid = 2

a510777@fiodsxs1> select VIEW_DEFINITION from V$FIXED_VIEW_DEFINITION where view_name='GV$SYSMETRIC_HISTORY';

VIEW_DEFINITION
----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

SELECT inst_id, begtime, endtime, intsize_csec,            groupid, metricid, name, value, unit          FROM   x$kewmdrmv          WHERE groupid in (2,3)

@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@


http://www.oracle.com/technetwork/articles/schumacher-analysis-099313.html

https://docs.oracle.com/cd/B28359_01/server.111/b28274/autostat.htm#i35653

http://www.oraclerealworld.com/oracle-cpu-time/

http://www.pythian.com/blog/do-you-know-if-your-database-slow



https://sites.google.com/site/oraclemonitor/oracle-statistics-defined-11-2

https://sites.google.com/site/oraclemonitor/long-duration-sysmetric
https://sites.google.com/site/oraclemonitor/short-duration-sysmetric

http://oraperf.sourceforge.net/seminar/index.html

Storage Operations Management Work Plan - Kyle Hailey

V$SYSMETRIC displays the system metric values captured for the 
most current time interval for both the long duration (60-second) and short duration (15-second) system metrics.

v$sysmetric, v$sysmetric_history , v$sysmetric , and v$sysmetric_summary

DBA_HIST_SYSMETRIC_HISTORY
DBA_HIST_SYSMETRIC_SUMMARY
GV$SYSMETRIC
GV$SYSMETRIC_HISTORY
GV$SYSMETRIC_SUMMARY
 
 
response-time metrics
System-Level Response-Time Analysis

Starting at the global or system level, DBAs typically want answers to these questions:

    In general, how well is my database running? What defines efficiency?
    What average response time are my users experiencing?
    Which activities affect overall response time the most?

	
select * from V$METRIC;
select * from  V$METRICGROUP;
select * from  V$METRICNAME;
select * from  V$METRIC_HISTORY;


select * from   V$METRIC m, V$METRICNAME mn, V$METRICGROUP mg
where 
m.group_id=mn.group_id(+)
m.group_id=mg.group_id(+)
and m.METRIC_ID=mn.METRIC_ID(+);

select unique m.BEGIN_TIME,m.end_time,m.INTSIZE_CSEC
, m.GROUP_ID    ,m.ENTITY_ID    ,m.ENTITY_SEQUENCE    ,m.METRIC_ID
, m.METRIC_NAME    , m.VALUE    , m.METRIC_UNIT ,mn.GROUP_NAME ,mg.MAX_INTERVAL
from   V$METRIC m, V$METRICNAME mn, V$METRICGROUP mg
where 
m.group_id=mn.group_id(+)
and m.group_id=mg.group_id(+)
and m.METRIC_ID=mn.METRIC_ID(+)
and m.group_id in (2,3);

GID 	"Group NAME" 	"Entity ID" 	"Entity Sequence"
0 	Event Metrics 	Event# 	N/A
1 	Event Class Metrics 	Wait Class ID 	N/A
2 	System Metrics Long Duration 	N/A 	N/A
3 	System Metrics Short Duration 	N/A 	N/A
4 	Session Metrics Long Duration 	Session ID 	Serial#
5 	Session Metrics Short Duration 	Session ID 	Serial#
6 	Service Metrics 	N/A 	Service Hash
7 	File Metrics Long Duration 	File# 	Creation Change#
9 	Tablespace Metrics Long Duration 	Tablespace# 	N/A
10 	Service Metrics (Short) 	N/A 	Service Hash




select * from v$SYSMETRIC;
select * from V$SYSMETRIC_HISTORY; -- interval,  1hr history 
select * from V$SYSMETRIC_SUMMARY; --1hr interval, 1hr history


SELECT BEGIN_TIME,
       END_TIME,
       INTSIZE_CSEC,
       GROUP_ID,
       METRIC_ID,
       METRIC_NAME || '-' || METRIC_UNIT METRIC_NAME_UNIT,
       ROUND (VALUE, 2) VALUE
  FROM V$SYSMETRIC;

a510777@fiodsxs1> select VIEW_DEFINITION from V$FIXED_VIEW_DEFINITION where view_name='GV$SYSMETRIC';

VIEW_DEFINITION
----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

SELECT inst_id, begtime, endtime, intsize_csec,          groupid, metricid, name, value, unit          FROM   x$kewmdrmv          WHERE flag1 = 1 AND groupid in (2,3)

a510777@fiodsxs1> select VIEW_DEFINITION from V$FIXED_VIEW_DEFINITION where view_name='GV$SYSMETRIC_SUMMARY';

VIEW_DEFINITION
----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

SELECT inst_id, begtime, endtime, intsize_csec,            groupid, metricid, name, numintv, max, min,            avg, std, unit          FROM   x$kewmsmdv          WHERE groupid = 2

a510777@fiodsxs1> select VIEW_DEFINITION from V$FIXED_VIEW_DEFINITION where view_name='GV$SYSMETRIC_HISTORY';

VIEW_DEFINITION
----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

SELECT inst_id, begtime, endtime, intsize_csec,            groupid, metricid, name, value, unit          FROM   x$kewmdrmv          WHERE groupid in (2,3)




########################

system-Level Response-Time Analysis

Starting at the global or system level, DBAs typically want answers to these questions:

    In general, how well is my database running? What defines efficiency?
    What average response time are my users experiencing?
    Which activities affect overall response time the most?

The answers to these questions have been fairly elusive for DBAs before Oracle Database 10g, but now such metrics can be somewhat easy to capture if you happen to be using the latest and greatest Oracle database.

First of all, part of the answer to how well, in general, a database is running can be obtained by issuing this query in Oracle Database 10g: 
select  METRIC_NAME,
        VALUE
from    SYS.V_$SYSMETRIC
where   METRIC_NAME IN ('Database CPU Time Ratio',
                        'Database Wait Time Ratio') AND
        INTSIZE_CSEC = 
        (select max(INTSIZE_CSEC) from SYS.V_$SYSMETRIC); 
		
		
You can also take a quick look over the last hour to see if the database has experienced any dips in overall performance by using this query:

                               
select  end_time,
        value
from    sys.v_$sysmetric_history
where   metric_name = 'Database CPU Time Ratio'
order by 1;



select  case db_stat_name
            when 'parse time elapsed' then 
                'soft parse time'
            else db_stat_name
            end db_stat_name,
        case db_stat_name
            when 'sql execute elapsed time' then 
                time_secs - plsql_time 
            when 'parse time elapsed' then 
                time_secs - hard_parse_time
            else time_secs
            end time_secs,
        case db_stat_name
            when 'sql execute elapsed time' then 
                round(100 * (time_secs - plsql_time) / db_time,2)
            when 'parse time elapsed' then 
                round(100 * (time_secs - hard_parse_time) / db_time,2)  
            else round(100 * time_secs / db_time,2)  
            end pct_time
from
(select stat_name db_stat_name,
        round((value / 1000000),3) time_secs
    from sys.v_$sys_time_model
    where stat_name not in('DB time','background elapsed time',
                            'background cpu time','DB CPU')),
(select round((value / 1000000),3) db_time 
    from sys.v_$sys_time_model 
    where stat_name = 'DB time'),
(select round((value / 1000000),3) plsql_time 
    from sys.v_$sys_time_model 
    where stat_name = 'PL/SQL execution elapsed time'),
(select round((value / 1000000),3) hard_parse_time 
    from sys.v_$sys_time_model 
    where stat_name = 'hard parse elapsed time')
order by 2 desc;


select  WAIT_CLASS,
        TOTAL_WAITS,
        round(100 * (TOTAL_WAITS / SUM_WAITS),2) PCT_WAITS,
        ROUND((TIME_WAITED / 100),2) TIME_WAITED_SECS,
        round(100 * (TIME_WAITED / SUM_TIME),2) PCT_TIME
from
(select WAIT_CLASS,
        TOTAL_WAITS,
        TIME_WAITED
from    V$SYSTEM_WAIT_CLASS
where   WAIT_CLASS != 'Idle'),
(select  sum(TOTAL_WAITS) SUM_WAITS,
        sum(TIME_WAITED) SUM_TIME
from    V$SYSTEM_WAIT_CLASS
where   WAIT_CLASS != 'Idle')
order by 5 desc;



select  to_char(a.end_time,'DD-MON-YYYY HH:MI:SS') end_time,
        b.wait_class,
        round((a.time_waited / 100),2) time_waited 
from    sys.v_$waitclassmetric_history a,
        sys.v_$system_wait_class b
where   a.wait_class# = b.wait_class# and
        b.wait_class != 'Idle'
order by 1,2;



Oracle System-Level Response-Time Analysis


with epsilon
as
(select avg(average - STANDARD_DEVIATION ) m1,
avg(average +  STANDARD_DEVIATION ) m2
from dba_hist_sysmetric_summary
where metric_name='User Calls Per Sec')
select avg(round(a.average + a.STANDARD_DEVIATION)) + stddev(round(a.average + a.STANDARD_DEVIATION)) A,
avg(round(a.average + (a.STANDARD_DEVIATION/2))) + stddev(round(a.average + (a.STANDARD_DEVIATION/2))) B,
avg(round(a.average)) C,
avg(round(a.average - (a.STANDARD_DEVIATION/2))) - stddev(round(a.average - (a.STANDARD_DEVIATION/2))) D,
avg(round(a.average - a.STANDARD_DEVIATION)) - stddev(round(a.average - a.STANDARD_DEVIATION)) E
from dba_hist_sysmetric_summary a,
dba_hist_sysmetric_summary b,
epsilon e
where a.metric_name='Database CPU Time Ratio'
and b.metric_name='User Calls Per Sec'
and a.snap_id = b.snap_id
and b.average between e.m1 and e.m2
/
 
'Database CPU Time Ratio','Database Wait Time Ratio'


select  a.end_time,
        a.value,b.value,a.value+b.value
from     v$sysmetric a,v$sysmetric b
where   a.metric_name = 'Database Wait Time Ratio'
and b.metric_name = 'Database CPU Time Ratio' and a.group_id=2
and a.group_id=b.group_id;


select  a.end_time,
        a.value 
from     v$sysmetric a 
where   a.metric_name = 'Host CPU Usage Per Sec' and a.group_id=2



###################################### Histograms ##############################

with epsilon
as
(select avg(average - STANDARD_DEVIATION ) m1,
        avg(average +  STANDARD_DEVIATION ) m2
from dba_hist_sysmetric_summary
where metric_name='User Calls Per Sec')
select avg(a.average -  a.STANDARD_DEVIATION) "A - Good",
       avg(a.average) "Average",
       avg(a.average + a.STANDARD_DEVIATION)  "B - Bad"
from dba_hist_sysmetric_summary a,
dba_hist_sysmetric_summary b,
epsilon e
where a.metric_name='SQL Service Response Time'
and b.metric_name='User Calls Per Sec'
and a.snap_id = b.snap_id
and b.average between e.m1 and e.m2
/


/* Formatted on 11/24/2014 5:47:19 PM (QP5 v5.163.1008.3004) */
WITH mod0 as (
select min(snap_id) bid,max(snap_id) eid from dba_hist_snapshot where END_INTERVAL_TIME>sysdate-31 and dbid=(select dbid from v$database)) ,
epsilon
     AS (  SELECT AVG (average - STANDARD_DEVIATION) m1,
                  AVG (average + STANDARD_DEVIATION) m2,
                  GROUP_ID
             FROM dba_hist_sysmetric_summary a,mod0 b
            WHERE a.snap_id between b.bid and b.eid and metric_name = 'User Calls Per Sec' AND GROUP_ID = 2
         GROUP BY GROUP_ID),
     scale
     AS (SELECT AVG (ROUND (a.average + a.STANDARD_DEVIATION))
                + STDDEV (ROUND (a.average + a.STANDARD_DEVIATION))
                   Heavy,
                AVG (ROUND (a.average + (a.STANDARD_DEVIATION / 2)))
                + STDDEV (ROUND (a.average + (a.STANDARD_DEVIATION / 2)))
                   Good_p,
                AVG (ROUND (a.average)) Great,
                AVG (ROUND (a.average - (a.STANDARD_DEVIATION / 2)))
                - STDDEV (ROUND (a.average - (a.STANDARD_DEVIATION / 2)))
                   Good_M,
                AVG (ROUND (a.average - a.STANDARD_DEVIATION))
                - STDDEV (ROUND (a.average - a.STANDARD_DEVIATION))
                   Less
           FROM dba_hist_sysmetric_summary a,
                dba_hist_sysmetric_summary b,
                epsilon e,mod0 s
          WHERE     a.metric_name = 'Database CPU Time Ratio'
                AND b.metric_name = 'User Calls Per Sec'
                AND a.snap_id between s.bid and s.eid
                AND a.snap_id = b.snap_id
                AND b.average BETWEEN e.m1 AND e.m2
                AND a.GROUP_ID = e.GROUP_ID
                AND b.GROUP_ID = e.GROUP_ID)
SELECT Great "Great",
       VALUE "Current",
       CASE
          WHEN VALUE < Less
          THEN
             'Database Under Utilized'
          WHEN VALUE BETWEEN Less AND Good_M
          THEN
             'Less than Normal User Activity'
          WHEN VALUE BETWEEN Good_M AND Good_p
          THEN
             'Normal User Activity'
          WHEN VALUE BETWEEN Good_p AND Heavy
          THEN
             'More than Normal User Activity'
          WHEN VALUE > Heavy
          THEN
             'Database Overburdened'
       END
		  "Overall"
  FROM v$sysmetric, scale 
 WHERE metric_name = 'Database CPU Time Ratio' AND GROUP_ID = 2;
 
 
 
Class 	Description
1 	User
2 	Redo
4 	Enqueue
8 	Cache
16 	OS
32 	Real Application Clusters
64 	SQL
128 	Debug

http://www.oaktable.net/content/graphing-oracle-vsysstat




select * from  v$alert_types ;

select * from  v$threshold_types ;

SELECT /*+ ORDERED USE_MERGE(m) */
TO_CHAR(CAST(m.end_time AS TIMESTAMP) AT TIME ZONE 'GMT',
'YYYY-MM-DD HH24:MI:SS TZD'),
SUM(CASE WHEN a.internal_metric_name = 'cpu_time_pct'
THEN m.value ELSE 0 END) cpu_time_pct
FROM v$alert_types a, v$threshold_types t, v$sysmetric m
WHERE a.internal_metric_category = 'instance_efficiency'
AND a.reason_id = t.alert_reason_id
AND t.metrics_id = m.metric_id
AND m.group_id = 2
GROUP BY m.end_time
ORDER BY m.end_time ASC
 
a510777@fiordxp9> desc v$alert_types
           Name                                            Null?    Type
           ----------------------------------------------- -------- -------------------------

    1      REASON_ID                                                NUMBER
    2      OBJECT_TYPE                                              VARCHAR2(64)
    3      TYPE                                                     VARCHAR2(9)
    4      GROUP_NAME                                               VARCHAR2(64)
    5      SCOPE                                                    VARCHAR2(8)
    6      INTERNAL_METRIC_CATEGORY                                 VARCHAR2(64)
    7      INTERNAL_METRIC_NAME                                     VARCHAR2(64)

a510777@fiordxp9> desc v$threshold_types
           Name                                            Null?    Type
           ----------------------------------------------- -------- -------------------------

    1      METRICS_ID                                               NUMBER
    2      METRICS_GROUP_ID                                         NUMBER
    3      OPERATOR_MASK                                            NUMBER
    4      OBJECT_TYPE                                              VARCHAR2(64)
    5      ALERT_REASON_ID                                          NUMBER
    6      METRIC_VALUE_TYPE                                        NUMBER

a510777@fiordxp9>

 select * from v$sysmetric a,  v$threshold_types b where group_id=2 and a.METRIC_ID=b.METRICS_ID;
 
 
 select metric_name from  v$sysmetric where group_id=2 minus select a.metric_name from v$sysmetric a,  v$threshold_types b where group_id=2 and a.METRIC_ID=b.METRICS_ID
 
 
SELECT /*+ ORDERED USE_MERGE(m) */
m.metric_name ,a.*
FROM v$alert_types a, v$threshold_types t, v$sysmetric m
WHERE  a.reason_id(+) = t.alert_reason_id
AND t.metrics_id(+) = m.metric_id
AND m.group_id = 2
