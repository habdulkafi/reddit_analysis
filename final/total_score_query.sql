SELECT SUM(score) as total_score, DATE(TIMESTAMP_SECONDS(created_utc )) AS day_of_month
FROM `salesminr.minrdata.all_oct_march` 
WHERE 
  DATE(TIMESTAMP_SECONDS(created_utc )) > DATE(TIMESTAMP_SECONDS(1477958400))
  AND 
  DATE(TIMESTAMP_SECONDS(created_utc )) < DATE(TIMESTAMP_SECONDS(1488240000))
  AND
  subreddit = 'The_Donald'
GROUP BY
  day_of_month