


library(igraph)
library(tidyverse)
library(scales)


data <- read_csv("top_t_d_2000_500_2.csv")


grph <- graph_from_data_frame(data, directed = F)

V(grph)[data$subreddit]$color <- "red"
V(grph)[data$author]$color <- "blue"
plot(grph,vertex.label=NA, vertex.size= 2)


V(grph)$type <- TRUE
V(grph)[data$author]$type <- FALSE
plot( grph, layout=layout_as_bipartite, vertex.label=NA, vertex.size=2 )

bgrph <- bipartite.projection(grph)
plot( grph, layout=layout.auto, vertex.label=NA, vertex.size=2 )
