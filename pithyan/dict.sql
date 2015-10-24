set verify off
col COMMENTS for a80
select ' '||table_name table_name,substr(nvl(comments,'dictonary table'),1,80) comments  from dict where table_name like upper('%&1%')
union all
select owner||'.'||SYNONYM_NAME table_name, 'synonyms for '||TABLE_OWNER||'.'||TABLE_NAME comments  from dba_synonyms where SYNONYM_NAME like upper('%&1%')
union all
select owner||'.'||table_name table_name, substr(comments,1,80) comments from dba_tab_comments where table_name like upper('%&1%')
--and owner!='SYS'
ORDER BY table_name;