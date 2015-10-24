####################################
## resource FEATURE usage details for database
####################################

col CUR_UTIL_PCT for a10
col MAX_UTIL_PCT for a10
SELECT   resource_name, current_utilization, max_utilization,
		 initial_allocation, limit_value,
		 CASE
			WHEN (TRIM (limit_value) != 'UNLIMITED'
				  AND TRIM (limit_value) != '0'
				 )
			   THEN    ROUND (  current_utilization
							  / TO_NUMBER (TRIM (limit_value))
							  * 100
							 )
					|| ' %'
			ELSE null
		 END cur_util_pct,
		 CASE
			WHEN (TRIM (limit_value) != 'UNLIMITED'
				  AND TRIM (limit_value) != '0'
				 )
			   THEN    ROUND (  max_utilization
							  / TO_NUMBER (TRIM (limit_value))
							  * 100
							 )
					|| ' %'
			ELSE null
		 END max_util_pct
	FROM v$resource_limit
ORDER BY cur_util_pct , max_util_pct;
