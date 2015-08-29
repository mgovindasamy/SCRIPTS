col file_name for a100
select file_name,bytes/1024/1024/1024 Bytes_GB,AUTOEXTENSIBLE from dba_data_files where tablespace_name='&1' order by 1;
undef 1
