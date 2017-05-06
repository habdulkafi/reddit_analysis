## Final Code folder for Project

### `Data` Folder

This folder includes the data files generated using SQL queries to the [BigQuery](https://bigquery.cloud.google.com/dataset/fh-bigquery:reddit_posts) Reddit data set.  The SQL queries do the following:

#### `compile_data.sql`

This query combines the monthly tables for October, November, December, January, February and March into one big table.  We used this table for all the other queries. 

#### `example_query.sql`

This is an example query of how we got the two-week windows of data along with the thresholding.  In this case, a user is considered a part of `The_Donald` if they have a score of more than 500, and considered a part of a cross-subreddit if they have a score of more than 100.  Both of those scores are just in the time window we are currently looking at.

#### `total_score_query.sql`

This query gets the total score by posters of `The_Donald` per day for November through the end of February.

-----

### `plot_bar_chart.R`

This script plots the top cross-subreddits in each of the time windows we are lookign at as a bar chart.  

### `translate_to_graph`

This script converts the data from a format of author|subreddit|total_score|n_posts|rn to that of subreddit1|subreddit2|n_links

### `plot_network.R`

This script plots the network graphs for each of the time windows.  It filters based on number of links, filters out the default subreddits, deletes `The_Donald` as a node (since it's implicitly connected to each vertex already), and removes vertices of degree 1.  

### `plot_total_score_t_d.R`

This script plots the total score per day on `The_Donald`.

-----

## `Images`

The Images folder contains all the output images.

