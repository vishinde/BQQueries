--Per job utilization
SELECT
  job_id,
  #query,
  user_email,
  total_bytes_billed,
  SAFE_DIVIDE(total_bytes_billed, 1024*1024*1024) * 6.5 AS estimated_cost_usd, 
  TIMESTAMP_DIFF(end_time, creation_time, SECOND) AS job_duration_seconds,
  ROUND(SAFE_DIVIDE(total_slot_ms,(TIMESTAMP_DIFF(end_time, start_time, MILLISECOND)))) AS avg_slots,
  creation_time,
  end_time
FROM
  `region-us`.INFORMATION_SCHEMA.JOBS
WHERE
  job_type = 'QUERY'
  AND state = 'DONE'
  AND creation_time >= '2024-07-10'
ORDER BY
  total_bytes_billed DESC;
