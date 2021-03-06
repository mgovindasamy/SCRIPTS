prompt Show shared pool memory usage of SQL statement with SQL_ID &1

-- uncomment the chunk_ptr and/or subheap_desc if you want more detailed breakdown of individual chunk allocations

COL sqlmem_structure HEAD STRUCTURE FOR A20
COL sqlmem_function  HEAD FUNCTION  FOR A20
COL sqlmem_chunk_com HEAD CHUNK_COM FOR A20
COL sqlmem_heap_desc HEAD HEAP_ADDR FOR A16


SELECT
    child_number
  , sharable_mem
  , persistent_mem
  , runtime_mem
--  , typecheck_mem
FROM
    v$sql
WHERE
    sql_id = '&1'
/

SELECT
--    sql_text
--  , sql_fulltext
--    hash_value
--  , sql_id
    sum(chunk_size) total_size
  , trunc(avg(chunk_size)) avg_size
  , count(*) chunks
  , alloc_class
  , chunk_type
  , structure     sqlmem_structure
  , function      sqlmem_function
  , chunk_com     sqlmem_chunk_com
  , heap_desc     sqlmem_heap_desc
--  , chunk_ptr
--  , subheap_desc
FROM
    v$sql_shared_memory
WHERE
    sql_id = '&1'
--    hash_value = &1
GROUP BY
    hash_value
  , sql_id
  , heap_desc
  , structure
  , function
  , chunk_com
--  , chunk_ptr
  , alloc_class
  , chunk_type
--  , subheap_desc
ORDER BY
    total_size DESC
/

