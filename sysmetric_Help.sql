 
select  a.end_time,decode(a.GROUP_ID,2,'Delta 60Sec',3,'Delta 15Sec')||'~'|| decode(a.metric_name,'Active Parallel Sessions','Throughput~Active Parallel Sessions',
'Active Serial Sessions','Others~Active Serial Sessions',
'Average Active Sessions','Throughput~Average Active Sessions',
'Average Active Sessions','Throughput~Average Active Sessions',
'Average Synchronous Single-Block Read Latency','Throughput~Average Synchronous Single-Block Read Latency',
'Background Checkpoints Per Sec','Throughput~Background Checkpoints Per Sec',
'Background CPU Usage Per Sec','Others~Background CPU Usage Per Sec',
'Background Time Per Sec','Others~Background Time Per Sec',
'Branch Node Splits Per Sec','Throughput~Branch Node Splits Per Sec',
'Branch Node Splits Per Txn','Throughput~Branch Node Splits Per Txn',
'Buffer Cache Hit Ratio','Efficiency~Buffer Cache Hit Ratio',
'Buffer Cache Hit Ratio','Efficiency~Buffer Cache Hit Ratio',
'Captured user calls','RAT~Captured user calls',
'Cell Physical IO Interconnect Bytes','Throughput~Cell Physical IO Interconnect Bytes',
'Cell Physical IO Interconnect Bytes','Throughput~Cell Physical IO Interconnect Bytes',
'Consistent Read Changes Per Sec','Throughput~Consistent Read Changes Per Sec',
'Consistent Read Changes Per Sec','Throughput~Consistent Read Changes Per Sec',
'Consistent Read Changes Per Txn','Throughput~Consistent Read Changes Per Txn',
'Consistent Read Changes Per Txn','Throughput~Consistent Read Changes Per Txn',
'Consistent Read Gets Per Sec','Throughput~Consistent Read Gets Per Sec',
'Consistent Read Gets Per Sec','Throughput~Consistent Read Gets Per Sec',
'Consistent Read Gets Per Txn','Throughput~Consistent Read Gets Per Txn',
'Consistent Read Gets Per Txn','Throughput~Consistent Read Gets Per Txn',
'CPU Usage Per Sec','Efficiency~CPU Usage Per Sec',
'CPU Usage Per Txn','Efficiency~CPU Usage Per Txn',
'CR Blocks Created Per Sec','Throughput~CR Blocks Created Per Sec',
'CR Blocks Created Per Txn','Throughput~CR Blocks Created Per Txn',
'CR Undo Records Applied Per Sec','Throughput~CR Undo Records Applied Per Sec',
'CR Undo Records Applied Per Txn','Throughput~CR Undo Records Applied Per Txn',
'Current Logons Count','Limit~Current Logons Count',
'Current Open Cursors Count','Limit~Current Open Cursors Count',
'Current OS Load','Load~Current OS Load',
'Cursor Cache Hit Ratio','Efficiency~Cursor Cache Hit Ratio',
'Database CPU Time Ratio','Efficiency~Database CPU Time Ratio',
'Database CPU Time Ratio','Efficiency~Database CPU Time Ratio',
'Database Time Per Sec','Throughput~Database Time Per Sec',
'Database Time Per Sec','Throughput~Database Time Per Sec',
'Database Wait Time Ratio','Others~Database Wait Time Ratio',
'DB Block Changes Per Sec','Throughput~DB Block Changes Per Sec',
'DB Block Changes Per Sec','Throughput~DB Block Changes Per Sec',
'DB Block Changes Per Txn','Throughput~DB Block Changes Per Txn',
'DB Block Changes Per Txn','Throughput~DB Block Changes Per Txn',
'DB Block Changes Per User Call','Others~DB Block Changes Per User Call',
'DB Block Gets Per Sec','Throughput~DB Block Gets Per Sec',
'DB Block Gets Per Sec','Throughput~DB Block Gets Per Sec',
'DB Block Gets Per Txn','Throughput~DB Block Gets Per Txn',
'DB Block Gets Per Txn','Throughput~DB Block Gets Per Txn',
'DB Block Gets Per User Call','Others~DB Block Gets Per User Call',
'DBWR Checkpoints Per Sec','Throughput~DBWR Checkpoints Per Sec',
'DDL statements parallelized Per Sec','Efficiency~DDL statements parallelized Per Sec',
'Disk Sort Per Sec','Throughput~Disk Sort Per Sec',
'Disk Sort Per Txn','Throughput~Disk Sort Per Txn',
'DML statements parallelized Per Sec','Efficiency~DML statements parallelized Per Sec',
'Enqueue Deadlocks Per Sec','Throughput~Enqueue Deadlocks Per Sec',
'Enqueue Deadlocks Per Txn','Throughput~Enqueue Deadlocks Per Txn',
'Enqueue Requests Per Sec','Throughput~Enqueue Requests Per Sec',
'Enqueue Requests Per Txn','Throughput~Enqueue Requests Per Txn',
'Enqueue Timeouts Per Sec','Throughput~Enqueue Timeouts Per Sec',
'Enqueue Timeouts Per Txn','Throughput~Enqueue Timeouts Per Txn',
'Enqueue Waits Per Sec','Throughput~Enqueue Waits Per Sec',
'Enqueue Waits Per Txn','Throughput~Enqueue Waits Per Txn',
'Execute Without Parse Ratio','Throughput~Execute Without Parse Ratio',
'Execute Without Parse Ratio','Throughput~Execute Without Parse Ratio',
'Executions Per Sec','Throughput~Executions Per Sec',
'Executions Per Sec','Throughput~Executions Per Sec',
'Executions Per Txn','Others~Executions Per Txn',
'Executions Per Txn','Others~Executions Per Txn',
'Executions Per User Call','Others~Executions Per User Call',
'Full Index Scans Per Sec','Throughput~Full Index Scans Per Sec',
'Full Index Scans Per Sec','Throughput~Full Index Scans Per Sec',
'Full Index Scans Per Txn','Throughput~Full Index Scans Per Txn',
'Full Index Scans Per Txn','Throughput~Full Index Scans Per Txn',
'GC CR Block Received Per Second','Others~GC CR Block Received Per Second',
'GC CR Block Received Per Txn','Others~GC CR Block Received Per Txn',
'GC Current Block Received Per Second','Others~GC Current Block Received Per Second',
'GC Current Block Received Per Txn','Others~GC Current Block Received Per Txn',
'Global Cache Average CR Get Time','RAC~Global Cache Average CR Get Time',
'Global Cache Average Current Get Time','RAC~Global Cache Average Current Get Time',
'Global Cache Blocks Corrupted','Efficiency~Global Cache Blocks Corrupted',
'Global Cache Blocks Lost','Efficiency~Global Cache Blocks Lost',
'Hard Parse Count Per Sec','Throughput~Hard Parse Count Per Sec',
'Hard Parse Count Per Txn','Throughput~Hard Parse Count Per Txn',
'Host CPU Usage Per Sec','Load~Host CPU Usage Per Sec',
'Host CPU Usage Per Sec','Load~Host CPU Usage Per Sec',
'Host CPU Utilization (%)','Load~Host CPU Utilization (%)',
'Host CPU Utilization (%)','Load~Host CPU Utilization (%)',
'I/O Megabytes per Second','Throughput~I/O Megabytes per Second',
'I/O Requests per Second','Throughput~I/O Requests per Second',
'Leaf Node Splits Per Sec','Throughput~Leaf Node Splits Per Sec',
'Leaf Node Splits Per Txn','Throughput~Leaf Node Splits Per Txn',
'Library Cache Hit Ratio','Efficiency~Library Cache Hit Ratio',
'Library Cache Hit Ratio','Efficiency~Library Cache Hit Ratio',
'Library Cache Miss Ratio','Efficiency~Library Cache Miss Ratio',
'Logical Reads Per Sec','Throughput~Logical Reads Per Sec',
'Logical Reads Per Sec','Throughput~Logical Reads Per Sec',
'Logical Reads Per Txn','Throughput~Logical Reads Per Txn',
'Logical Reads Per Txn','Throughput~Logical Reads Per Txn',
'Logical Reads Per User Call','Others~Logical Reads Per User Call',
'Logons Per Sec','Throughput~Logons Per Sec',
'Logons Per Sec','Throughput~Logons Per Sec',
'Logons Per Txn','Throughput~Logons Per Txn',
'Logons Per Txn','Throughput~Logons Per Txn',
'Long Table Scans Per Sec','Throughput~Long Table Scans Per Sec',
'Long Table Scans Per Txn','Throughput~Long Table Scans Per Txn',
'Memory Sorts Ratio','Others~Memory Sorts Ratio',
'Memory Sorts Ratio','Throughput~Memory Sorts Ratio',
'Network Traffic Volume Per Sec','Throughput~Network Traffic Volume Per Sec',
'Open Cursors Per Sec','Throughput~Open Cursors Per Sec',
'Open Cursors Per Txn','Throughput~Open Cursors Per Txn',
'Parse Failure Count Per Sec','Throughput~Parse Failure Count Per Sec',
'Parse Failure Count Per Txn','Throughput~Parse Failure Count Per Txn',
'PGA Cache Hit %','Efficiency~PGA Cache Hit %',
'Physical Read Bytes Per Sec','Throughput~Physical Read Bytes Per Sec',
'Physical Read IO Requests Per Sec','Throughput~Physical Read IO Requests Per Sec',
'Physical Read Total Bytes Per Sec','Throughput~Physical Read Total Bytes Per Sec',
'Physical Read Total IO Requests Per Sec','Throughput~Physical Read Total IO Requests Per Sec',
'Physical Reads Direct Lobs Per Sec','Throughput~Physical Reads Direct Lobs Per Sec',
'Physical Reads Direct Lobs Per Txn','Throughput~Physical Reads Direct Lobs Per Txn',
'Physical Reads Direct Per Sec','Throughput~Physical Reads Direct Per Sec',
'Physical Reads Direct Per Sec','Throughput~Physical Reads Direct Per Sec',
'Physical Reads Direct Per Txn','Throughput~Physical Reads Direct Per Txn',
'Physical Reads Direct Per Txn','Throughput~Physical Reads Direct Per Txn',
'Physical Reads Per Sec','Throughput~Physical Reads Per Sec',
'Physical Reads Per Sec','Throughput~Physical Reads Per Sec',
'Physical Reads Per Txn','Throughput~Physical Reads Per Txn',
'Physical Reads Per Txn','Throughput~Physical Reads Per Txn',
'Physical Write Bytes Per Sec','Throughput~Physical Write Bytes Per Sec',
'Physical Write IO Requests Per Sec','Throughput~Physical Write IO Requests Per Sec',
'Physical Write Total Bytes Per Sec','Throughput~Physical Write Total Bytes Per Sec',
'Physical Write Total IO Requests Per Sec','Throughput~Physical Write Total IO Requests Per Sec',
'Physical Writes Direct Lobs  Per Txn','Throughput~Physical Writes Direct Lobs  Per Txn',
'Physical Writes Direct Lobs Per Sec','Throughput~Physical Writes Direct Lobs Per Sec',
'Physical Writes Direct Per Sec','Throughput~Physical Writes Direct Per Sec',
'Physical Writes Direct Per Txn','Throughput~Physical Writes Direct Per Txn',
'Physical Writes Per Sec','Throughput~Physical Writes Per Sec',
'Physical Writes Per Sec','Throughput~Physical Writes Per Sec',
'Physical Writes Per Txn','Throughput~Physical Writes Per Txn',
'Physical Writes Per Txn','Throughput~Physical Writes Per Txn',
'PQ QC Session Count','Others~PQ QC Session Count',
'PQ Slave Session Count','Others~PQ Slave Session Count',
'Process Limit %','Limit~Process Limit %',
'PX downgraded 1 to 25% Per Sec','Efficiency~PX downgraded 1 to 25% Per Sec',
'PX downgraded 25 to 50% Per Sec','Efficiency~PX downgraded 25 to 50% Per Sec',
'PX downgraded 50 to 75% Per Sec','Efficiency~PX downgraded 50 to 75% Per Sec',
'PX downgraded 75 to 99% Per Sec','Efficiency~PX downgraded 75 to 99% Per Sec',
'PX downgraded to serial Per Sec','Efficiency~PX downgraded to serial Per Sec',
'PX operations not downgraded Per Sec','Efficiency~PX operations not downgraded Per Sec',
'Queries parallelized Per Sec','Efficiency~Queries parallelized Per Sec',
'Recursive Calls Per Sec','Throughput~Recursive Calls Per Sec',
'Recursive Calls Per Txn','Throughput~Recursive Calls Per Txn',
'Redo Allocation Hit Ratio','Efficiency~Redo Allocation Hit Ratio',
'Redo Generated Per Sec','Throughput~Redo Generated Per Sec',
'Redo Generated Per Sec','Throughput~Redo Generated Per Sec',
'Redo Generated Per Txn','Throughput~Redo Generated Per Txn',
'Redo Generated Per Txn','Throughput~Redo Generated Per Txn',
'Redo Writes Per Sec','Throughput~Redo Writes Per Sec',
'Redo Writes Per Sec','Throughput~Redo Writes Per Sec',
'Redo Writes Per Txn','Throughput~Redo Writes Per Txn',
'Redo Writes Per Txn','Throughput~Redo Writes Per Txn',
'Replayed user calls','RAT~Replayed user calls',
'Response Time Per Txn','Efficiency~Response Time Per Txn',
'Row Cache Hit Ratio','Efficiency~Row Cache Hit Ratio',
'Row Cache Miss Ratio','Efficiency~Row Cache Miss Ratio',
'Rows Per Sort','Throughput~Rows Per Sort',
'Session Count','Others~Session Count',
'Session Limit %','Limit~Session Limit %',
'Shared Pool Free %','Efficiency~Shared Pool Free %',
'Shared Pool Free %','Efficiency~Shared Pool Free %',
'Soft Parse Ratio','Throughput~Soft Parse Ratio',
'Soft Parse Ratio','Throughput~Soft Parse Ratio',
'SQL Service Response Time','Response Time~SQL Service Response Time',
'Streams Pool Usage Percentage','Efficiency~Streams Pool Usage Percentage',
'Temp Space Used','Others~Temp Space Used',
'Temp Space Used','Others~Temp Space Used',
'Total Index Scans Per Sec','Throughput~Total Index Scans Per Sec',
'Total Index Scans Per Txn','Throughput~Total Index Scans Per Txn',
'Total Parse Count Per Sec','Throughput~Total Parse Count Per Sec',
'Total Parse Count Per Txn','Throughput~Total Parse Count Per Txn',
'Total PGA Allocated','Others~Total PGA Allocated',
'Total PGA Allocated','Others~Total PGA Allocated',
'Total PGA Used by SQL Workareas','Others~Total PGA Used by SQL Workareas',
'Total PGA Used by SQL Workareas','Others~Total PGA Used by SQL Workareas',
'Total Sorts Per User Call','Others~Total Sorts Per User Call',
'Total Table Scans Per Sec','Throughput~Total Table Scans Per Sec',
'Total Table Scans Per Sec','Throughput~Total Table Scans Per Sec',
'Total Table Scans Per Txn','Throughput~Total Table Scans Per Txn',
'Total Table Scans Per Txn','Throughput~Total Table Scans Per Txn',
'Total Table Scans Per User Call','Others~Total Table Scans Per User Call',
'Txns Per Logon','Others~Txns Per Logon',
'Txns Per Logon','Others~Txns Per Logon',
'User Calls Per Sec','Throughput~User Calls Per Sec',
'User Calls Per Sec','Throughput~User Calls Per Sec',
'User Calls Per Txn','Throughput~User Calls Per Txn',
'User Calls Per Txn','Throughput~User Calls Per Txn',
'User Calls Ratio','Throughput~User Calls Ratio',
'User Commits Per Sec','Throughput~User Commits Per Sec',
'User Commits Percentage','Throughput~User Commits Percentage',
'User Limit %','Limit~User Limit %',
'User Rollback Undo Records Applied Per Txn','Throughput~User Rollback Undo Records Applied Per Txn',
'User Rollback UndoRec Applied Per Sec','Throughput~User Rollback UndoRec Applied Per Sec',
'User Rollbacks Per Sec','Throughput~User Rollbacks Per Sec',
'User Rollbacks Percentage','Throughput~User Rollbacks Percentage',
'User Transaction Per Sec','Throughput~User Transaction Per Sec',
'User Transaction Per Sec','Throughput~User Transaction Per Sec',
'Workload Capture and Replay status','RAT~Workload Capture and Replay status'
,'Others~'||a.metric_name)||'-'||a.metric_unit||'~'||Inst_id GROUP_METRIC_NAME,a.value
from     gv$sysmetric_history  a


