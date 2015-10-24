--Table Size
select table_name,round((blocks*8),2)||' KB' "size"
from user_tables
where table_name = 'BIG1';

--Actual Size
select table_name,round((num_rows*avg_row_len/1024),2)||' KB' "size"
from user_tables
where table_name = 'BIG1';
