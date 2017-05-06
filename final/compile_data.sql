SELECT author, subreddit, created_utc, score 
FROM `fh-bigquery.reddit_posts.2016_10`
WHERE author != "[deleted]" AND subreddit != "null" AND score > 0

UNION ALL 

SELECT author, subreddit, created_utc, score 
FROM `fh-bigquery.reddit_posts.2016_11`
WHERE author != "[deleted]" AND subreddit != "null" AND score > 0

UNION ALL 


SELECT author, subreddit, created_utc, score 
FROM `fh-bigquery.reddit_posts.2016_12`
WHERE author != "[deleted]" AND subreddit != "null" AND score > 0

UNION ALL

SELECT author, subreddit, created_utc, score 
FROM `fh-bigquery.reddit_posts.2017_01`
WHERE author != "[deleted]" AND subreddit != "null" AND score > 0

UNION ALL

SELECT author, subreddit, created_utc, score 
FROM `fh-bigquery.reddit_posts.2017_02`
WHERE author != "[deleted]" AND subreddit != "null" AND score > 0

UNION ALL

SELECT author, subreddit, created_utc, score 
FROM `fh-bigquery.reddit_posts.2017_03`
WHERE author != "[deleted]" AND subreddit != "null" AND score > 0