LOAD * INLINE [
METRIC_NAME,CATEGORY,TYPE,RESOURCE
Active Parallel Sessions,Throughput,UNITS,AAS
Active Serial Sessions,Others,UNITS,AAS
Average Active Sessions,Throughput,UNITS,AAS
Average Active Sessions,Throughput,UNITS,AAS
Average Synchronous Single-Block Read Latency,Throughput,UNITS,IO
Background Checkpoints Per Sec,Throughput,RATE,Others
Background CPU Usage Per Sec,Others,RATE,Others
Background Time Per Sec,Others,RATE,Others
Branch Node Splits Per Sec,Throughput,RATE,Others
Branch Node Splits Per Txn,Throughput,RATE,Others
Buffer Cache Hit Ratio,Efficiency,RATIO,Others
Buffer Cache Hit Ratio,Efficiency,RATIO,Others
Captured user calls,RAT,UNITS,RAT
Cell Physical IO Interconnect Bytes,Throughput,UNITS,IO
Cell Physical IO Interconnect Bytes,Throughput,UNITS,IO
Consistent Read Changes Per Sec,Throughput,RATE,Others
Consistent Read Changes Per Sec,Throughput,RATE,Others
Consistent Read Changes Per Txn,Throughput,RATE,Others
Consistent Read Changes Per Txn,Throughput,RATE,Others
Consistent Read Gets Per Sec,Throughput,RATE,Others
Consistent Read Gets Per Sec,Throughput,RATE,Others
Consistent Read Gets Per Txn,Throughput,RATE,Others
Consistent Read Gets Per Txn,Throughput,RATE,Others
CPU Usage Per Sec,Efficiency,RATE,Others
CPU Usage Per Txn,Efficiency,RATE,Others
CR Blocks Created Per Sec,Throughput,RATE,Others
CR Blocks Created Per Txn,Throughput,RATE,Others
CR Undo Records Applied Per Sec,Throughput,RATE,LOAD
CR Undo Records Applied Per Txn,Throughput,RATE,Others
Current Logons Count,Limit,UNITS,Others
Current Open Cursors Count,Limit,UNITS,Others
Current OS Load,Load,UNITS,Others
Cursor Cache Hit Ratio,Efficiency,RATIO,Others
Database CPU Time Ratio,Efficiency,RATIO,AAS
Database CPU Time Ratio,Efficiency,RATIO,AAS
Database Time Per Sec,Throughput,RATE,AAS
Database Time Per Sec,Throughput,RATE,AAS
Database Wait Time Ratio,Others,RATIO,AAS
DB Block Changes Per Sec,Throughput,RATE,Others
DB Block Changes Per Sec,Throughput,RATE,Others
DB Block Changes Per Txn,Throughput,RATE,Others
DB Block Changes Per Txn,Throughput,RATE,Others
DB Block Changes Per User Call,Others,RATE,Others
DB Block Gets Per Sec,Throughput,RATE,Others
DB Block Gets Per Sec,Throughput,RATE,Others
DB Block Gets Per Txn,Throughput,RATE,Others
DB Block Gets Per Txn,Throughput,RATE,Others
DB Block Gets Per User Call,Others,RATE,Others
DBWR Checkpoints Per Sec,Throughput,RATE,Others
DDL statements parallelized Per Sec,Efficiency,RATE,Others
Disk Sort Per Sec,Throughput,RATE,IO
Disk Sort Per Txn,Throughput,RATE,IO
DML statements parallelized Per Sec,Efficiency,RATE,Others
Enqueue Deadlocks Per Sec,Throughput,RATE,Others
Enqueue Deadlocks Per Txn,Throughput,RATE,Others
Enqueue Requests Per Sec,Throughput,RATE,Others
Enqueue Requests Per Txn,Throughput,RATE,Others
Enqueue Timeouts Per Sec,Throughput,RATE,Others
Enqueue Timeouts Per Txn,Throughput,RATE,Others
Enqueue Waits Per Sec,Throughput,RATE,Others
Enqueue Waits Per Txn,Throughput,RATE,Others
Execute Without Parse Ratio,Throughput,RATIO,Others
Execute Without Parse Ratio,Throughput,RATIO,Others
Executions Per Sec,Throughput,RATE,Others
Executions Per Sec,Throughput,RATE,Others
Executions Per Txn,Others,RATE,Others
Executions Per Txn,Others,RATE,Others
Executions Per User Call,Others,RATE,Others
Full Index Scans Per Sec,Throughput,RATE,Others
Full Index Scans Per Sec,Throughput,RATE,Others
Full Index Scans Per Txn,Throughput,RATE,Others
Full Index Scans Per Txn,Throughput,RATE,Others
GC CR Block Received Per Second,Others,RATE,Others
GC CR Block Received Per Txn,Others,RATE,Others
GC Current Block Received Per Second,Others,RATE,Others
GC Current Block Received Per Txn,Others,RATE,Others
Global Cache Average CR Get Time,RAC,RATE,RAC
Global Cache Average Current Get Time,RAC,RATE,RAC
Global Cache Blocks Corrupted,Efficiency,UNITS,RAC
Global Cache Blocks Lost,Efficiency,UNITS,RAC
Hard Parse Count Per Sec,Throughput,RATE,Others
Hard Parse Count Per Txn,Throughput,RATE,Others
Host CPU Usage Per Sec,Load,RATE,CPU
Host CPU Usage Per Sec,Load,RATE,CPU
Host CPU Utilization (%),Load,RATIO,CPU
Host CPU Utilization (%),Load,RATIO,CPU
I/O Megabytes per Second,Throughput,RATE,IO
I/O Requests per Second,Throughput,RATE,IO
Leaf Node Splits Per Sec,Throughput,RATE,Others
Leaf Node Splits Per Txn,Throughput,RATE,Others
Library Cache Hit Ratio,Efficiency,RATIO,MEM
Library Cache Hit Ratio,Efficiency,RATIO,MEM
Library Cache Miss Ratio,Efficiency,RATIO,MEM
Logical Reads Per Sec,Throughput,RATE,IO
Logical Reads Per Sec,Throughput,RATE,IO
Logical Reads Per Txn,Throughput,RATE,IO
Logical Reads Per Txn,Throughput,RATE,IO
Logical Reads Per User Call,Others,RATE,Others
Logons Per Sec,Throughput,RATE,Others
Logons Per Sec,Throughput,RATE,Others
Logons Per Txn,Throughput,RATE,Others
Logons Per Txn,Throughput,RATE,Others
Long Table Scans Per Sec,Throughput,RATE,Others
Long Table Scans Per Txn,Throughput,RATE,Others
Memory Sorts Ratio,Others,RATIO,Others
Memory Sorts Ratio,Throughput,RATIO,IO
Network Traffic Volume Per Sec,Throughput,RATE,Network
Open Cursors Per Sec,Throughput,RATE,Others
Open Cursors Per Txn,Throughput,RATE,Others
Parse Failure Count Per Sec,Throughput,RATE,Others
Parse Failure Count Per Txn,Throughput,RATE,Others
PGA Cache Hit %,Efficiency,RATIO,Others
Physical Read Bytes Per Sec,Throughput,RATE,IO
Physical Read IO Requests Per Sec,Throughput,RATE,IO
Physical Read Total Bytes Per Sec,Throughput,RATE,IO
Physical Read Total IO Requests Per Sec,Throughput,RATE,IO
Physical Reads Direct Lobs Per Sec,Throughput,RATE,IO
Physical Reads Direct Lobs Per Txn,Throughput,RATE,IO
Physical Reads Direct Per Sec,Throughput,RATE,IO
Physical Reads Direct Per Sec,Throughput,RATE,IO
Physical Reads Direct Per Txn,Throughput,RATE,IO
Physical Reads Direct Per Txn,Throughput,RATE,IO
Physical Reads Per Sec,Throughput,RATE,IO
Physical Reads Per Sec,Throughput,RATE,IO
Physical Reads Per Txn,Throughput,RATE,IO
Physical Reads Per Txn,Throughput,RATE,IO
Physical Write Bytes Per Sec,Throughput,RATE,IO
Physical Write IO Requests Per Sec,Throughput,RATE,IO
Physical Write Total Bytes Per Sec,Throughput,RATE,IO
Physical Write Total IO Requests Per Sec,Throughput,RATE,IO
Physical Writes Direct Lobs  Per Txn,Throughput,RATE,Others
Physical Writes Direct Lobs Per Sec,Throughput,RATE,IO
Physical Writes Direct Per Sec,Throughput,RATE,IO
Physical Writes Direct Per Txn,Throughput,RATE,IO
Physical Writes Per Sec,Throughput,RATE,IO
Physical Writes Per Sec,Throughput,RATE,IO
Physical Writes Per Txn,Throughput,RATE,IO
Physical Writes Per Txn,Throughput,RATE,IO
PQ QC Session Count,Others,UNITS,Others
PQ Slave Session Count,Others,UNITS,Others
Process Limit %,Limit,RATIO,Others
PX downgraded 1 to 25% Per Sec,Efficiency,RATE,Others
PX downgraded 25 to 50% Per Sec,Efficiency,RATE,Others
PX downgraded 50 to 75% Per Sec,Efficiency,RATE,Others
PX downgraded 75 to 99% Per Sec,Efficiency,RATE,Others
PX downgraded to serial Per Sec,Efficiency,RATE,Others
PX operations not downgraded Per Sec,Efficiency,RATE,Others
Queries parallelized Per Sec,Efficiency,RATE,Others
Recursive Calls Per Sec,Throughput,RATE,Others
Recursive Calls Per Txn,Throughput,RATE,Others
Redo Allocation Hit Ratio,Efficiency,RATIO,Others
Redo Generated Per Sec,Throughput,RATE,IO
Redo Generated Per Sec,Throughput,RATE,IO
Redo Generated Per Txn,Throughput,RATE,IO
Redo Generated Per Txn,Throughput,RATE,IO
Redo Writes Per Sec,Throughput,RATE,IO
Redo Writes Per Sec,Throughput,RATE,IO
Redo Writes Per Txn,Throughput,RATE,Others
Redo Writes Per Txn,Throughput,RATE,Others
Replayed user calls,RAT,UNITS,RAT
Response Time Per Txn,Efficiency,RATE,Others
Row Cache Hit Ratio,Efficiency,RATIO,MEM
Row Cache Miss Ratio,Efficiency,RATIO,Others
Rows Per Sort,Throughput,UNITS,IO
Session Count,Others,UNITS,Others
Session Limit %,Limit,RATIO,Others
Shared Pool Free %,Efficiency,RATIO,MEM
Shared Pool Free %,Efficiency,RATIO,MEM
Soft Parse Ratio,Throughput,RATIO,Others
Soft Parse Ratio,Throughput,RATIO,Others
SQL Service Response Time,Response Time,RATE,Others
Streams Pool Usage Percentage,Efficiency,RATIO,MEM
Temp Space Used,Others,UNITS,IO
Temp Space Used,Others,UNITS,IO
Total Index Scans Per Sec,Throughput,RATE,Others
Total Index Scans Per Txn,Throughput,RATE,Others
Total Parse Count Per Sec,Throughput,RATE,Others
Total Parse Count Per Txn,Throughput,RATE,Others
Total PGA Allocated,Others,UNITS,MEM
Total PGA Allocated,Others,UNITS,MEM
Total PGA Used by SQL Workareas,Others,UNITS,MEM
Total PGA Used by SQL Workareas,Others,UNITS,MEM
Total Sorts Per User Call,Others,RATE,Others
Total Table Scans Per Sec,Throughput,RATE,Others
Total Table Scans Per Sec,Throughput,RATE,Others
Total Table Scans Per Txn,Throughput,RATE,Others
Total Table Scans Per Txn,Throughput,RATE,Others
Total Table Scans Per User Call,Others,RATE,Others
Txns Per Logon,Others,UNITS,Others
Txns Per Logon,Others,UNITS,Others
User Calls Per Sec,Throughput,RATE,Others
User Calls Per Sec,Throughput,RATE,Others
User Calls Per Txn,Throughput,RATE,Others
User Calls Per Txn,Throughput,RATE,Others
User Calls Ratio,Throughput,RATIO,Others
User Commits Per Sec,Throughput,RATE,Others
User Commits Percentage,Throughput,RATIO,Others
User Limit %,Limit,RATIO,Others
User Rollback Undo Records Applied Per Txn,Throughput,RATE,Others
User Rollback UndoRec Applied Per Sec,Throughput,RATE,Others
User Rollbacks Per Sec,Throughput,RATE,Others
User Rollbacks Percentage,Throughput,RATIO,Others
User Transaction Per Sec,Throughput,RATE,Others
User Transaction Per Sec,Throughput,RATE,Others
Workload Capture and Replay status,RAT,UNITS,RAT
];


