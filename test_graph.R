


library(igraph)
library(tidyverse)
library(scales)
library(ggplot2)

library(ggthemes)
theme_set(theme_fivethirtyeight())


data <- read_csv("top_t_d_2000_500_2.csv")


grph <- graph_from_data_frame(data, directed = F)

V(grph)[data$subreddit]$color <- "red"
V(grph)[data$author]$color <- "blue"
plot(grph,vertex.label=NA, vertex.size= 2)


V(grph)$type <- TRUE
V(grph)[data$author]$type <- FALSE
E(grph)$weight <- scale(data$total_score,center=FALSE)
plot( grph, layout=layout_as_bipartite, vertex.label=NA, vertex.size=2 )

bgrph <- bipartite.projection(grph)
plot( grph, layout=layout.auto, vertex.label=NA, vertex.size=2 )


day_data <- read_csv("t_d_n_posts_oct_nov_dec.csv")


day_data %>% ggplot(aes(day_of_month, n_posts)) + 
  geom_col() +
  theme(axis.title = element_text()) +
  ylab("Number of Posts") + 
  xlab("Date") +
  ggtitle("Posts per day on r/The_Donald")


n_gilds <- read_csv("n_gilds_jan_feb_mar.csv")


n_gilds %>% ggplot(aes(month,n_gilds)) + 
  geom_bar(aes(fill=domain), position = "dodge", stat="identity") +
  theme(axis.title = element_text(), axis.title.x = element_blank()) + 
  labs(y="Number of Gilds")



n_posts <- read_csv("top_sr_jan_feb_mar.csv")

n_posts %>% ggplot(aes(month,n_posts)) + 
  geom_bar(aes(fill=subreddit), position = "dodge", stat="identity") +
  scale_y_continuous(labels=comma) +
  theme(axis.title = element_text(), axis.title.x = element_blank()) + 
  labs(y="Number of Posts") +
  ggtitle("Number of posts on top 10 Subreddits for 2017")


t_d_sr <- read_csv("top_t_d_sr.csv")


t_d_sr %>% 
  mutate(rank=row_number()) %>%
  filter(rank <= 20) %>%
  ggplot(aes(subreddit,total_score_sum)) + 
  geom_bar(aes(fill=subreddit),stat="identity") +
  scale_y_continuous(labels=comma)+
  theme(axis.title = element_text(), axis.title.x = element_blank(),  axis.text.x=element_blank()) + 
  labs(y="Total Points") +
  ggtitle("Total non-The_Donald points accrued by top T_D posters")

