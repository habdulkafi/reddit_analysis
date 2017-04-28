


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


day_data %>% ggplot(aes(day_of_month, n_posts)) + geom_col()


n_gilds <- read_csv("n_gilds_jan_feb_mar.csv")


n_gilds %>% ggplot(aes(month,n_gilds)) + 
  geom_bar(aes(fill=domain), position = "dodge", stat="identity")





