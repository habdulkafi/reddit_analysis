SELECT * FROM (
  SELECT 
    author, subreddit, total_score, n_posts,
     ROW_NUMBER() OVER (PARTITION BY author ORDER BY total_score DESC) AS rn
  FROM 
    (SELECT
      author,
      subreddit,
      SUM(score) AS total_score,
      COUNT(*) AS n_posts
    FROM
      `salesminr.minrdata.all_oct_march`
    WHERE
      DATE(TIMESTAMP_SECONDS(created_utc )) > DATE(TIMESTAMP_SECONDS(1479254400)) 
      AND
      DATE(TIMESTAMP_SECONDS(created_utc )) < DATE(TIMESTAMP_SECONDS(1480464000)) 
      AND
      author IN (
        SELECT 
          author
        FROM (
          SELECT
            author,
            SUM(score) AS total_score
          FROM
            `salesminr.minrdata.all_oct_march`
          WHERE
            subreddit = "The_Donald"
            AND
            DATE(TIMESTAMP_SECONDS(created_utc )) > DATE(TIMESTAMP_SECONDS(1479254400)) 
            AND
            DATE(TIMESTAMP_SECONDS(created_utc )) < DATE(TIMESTAMP_SECONDS(1480464000)) 
            AND
            author != "[deleted]"
          GROUP BY
            author
          HAVING
            total_score >= 500
          ORDER BY
            total_score DESC
      ))
  GROUP BY
    subreddit, author
  ORDER BY
    author, total_score DESC))
WHERE 
  total_score >= 100
  AND
  n_posts >= 2
ORDER BY
  author