LOAD * INLINE [
METRIC_NAME,CATEGORY,TYPE,RESOURCE,COMMENTS
Active Parallel Sessions,Throughput,UNITS,AAS,11+? AAS for PQO?, looks like it, check out https://sites.google.com/site/oraclemonitor/oem-parallel-execution-tab
Active Serial Sessions,Others,UNITS,AAS,
Average Active Sessions,Throughput,UNITS,AAS,Average of Number of session either working or waiting between the samples
Average Active Sessions,Throughput,UNITS,AAS,Average of Number of session either working or waiting between the samples
Average Synchronous Single-Block Read Latency,Throughput,UNITS,IO,average latency in milliseconds of a sync single-block read. This is the reasonably accurate way of assessing the performance of the storage subsystem. High latencies are typically caused by a high I/O request load. Exessively high CPU load can also cause the latencies to increase 11+?  how is this different than db file sequential read times ?
Background Checkpoints Per Sec,Throughput,RATE,Others,count of check points done by background processes
Background CPU Usage Per Sec,Efficiency,RATE,Others,
Background Time Per Sec,Others,RATE,Others,
Branch Node Splits Per Sec,Throughput,RATE,Others,Number of time per second an index branch block was split because of insertion of an additional value
Branch Node Splits Per Txn,Throughput,RATE,Others,Number of time per transcation an index branch block was split because of insertion of an additional value
Buffer Cache Hit Ratio,Efficiency,RATIO,Others,measured by the precentage of times the DB block requested is in memory
Buffer Cache Hit Ratio,Efficiency,RATIO,Others,measured by the precentage of times the DB block requested is in memory
Captured user calls,RAT,UNITS,RAT,RAT
Cell Physical IO Interconnect Bytes,Throughput,UNITS,IO,Exadata
Cell Physical IO Interconnect Bytes,Throughput,UNITS,IO,Exadata
Consistent Read Changes Per Sec,Throughput,RATE,Others,The change per second in consistent reads gives a marginal measurement of data buffer activity for a block or a range of in-memory blocks this Metrics represents the number of times per second a user process has applied rollback entries to perform a CR on the block 
Consistent Read Changes Per Sec,Throughput,RATE,Others,The change per second in consistent reads gives a marginal measurement of data buffer activity for a block or a range of in-memory blocks this Metrics represents the number of times per second a user process has applied rollback entries to perform a CR on the block
Consistent Read Changes Per Txn,Throughput,RATE,Others,The change per Transcation in consistent reads gives a marginal measurement of data buffer activity for a block or a range of in-memory blocks this Metrics represents the number of times per Transcation a user process has applied rollback entries to perform a CR on the block 
Consistent Read Changes Per Txn,Throughput,RATE,Others,The change per Transcation in consistent reads gives a marginal measurement of data buffer activity for a block or a range of in-memory blocks this Metrics represents the number of times per Transcation a user process has applied rollback entries to perform a CR on the block
Consistent Read Gets Per Sec,Throughput,RATE,Others,This metrics represent the number of times per second a consistent read was requesetd for a block
Consistent Read Gets Per Sec,Throughput,RATE,Others,This metrics represent the number of times per second a consistent read was requesetd for a block
Consistent Read Gets Per Txn,Throughput,RATE,Others,This metrics represent the number of times per Transcation a consistent read was requesetd for a block
Consistent Read Gets Per Txn,Throughput,RATE,Others,This metrics represent the number of times per Transcation a consistent read was requesetd for a block
CPU Usage Per Sec,Efficiency,RATE,Others,CPU usage per second by database processes measured in 100th of second.
CPU Usage Per Txn,Efficiency,RATE,Others,Average CPU usage per transcation expressed as number of seonds of CPU Time
CR Blocks Created Per Sec,Throughput,RATE,Others,This metrics represents the number of current blocks per seconds cloned to create consistent read (CR) blocks
CR Blocks Created Per Txn,Throughput,RATE,Others,This metrics represents the number of current blocks per transcations cloned to create consistent read (CR) blocks
CR Undo Records Applied Per Sec,Throughput,RATE,LOAD,This represents the number of undo records applied for consistent read per second
CR Undo Records Applied Per Txn,Throughput,RATE,Others,This represents the number of undo records applied for consistent read per transcation
Current Logons Count,Limit,UNITS,Others,Number of users logged on at the sampling time select value form v$sysstat where name='logons current'
Current Open Cursors Count,Limit,UNITS,Others,Current number of oper cursors
Current OS Load,Load,UNITS,Others,An idle computer has a load number of 0. Each process using or waiting for CPU (the ready queue or run queue) increments the load number by 1. Most UNIX systems count only processes in the running (on CPU) or runnable (waiting for CPU) states. However, Linux also includes processes in uninterruptible sleep states (usually waiting for disk activity), which can lead to markedly different results if many processes remain blocked in I/O due to a busy or stalled I/O system.
Cursor Cache Hit Ratio,Efficiency,RATIO,Others,Percentage of soft parse satisfied within the session cursor cache. Value= Session cursor cache hits/(parse count (total) - parse count (hard))
Database CPU Time Ratio,Efficiency,RATIO,AAS,This metrics represents the percentage of database call time that is spent on CPU. It can be used to detect change in system operation. No correct value, drop from 50  to 25 % is an indication
Database CPU Time Ratio,Efficiency,RATIO,AAS,Database call time spent on CPU. Look for DROP in CPU Time from 50% to 10%
Database Time Per Sec,Throughput,RATE,AAS,This metric denotes the database time  should just be 100*AAS ie centisecs/sec
Database Time Per Sec,Throughput,RATE,AAS,This metric denotes the database time  should just be 100*AAS ie centisecs/sec
Database Wait Time Ratio,Others,RATIO,AAS,
DB Block Changes Per Sec,Throughput,RATE,Others,Total number of changes per second that were part of update/delete operation that were made to all blocks in SGA. Db block change / time
DB Block Changes Per Sec,Throughput,RATE,Others,Total number of changes per second that were part of update/delete operation that were made to all blocks in SGA. Db block change / time
DB Block Changes Per Txn,Throughput,RATE,Others,Total number of changes per transcation that were part of update/delete operation that were made to all blocks in SGA. Db block change / Transcation
DB Block Changes Per Txn,Throughput,RATE,Others,Total number of changes per transcation that were part of update/delete operation that were made to all blocks in SGA. Db block change / Transcation
DB Block Changes Per User Call,Others,RATE,Others,
DB Block Gets Per Sec,Throughput,RATE,Others,This metrics represents the number of times per second a current block was requested
DB Block Gets Per Sec,Throughput,RATE,Others,This metrics represents the number of times per second a current block was requested
DB Block Gets Per Txn,Throughput,RATE,Others,This metrics represents the number of times per transcation a current block was requested
DB Block Gets Per Txn,Throughput,RATE,Others,This metrics represents the number of times per transcation a current block was requested
DB Block Gets Per User Call,Others,RATE,Others,
DBWR Checkpoints Per Sec,Throughput,RATE,Others,The DBWR Checkpoints Per Sec Oracle metric is the number of times per second the DBWR was asked to scan the cache and write all blocks marked for a checkpoint As user processes dirty buffers, then no of free buffers diminishes. DBWn manages the buffer cache so that user processes can always find free buffers When server process cant find a clean reusable buffer after scanning a threashold buffers, it signals DBWR to write. DBWn writes based on LRU. additionaly DBWn periodically writes to advance checkpoint that is in the position of redo log from which crash/instance recovery would need to begin. select value from v$sysdate where name='DBWR checkpoints'/seconds in sample period A checkpoint tells the DBWR to write out modified buffer to disk. (This write operation is different from the make free request in that the modified buffers are not marked as free by DBWR). Dirty buffer may also be written to disk at this time and freed. the write size is dictated by _db_blocks_checkpoint_batch parameter. if this is problem, 'checkpint completed' wait event tops if that is the case, increase the time between checkpionts by checking ""select name,value from v$parameter where name ='db_block_checkpoint_batch' this value should be large enough to take advantage of parallel writes.  DBWR use a batch that is calculated by: (db_files * db_file_simultaneous_writes)/2. it also limited to a port specific limit on number of I/Os.  1/4 of the number of buffers in SGA is dirty db_block_checkpoint is always smaller or equal to the _db_block_write_batch. you can also consider enabling the check point process
DDL statements parallelized Per Sec,Efficiency,RATE,Others,
Disk Sort Per Sec,Throughput,RATE,IO,This represents number of sorts going to disk per second. For best performance, sort should happen in memory. Disk sorts increase CPU and IO resources select value from v$sysstat where name='sort (disk)' if queries are tunned properly, consider increasing SORT_AREA_SIZE init parameter
Disk Sort Per Txn,Throughput,RATE,IO,This represents number of sorts going to disk per transcation. For best performance, sort should happen in memory. Disk sorts increase CPU and IO resources select value from v$sysstat where name='sort (disk)'if queries are tunned properly, consider increasing SORT_AREA_SIZE init parameter
DML statements parallelized Per Sec,Efficiency,RATE,Others,
Enqueue Deadlocks Per Sec,Throughput,RATE,Others,This metrics represents the number of times per second that a process detected a potential deadlock when exchanging two buffers and raised an internal restartable error
Enqueue Deadlocks Per Txn,Throughput,RATE,Others,This metrics represents the number of times per transcation that a process detected a potential deadlock when exchanging two buffers and raised an internal restartable error
Enqueue Requests Per Sec,Throughput,RATE,Others,This metrics represents the total number of table or row lock acquired per second
Enqueue Requests Per Txn,Throughput,RATE,Others,This metrics represents the total number of table or row lock acquired per transcation
Enqueue Timeouts Per Sec,Throughput,RATE,Others,This metrics represents the total number of table and row locks (Acquied and converted) per second that time out before they could complete
Enqueue Timeouts Per Txn,Throughput,RATE,Others,This metrics represents the total number of table and row locks (Acquied and converted) per transcation that time out before they could complete
Enqueue Waits Per Sec,Throughput,RATE,Others,This metrics represents the total number of waits per second that occurred during an enqueue convert or get because the enqueue get was deferred
Enqueue Waits Per Txn,Throughput,RATE,Others,This metrics represents the total number of waits per transcation that occurred during an enqueue convert or get because the enqueue get was deferred
Execute Without Parse Ratio,Throughput,RATIO,Others,The percentage of statement executions that do not require a corresponding parse. A higher number is better select value from v$sysstat where name='parse cont (total)' select value from v$sysstat where name='execute count'  ((DeltaExecutCount-(DeltaParseCountTotal))/DeltaExecuteCount)*100 1. Reparsing the statement, even if it is soft parse, requires a network round trip from the application to the database. 2. Requiring the procesing time to locat the previously compiled statement in cache.
Execute Without Parse Ratio,Throughput,RATIO,Others,The percentage of statement executions that do not require a corresponding parse. A higher number is better select value from v$sysstat where name='parse cont (total)' select value from v$sysstat where name='execute count'  ((DeltaExecutCount-(DeltaParseCountTotal))/DeltaExecuteCount)*100 1. Reparsing the statement, even if it is soft parse, requires a network round trip from the application to the database. 2. Requiring the procesing time to locat the previously compiled statement in cache.
Executions Per Sec,Throughput,RATE,Others,The rate of SQL command execution over the sampling interval select value from v$sysstat where name='execute count'/ numner of seconds in sample
Executions Per Sec,Throughput,RATE,Others,The rate of SQL command execution over the sampling interval select value from v$sysstat where name='execute count'/ numner of seconds in sample
Executions Per Txn,Others,RATE,Others,
Executions Per Txn,Others,RATE,Others,
Executions Per User Call,Others,RATE,Others,
Full Index Scans Per Sec,Throughput,RATE,Others,This metrics represents the number of fast full index scans per second
Full Index Scans Per Sec,Throughput,RATE,Others,This metrics represents the number of fast full index scans per second
Full Index Scans Per Txn,Throughput,RATE,Others,This metrics represents the number of fast full index scans per transcation
Full Index Scans Per Txn,Throughput,RATE,Others,This metrics represents the number of fast full index scans per transcation
GC CR Block Received Per Second,Others,RATE,Others,
GC CR Block Received Per Txn,Others,RATE,Others,
GC Current Block Received Per Second,Others,RATE,Others,
GC Current Block Received Per Txn,Others,RATE,Others,
Global Cache Average CR Get Time,RAC,RATE,RAC,this represents the average time, measured in hundredths of a second, that CR block was receive global cache CR block receive time * 10 / global cache current blocks received
Global Cache Average Current Get Time,RAC,RATE,RAC,this represents the average time, measured in hundredths of a second, to get a current block global cache currrent block send time *10 /global cache current blocks served
Global Cache Blocks Corrupted,Efficiency,UNITS,RAC,integer
Global Cache Blocks Lost,Efficiency,UNITS,RAC,this metric represents the number of global cache blocks lost over the user defined observation period
Hard Parse Count Per Sec,Throughput,RATE,Others,Each time a SQL cursor is parsed, this cound will increase by one. Select value from v$sysstat where name='parse count (hard)'/ number of seconds in sample period. 1. change application logic to avoid hard parse SHARED_POOL_SIZE control size of the shared pool. OPEN_CURSORS can also be increased to permit more sql area per session
Hard Parse Count Per Txn,Throughput,RATE,Others,Each time a SQL cursor is parsed, this cound will increase by one. Select value from v$sysstat where name='parse count (hard)'/ number of transcations in sample period. 1. change application logic to avoid hard parse SHARED_POOL_SIZE control size of the shared pool. OPEN_CURSORS can also be increased to permit more sql area per session
Host CPU Usage Per Sec,Load,RATE,CPU, (‘Host CPU Utilization (%)’ * CPU_COUNT = ‘Host CPU Usage Per Sec’ (cs))
Host CPU Usage Per Sec,Load,RATE,CPU, (‘Host CPU Utilization (%)’ * CPU_COUNT = ‘Host CPU Usage Per Sec’ (cs))
Host CPU Utilization (%),Load,RATIO,CPU,This metrics represents the percentage of CPU used on host level
Host CPU Utilization (%),Load,RATIO,CPU,This metrics represents the percentage of CPU used on host level
I/O Megabytes per Second,Throughput,RATE,IO,The total I/O throughput of the database for both reads and writes in megabytes per second. A very high value indicates that the database is generating a significant volume of I/O data high I/O throughput value is not in itself problematic. However, if high I/O latency is seens in storage, it would benifit to reduce the i/o throughput.
I/O Requests per Second,Throughput,RATE,IO,This metrics represents the total rate of I/O read and write requests for the database 11+?  Physical Write Total IO Requests Per Sec  + Physical Read Total IO Requests Per Sec ?
Leaf Node Splits Per Sec,Throughput,RATE,Others,Number of times per second an index leaf node was split because of the insertion of  an additional value
Leaf Node Splits Per Txn,Throughput,RATE,Others,Number of times per Transcaion an index leaf node was split because of the insertion of  an additional value
Library Cache Hit Ratio,Efficiency,RATIO,MEM,measured by the precentage of times the fully parsed or compiled SQL and PL/SQL statements are already in memory. Parse time avoided, Application memory overhead reduced since pool memory is shared by all application, I/O resources saved, CPU resource required to re-parse the sql statements is saved (DeltaPinHits/DeltaPins)*100 ; select sum(pinhits) from v$librarycache/select sum(pins) from v$librarycache between samples. Conisder increasing the SHARED_POOL_SIZE to avoild cursor flusing. OPEN_CURSORS can also be increased to take advantage of additiional 'shared SQL area' and retain more number of cursors permitted per session.
Library Cache Hit Ratio,Efficiency,RATIO,MEM,measured by the precentage of times the fully parsed or compiled SQL and PL/SQL statements are already in memory. Parse time avoided, Application memory overhead reduced since pool memory is shared by all application, I/O resources saved, CPU resource required to re-parse the sql statements is saved (DeltaPinHits/DeltaPins)*100 ; select sum(pinhits) from v$librarycache/select sum(pins) from v$librarycache between samples. Conisder increasing the SHARED_POOL_SIZE to avoild cursor flusing. OPEN_CURSORS can also be increased to take advantage of additiional 'shared SQL area' and retain more number of cursors permitted per session.
Library Cache Miss Ratio,Efficiency,RATIO,MEM,This metric represents the percentage of parse requestes where the cursor is not in the cache ( 1-pinthits/pins) *100
Logical Reads Per Sec,Throughput,RATE,IO,This metrics represents the number of logical reads per second during the sample time.Logical read may result in physical read of the block is not found in cache .Select value from v$sysstat where name='session logical reads'/seconds
Logical Reads Per Sec,Throughput,RATE,IO,This metrics represents the number of logical reads per second during the sample time.Logical read may result in physical read of the block is not found in cache .Select value from v$sysstat where name='session logical reads'/seconds
Logical Reads Per Txn,Throughput,RATE,IO,This metrics represents the number of logical reads per second during the sample time.Logical read may result in physical read of the block is not found in cache .Select value from v$sysstat where name='session logical reads'/seconds
Logical Reads Per Txn,Throughput,RATE,IO,This metrics represents the number of logical reads per second during the sample time.Logical read may result in physical read of the block is not found in cache .Select value from v$sysstat where name='session logical reads'/seconds
Logical Reads Per User Call,Others,RATE,Others,
Logons Per Sec,Throughput,RATE,Others,Number of logons per second during the sample period deltaLogons/Seconds where select value from v$sysstat where name='logons cumulative'; number of seconds in sample period high logon rate may indicate inefficiently application. Logons are costly operation + poor application performance + impact other application
Logons Per Sec,Throughput,RATE,Others,Number of logons per second during the sample period deltaLogons/Seconds where select value from v$sysstat where name='logons cumulative'; number of seconds in sample period high logon rate may indicate inefficiently application. Logons are costly operation + poor application performance + impact other application
Logons Per Txn,Throughput,RATE,Others,This statistics will be zero if there have not been any insert/update transcation commited or rolled back during the last sample period. Better check logons per second metrics DeltaLogons/Transcations select value from v$sysstat where name='logon cumulative'/ transcations during that sample period
Logons Per Txn,Throughput,RATE,Others,This statistics will be zero if there have not been any insert/update transcation commited or rolled back during the last sample period. Better check logons per second metrics DeltaLogons/Transcations select value from v$sysstat where name='logon cumulative'/ transcations during that sample period
Long Table Scans Per Sec,Throughput,RATE,Others,This metric represents the number of long table scans per second during the sample period. A table is considerd long if the table is not cached and the high water mark is greater than 5 blocks select value from v$sysstat where name='table scan (long tables)' table scane means that the entier table is being scanned row by row to satisfy the query. For small table this is good. But for larger table this is lot of physical read and potentially push other requred buffers out of cache. Identify the SQL statements and tune them
Long Table Scans Per Txn,Throughput,RATE,Others,This metric represents the number of long table scans per transcation during the sample period. A table is considerd long if the table is not cached and the high water mark is greater than 5 blocks select value from v$sysstat where name='table scan (long tables)' table scane means that the entier table is being scanned row by row to satisfy the query. For small table this is good. But for larger table this is lot of physical read and potentially push other requred buffers out of cache. Identify the SQL statements and tune them
Memory Sorts Ratio,Others,RATIO,Others,
Memory Sorts Ratio,Throughput,RATIO,IO,This metrics represents the sort effeciency as measured by the percentage of times sorts were performed in memory as opposed to going to disk. Memrory good. Disk sort bad. Increase CPU and I/O resource consumption DeltaMemorySorts/(DeltaDiskSorts+DeltaMemorySorts) * 100 where: select value from v$sysstat where name='sorts (memory)"" and select value from v$sysstat where name='sorts (disk)' identifiy the sessions doing Sorts and tune the SQL. sort area size should be sized correctly if the query is correct and still disk sort is happening, consider increasing SORT_AREA_SIZE. reduce number of I/O
Network Traffic Volume Per Sec,Throughput,RATE,Network,The total number of bytes sent and received thorugh the SQL Net layer to and from the database. Check the network read/write per second. (DeltaBytesFromClient+DeltaBytesFromDblink+DeltaBytesToCLient+DeltaBytesToDBlink)/seconds select s.value from v$sysstat s, visitation n where n.name='bytes received via SQL*Net from client' and n.statistics#=s.statistics#' between samples select s.value from v$sysstat s, visitation n where n.name='bytes received via SQL*Net from dblink and n.statistics#=s.statistics#' between samples select s.value from v$sysstat s, visitation n where n.name='bytes sent via SQL*Net to client' and n.statistics#=s.statistics#' between samples select s.value from v$sysstat s, visitation n where n.name='bytes sent via SQL*Net to dblink and n.statistics#=s.statistics#' between samples
Open Cursors Per Sec,Throughput,RATE,Others,Total number of cursors opened per second
Open Cursors Per Txn,Throughput,RATE,Others,Total number of cursors opened per transcation
Parse Failure Count Per Sec,Throughput,RATE,Others,This metrics represent the total number of parse failures per second
Parse Failure Count Per Txn,Throughput,RATE,Others,This metrics represent the total number of parse failures per transcation
PGA Cache Hit %,Efficiency,RATIO,Others,Represents the total number of bytes processed in the PGA vs the total number of bytes processed + extra bytes read/written in extra passes
Physical Read Bytes Per Sec,Throughput,RATE,IO,
Physical Read IO Requests Per Sec,Throughput,RATE,IO,
Physical Read Total Bytes Per Sec,Throughput,RATE,IO,
Physical Read Total IO Requests Per Sec,Throughput,RATE,IO,
Physical Reads Direct Lobs Per Sec,Throughput,RATE,IO,This metric represents the number of direct large object (LOB) physical reads per second
Physical Reads Direct Lobs Per Txn,Throughput,RATE,IO,This metric represents the number of direct large object (LOB) physical reads per transaction
Physical Reads Direct Per Sec,Throughput,RATE,IO,This metrics represents the number of direct physical read per second
Physical Reads Direct Per Sec,Throughput,RATE,IO,This metrics represents the number of direct physical read per second
Physical Reads Direct Per Txn,Throughput,RATE,IO,This metrics represents the number of direct physical read per transcation
Physical Reads Direct Per Txn,Throughput,RATE,IO,This metrics represents the number of direct physical read per transcation
Physical Reads Per Sec,Throughput,RATE,IO,number of data blocks read from disk per second. Disk read are not good. The goal with oracle should always be to maximize memory utilization select s.value from v$sysstat s , v$statname n where n.name='physical reads' and n.statistics#=s.statistics#; reads are inevitable. so the aim should be to minimize unnecessary I/O. Check explain plan yield profound changes in performance. Tweaking at system level usually only achive percentage gains. If SQL statement is properly tuned, then consider increasing the buffer cache. DB_BLOCK_BUFFERS. dont use DB_BLOCK_LRU_EXTENDED_STATISTICS. Never increase SGA size if it may induce additional pagin or swaping in system.
Physical Reads Per Sec,Throughput,RATE,IO,number of data blocks read from desk per second. Disk read are not good. The goal with oracle should always be to maximize memory utilization select s.value from v$sysstat s , v$statname n where n.name='physical reads' and n.statistics#=s.statistics#; reads are inevitable. so the aim should be to minimize unnecessary I/O. Check explain plan yield profound changes in performance. Tweaking at system level usually only achive percentage gains. If SQL statement is properly tuned, then consider increasing the buffer cache. DB_BLOCK_BUFFERS. dont use DB_BLOCK_LRU_EXTENDED_STATISTICS. Never increase SGA size if it may induce additional pagin or swaping in system.
Physical Reads Per Txn,Throughput,RATE,IO,number of data blocks read from desk per second. Disk read are not good. The goal with oracle should always be to maximize memory utilization select s.value from v$sysstat s , v$statname n where n.name='physical reads' and n.statistics#=s.statistics#; reads are inevitable. so the aim should be to minimize unnecessary I/O. Check explain plan yield profound changes in performance. Tweaking at system level usually only achive percentage gains. If SQL statement is properly tuned, then consider increasing the buffer cache. DB_BLOCK_BUFFERS. dont use DB_BLOCK_LRU_EXTENDED_STATISTICS. Never increase SGA size if it may induce additional pagin or swaping in system.
Physical Reads Per Txn,Throughput,RATE,IO,number of data blocks read from desk per second. Disk read are not good. The goal with oracle should always be to maximize memory utilization select s.value from v$sysstat s , v$statname n where n.name='physical reads' and n.statistics#=s.statistics#; reads are inevitable. so the aim should be to minimize unnecessary I/O. Check explain plan yield profound changes in performance. Tweaking at system level usually only achive percentage gains. If SQL statement is properly tuned, then consider increasing the buffer cache. DB_BLOCK_BUFFERS. dont use DB_BLOCK_LRU_EXTENDED_STATISTICS. Never increase SGA size if it may induce additional pagin or swaping in system.
Physical Write Bytes Per Sec,Throughput,RATE,IO,disk writes per second from SGA to disk and PGA to disk select value from v$sysstat where name='physical writes'/seconds
Physical Write IO Requests Per Sec,Throughput,RATE,IO,disk writes per second from SGA to disk and PGA to disk select value from v$sysstat where name='physical writes'/seconds
Physical Write Total Bytes Per Sec,Throughput,RATE,IO,disk writes per transcation from SGA to disk and PGA to disk select value from v$sysstat where name='physical writes'/seconds
Physical Write Total IO Requests Per Sec,Throughput,RATE,IO,disk writes per transcation from SGA to disk and PGA to disk. select value from v$sysstat where name='physical writes'/seconds
Physical Writes Direct Lobs  Per Txn,Throughput,RATE,Others,Number of direct physical writes per second
Physical Writes Direct Lobs Per Sec,Throughput,RATE,IO,Number of direct physical writes per second
Physical Writes Direct Per Sec,Throughput,RATE,IO,Number of direct physical writes per transcation
Physical Writes Direct Per Txn,Throughput,RATE,IO,Number of direct physical writes per transcation
Physical Writes Per Sec,Throughput,RATE,IO,This statistics represents the rate of DB blocks written from SGA to disk by DBWR and From PGA by processes by performand direct writes per second DeltaWrites/Second  (select value from v$sysstat where name='physical writes';) If the physical writes direct value is large portion of writes, then lot of sorts/ temp wirtes might be occuring If the writes are by DBWR, the check if log write or redo waits are high
Physical Writes Per Sec,Throughput,RATE,IO,This statistics represents the rate of DB blocks written from SGA to disk by DBWR and From PGA by processes by performand direct writes per second DeltaWrites/Second  (select value from v$sysstat where name='physical writes';) If the physical writes direct value is large portion of writes, then lot of sorts/ temp wirtes might be occuring If the writes are by DBWR, the check if log write or redo waits are high
Physical Writes Per Txn,Throughput,RATE,IO,This statistics represents the rate of DB blocks written from SGA to disk by DBWR and From PGA by processes by performand direct writes per transcation DeltaWrites/Second  (select value from v$sysstat where name='physical writes';) If the physical writes direct value is large portion of writes, then lot of sorts/ temp wirtes might be occuring If the writes are by DBWR, the check if log write or redo waits are high
Physical Writes Per Txn,Throughput,RATE,IO,This statistics represents the rate of DB blocks written from SGA to disk by DBWR and From PGA by processes by performand direct writes per transcation DeltaWrites/Second  (select value from v$sysstat where name='physical writes';) If the physical writes direct value is large portion of writes, then lot of sorts/ temp wirtes might be occuring If the writes are by DBWR, the check if log write or redo waits are high
PQ QC Session Count,Others,UNITS,Others,
PQ Slave Session Count,Others,UNITS,Others,
Process Limit %,Limit,RATIO,Others,processes init prameter SELECT resource_name name, 100*DECODE(initial_allocation, 'UNLIMITED', 0, current_utilization) != '0' AND resource_name ='processes' increase the processes parameter tobe at least 6+ the maximum number of concurrent users expected to log in to the instance
PX downgraded 1 to 25% Per Sec,Efficiency,RATE,Others,(parallel operations downgraded 1 to 25 percent + parallel operations downgraded 25 to 50 percent + parallel operations downgraded 50 to 75 percent + parallel operations downgraded 75 to 99 percent) / time
PX downgraded 25 to 50% Per Sec,Efficiency,RATE,Others,(parallel operations downgraded 25 to 50 percent + parallel operations downgraded 50 to 75 percent + parallel operations downgraded 75 to 99 percent) / time
PX downgraded 50 to 75% Per Sec,Efficiency,RATE,Others,(+ parallel operations downgraded 50 to 75 percent + parallel operations downgraded 75 to 99 percent) / time
PX downgraded 75 to 99% Per Sec,Efficiency,RATE,Others,(parallel operations downgraded 75 to 99 percent) / time
PX downgraded to serial Per Sec,Efficiency,RATE,Others,parallel operations downgraded to serial / time
PX operations not downgraded Per Sec,Efficiency,RATE,Others,parallel operations that are not downgraded
Queries parallelized Per Sec,Efficiency,RATE,Others,
Recursive Calls Per Sec,Throughput,RATE,Others,Number of recursive call per second. Some times to execute user SQL, oracle must issue additional statements to complete the request. Example, during insert if there is no space to hold the record, oracle must issue recursive call to allocate space dynamically. This is also done during dictonary information not available in cache, DDL,  trigger, refrential integreti constraints etc. select value from v$sysstat where name='recursive calls'/ second
Recursive Calls Per Txn,Throughput,RATE,Others,Number of recursive call per transcation. Some times to execute user SQL, oracle must issue additional statements to complete the request. Example, during insert if there is no space to hold the record, oracle must issue recursive call to allocate space dynamically. This is also done during dictonary information not available in cache, DDL,  trigger, refrential integreti constraints etc. select value from v$sysstat where name='recursive calls'/ transcations during sample
Redo Allocation Hit Ratio,Efficiency,RATIO,Others,LGWR process writes redo log entries from the log buffer to a redo log file. The log buffer should be sized so that space is available in the log buffer for new entries, even when access to the redo log is heavy. When log buffer is undersized, user process will be delayed as they wait for LGWR to free space in the redo log buffer redo log buffer efficency, as measured by this hit ratio, records the precentage of times use DID NOT have to wait for LGWR to free space in log buffer 100*(redo_entries_delta - Redo_space_request_delta)/redo_entries_delta where: redo_entries_delta=""select value form v$sysstat where name='redo entries' ; select value from v$sysstat where name='redo log space requests' between the samples.consider increasing LOG_BUFFER init parameter , so that space is available in log buffer even the usage of buffer is heavy note: this is depriciated, use Redo NoWait Ratio instead
Redo Generated Per Sec,Throughput,RATE,IO,amount of redo in bytes generated per seconds. Log buffer is circular buffer in the SGA to hold information about changes made to the database. Select value from v$sysstat where name ='redo size'/ number of seconds in sample period. Consider increasing LOG_BUFFER init parameter to increase size of the redo log buffer should waiting be a problem.
Redo Generated Per Sec,Throughput,RATE,IO,amount of redo in bytes generated per seconds. Log buffer is circular buffer in the SGA to hold information about changes made to the database. Select value from v$sysstat where name ='redo size'/ number of seconds in sample period. Consider increasing LOG_BUFFER init parameter to increase size of the redo log buffer should waiting be a problem.
Redo Generated Per Txn,Throughput,RATE,IO,amount of redo in bytes generated per transcation. Log buffer is circular buffer in the SGA to hold information about changes made to the database. Select value from v$sysstat where name ='redo size'/ select value from v$sysstat where name='user commits' Consider increasing LOG_BUFFER init parameter to increase size of the redo log buffer should waiting be a problem.
Redo Generated Per Txn,Throughput,RATE,IO,amount of redo in bytes generated per transcation. Log buffer is circular buffer in the SGA to hold information about changes made to the database. Select value from v$sysstat where name ='redo size'/ select value from v$sysstat where name='user commits' Consider increasing LOG_BUFFER init parameter to increase size of the redo log buffer should waiting be a problem.
Redo Writes Per Sec,Throughput,RATE,IO,This parameter represents the redo write operations per second. Check number of writes by LGWR to the redo log files per second. Select value from v$sysstat where name='redo writes'/second Should waiting be a problem, consider increasing LOG_BUFFER init parameter
Redo Writes Per Sec,Throughput,RATE,IO,This parameter represents the redo write operations per second. Check number of writes by LGWR to the redo log files per second. Select value from v$sysstat where name='redo writes'/second Should waiting be a problem, consider increasing LOG_BUFFER init parameter
Redo Writes Per Txn,Throughput,RATE,Others,This parameter represents the redo write operations per transcation. Check number of writes by LGWR to the redo log files per second. Select value from v$sysstat where name='redo writes'/select value from v$sysstat where name='user commits' + select value from v$sysstat where name='user rollbacks' Should waiting be a problem, consider increasing LOG_BUFFER init parameter
Redo Writes Per Txn,Throughput,RATE,Others,This parameter represents the redo write operations per transcation. Check number of writes by LGWR to the redo log files per second. Select value from v$sysstat where name='redo writes'/ select value from v$sysstat where name='user commits' + select value from v$sysstat where name='user rollbacks' Should waiting be a problem, consider increasing LOG_BUFFER init parameter
Replayed user calls,RAT,UNITS,RAT,RAT
Response Time Per Txn,Efficiency,RATE,Others,It is derived from the total time that user calls spend in ""DB time"" and the number of commits and rollbacks performed. It indicates either workload has changed or database ability to process the workload has changed because of either resource constraints or contention
Row Cache Hit Ratio,Efficiency,RATIO,MEM,percentage of row cache hit ratio
Row Cache Miss Ratio,Efficiency,RATIO,Others,percentage of row cache miss ratio
Rows Per Sort,Throughput,UNITS,IO,average number of rows per sort during the sample period (deltaSortRows/(DeltaDiskSorts+DeltaMemorySorts))*100 where: select value from v$sysstat where name ='sorts (rows)' select value from v$sysstat where name='sorts (memory)' select value from v$sysstat where name='sorts (disk)' Identify the session and SQL doing exessive sorts and tune them. If the query is correct and the sql are tunned.,consider increasing SORT_AREA_SIZE . Larger sort area helps oracle do sorting in memory there reducing number of I/O
Session Count,Others,UNITS,Others,
Session Limit %,Limit,RATIO,Others,sessions init parameter SELECT resource_name name, 100*DECODE(initial_allocation, 'UNLIMITED', 0, current_utilization) != '0' AND resource_name ='sessions' increase the sessiosn prameter to be atleast 2.73* processes for xa environment and for shared server environment, confirm it is at least 1.1 * maximum number of connections
Shared Pool Free %,Efficiency,RATIO,MEM,Precentage of shared pool that is currently marked as free. ((Free/total)*100) where: select sum(decode(name,'free memory',bytes)) from v$sgastat where pool='shared pool' ; select sum(bytes) from v$sgastat where pool='shared pool';if free memory is above 50%, too much memory has been allocated to shared pool, this can be utilized to buffer cache or else were. reduce SHARED_POOL_SIZE
Shared Pool Free %,Efficiency,RATIO,MEM,Precentage of shared pool that is currently marked as free. ((Free/total)*100) where: select sum(decode(name,'free memory',bytes)) from v$sgastat where pool='shared pool' ; select sum(bytes) from v$sgastat where pool='shared pool';if free memory is above 50%, too much memory has been allocated to shared pool, this can be utilized to buffer cache or else were. reduce SHARED_POOL_SIZE
Soft Parse Ratio,Throughput,RATIO,Others,This metrics represents of parse requests where the cursor was already in the cursor cache compared to number of total parse ((DeltaParseCountTotal - DeltaParseCountHard) /DeltaParseCountTotal)*100 select value from v$sysstat where name='parse count (total)' select value from v$sysstat where name='parse count (hard)' Soft parse consume less resource than hard parse. But too much of soft parse is also not good, as they consume network round trip and CPU resources.
Soft Parse Ratio,Throughput,RATIO,Others,This metrics represents of parse requests where the cursor was already in the cursor cache compared to number of total parse ((DeltaParseCountTotal - DeltaParseCountHard) /DeltaParseCountTotal)*100 select value from v$sysstat where name='parse count (total)' select value from v$sysstat where name='parse count (hard)' Soft parse consume less resource than hard parse. But too much of soft parse is also not good, as they consume network round trip and CPU resources.
SQL Service Response Time,Response Time,RATE,Others,Represents the average time taken for each call (both user call and recursive calls) within the database. It indicates either workload has changed or database ability to process the workload has changed because of either resource constraints or contention
Streams Pool Usage Percentage,Efficiency,RATIO,MEM,Check the memory usage of streems pool
Temp Space Used,Others,UNITS,IO,
Temp Space Used,Others,UNITS,IO,
Total Index Scans Per Sec,Throughput,RATE,Others,Total Index scans per second index scan kdiixs1/second
Total Index Scans Per Txn,Throughput,RATE,Others,Total Index scans per transcation index scan kdiixs1/transcation
Total Parse Count Per Sec,Throughput,RATE,Others,Total parse per second Hard +Soft select value from v$sysstat where name='parse count (total)' consider init parameter SHARED_POOL_SIZE and OPEN_CURSOR
Total Parse Count Per Txn,Throughput,RATE,Others,Total parse per transcation Hard +Soft select value from v$sysstat where name='parse count (total)' consider init parameter SHARED_POOL_SIZE and OPEN_CURSOR
Total PGA Allocated,Others,UNITS,MEM,
Total PGA Allocated,Others,UNITS,MEM,
Total PGA Used by SQL Workareas,Others,UNITS,MEM,
Total PGA Used by SQL Workareas,Others,UNITS,MEM,
Total Sorts Per User Call,Others,RATE,Others,
Total Table Scans Per Sec,Throughput,RATE,Others,represents number of short and long table scans per second. A table is considered long if the table is not in cache and if its high-water mark is greater than 5 blocks select value from v$sysstat where name ='table scans (short tables)' select value from v$sysstat where name ='table scans (long tables)' (DeltaLongScan+DeltaShortScan)/ Seconds avoid long table scans
Total Table Scans Per Sec,Throughput,RATE,Others,This represents total long and short table scans per second. A table is considered long of the table is not in cache and if its high water mark is greater than 5 blocks
Total Table Scans Per Txn,Throughput,RATE,Others,This represents total long and short table scans per transcation. A table is considered long of the table is not in cache and if its high water mark is greater than 5 blocks
Total Table Scans Per Txn,Throughput,RATE,Others,This represents total long and short table scans per transcation. A table is considered long of the table is not in cache and if its high water mark is greater than 5 blocks
Total Table Scans Per User Call,Others,RATE,Others,
Txns Per Logon,Others,UNITS,Others,
Txns Per Logon,Others,UNITS,Others,
User Calls Per Sec,Throughput,RATE,Others,represents number of logins, parses, or execution call per second This statistics is reflection of how much activity is going on within the database. Spike in total user call rate should be investigated. User calls is an overall activity lelve monitor select name form v$sysstat where name='user calls'
User Calls Per Sec,Throughput,RATE,Others,represents number of logins, parses, or execution call per second This statistics is reflection of how much activity is going on within the database. Spike in total user call rate should be investigated. User calls is an overall activity lelve monitor select name form v$sysstat where name='user calls'
User Calls Per Txn,Throughput,RATE,Others,represents number of logins, parses, or execution call per transcation This statistics is reflection of how much activity is going on within the database. Spike in total user call rate should be investigated. User calls is an overall activity lelve monitor select name form v$sysstat where name='user calls'
User Calls Per Txn,Throughput,RATE,Others,represents number of logins, parses, or execution call per transcation This statistics is reflection of how much activity is going on within the database. Spike in total user call rate should be investigated. User calls is an overall activity lelve monitor select name form v$sysstat where name='user calls'
User Calls Ratio,Throughput,RATIO,Others,This metrics represents the percentage of user calls to recursive calls (DeltaUserCalls/(DeltaUserCalls + DeltaRecursiveCalls))*100 select value from v$sysstat where name='recursive calls' select value from v$sysstat where name='user calls' if this vaue is low, examine the reason for exessive recursive calls. eg: if dynamic space extension is causing, the pre allocate a larger extent
User Commits Per Sec,Throughput,RATE,Others,This metrics represents the number of user commits performed, per second during the sample period Commit often represents the closest thing to a user transcation rate select value form v$sysstat where name ='user commits' a spike in value might not be always bad, if the response time stays close to normal then this is fine. a drop in transcation rate and increase in response time might be a  problem
User Commits Percentage,Throughput,RATIO,Others,
User Limit %,Limit,RATIO,Others,LICENSE_MAX_SESSIONS initial parameter specifies the maximum number of concurrent user sessions allowed simultaneously SELECT 'user' name, 100*DECODE(session_max, 0, 0,sessions_current/session_max) usage FROM v$license
User Rollback Undo Records Applied Per Txn,Throughput,RATE,Others,represents the number of undo records applied to user-requested rollback changes per Transcation
User Rollback UndoRec Applied Per Sec,Throughput,RATE,Others,represents the number of undo records applied to user-requested rollback changes per second
User Rollbacks Per Sec,Throughput,RATE,Others,represents the number of time user manually issued the ROLLBACK command or an error occurred during user's transcation select value from v$sysstat where name='user rollbacks' Investigate to determine if the rollbacks are part of faulty application logic or due to errorss through database layer
User Rollbacks Percentage,Throughput,RATIO,Others,represents the number of time user manually issued the ROLLBACK command or an error occurred during user's transcation select value from v$sysstat where name='user rollbacks' Investigate to determine if the rollbacks are part of faulty application logic or due to errorss through database layer
User Transaction Per Sec,Throughput,RATE,Others,Total number of commits and rollbacks performed during this sample period select value from v$sysstat where name='user commits' select value from v$sysstat where name='user rollbacks' this tells how much work is being accomplised within the database. Increase in rate is not a problem, if the responce time stay close to normal however decrease in transcation rates and increase in response time may be indicators of problems
User Transaction Per Sec,Throughput,RATE,Others,Total number of commits and rollbacks performed during this sample period select value from v$sysstat where name='user commits' select value from v$sysstat where name='user rollbacks' this tells how much work is being accomplised within the database. Increase in rate is not a problem, if the responce time stay close to normal however decrease in transcation rates and increase in response time may be indicators of problems
Workload Capture and Replay status,RAT,UNITS,RAT,RAT
];
