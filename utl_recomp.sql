1. Recompile all objects sequentially:

execute utl_recomp.recomp_serial();

2. Recompile objects in schema SCOTT sequentially:

execute utl_recomp.recomp_serial(‘SCOTT’);

3. Recompile all objects using 4 parallel threads:

execute utl_recomp.recomp_parallel(4);

4. Recompile objects in schema JOE using the number of threads
specified in the paramter JOB_QUEUE_PROCESSES:

execute utl_recomp.recomp_parallel(NULL, ‘JOE’);

5. Recompile all objects using 2 parallel threads, but allow
other applications to use the job queue concurrently:

execute utl_recomp.recomp_parallel(2, NULL,utl_recomp.share_job_queue);

6. Restore the job queue after a failure in recomp_parallel:

execute utl_recomp.restore_job_queue();

In other words – after it is installed you can use it to recompile your objects. You need privileges from the SYS environment on the utl_recomp package to use it. An advantage right now is that the source is not WRAPPED, disadvantage – you need the dba to install it. Nethertheless my “buikgevoel”says that it will be production worthy soon. As usual the moment has a “production” marker, the source will be WRAPPED by Oracle…
..
