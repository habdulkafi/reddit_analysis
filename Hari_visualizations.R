
library(igraph)
library(tidyverse)
library(scales)
library(dplyr)


# read in edge list
# mean: 4705, median 1433, 3rd quartile: 3475
#data <- read_csv( '2016_17_no_def_subred.csv' )
# data <- read_csv( 'wtf.csv' )
# 
# # thresholds for pretty printing
# thresholds <- seq(1, 6) * 2500
# stronger_condition_graph <- vector( "list", 6 )
# 
# #thresholds based on
# i <- 1
# for ( thresh in thresholds ){
#   stronger_condition_graph[[i]] <- graph.data.frame( filter( data, t_d_score > thresholds[i]   ), directed=F  )
#   i <- i + 1
# }
# 
# 
# #e <- filter(data, total_score>50000 )
# 
# 
# #stronger_condition_graph <- graph.data.frame( e, directed=T )
# #donald_g <- graph.data.frame( data, directed=T )
# 
# #V(donald_g)$type <- V(donald_g)$name %in% table(data$author)
# 
# #V(donald_g)[data$subreddit]$color <- "red"
# #V(donald_g)[data$author]$color <- "blue"
# 
# 
# 
# #V(stronger_condition_graph)$label <- e$subreddit
# #V(stronger_condition_graph)$label.cex = .6
# 
# set.seed(1234)
# 
# #plot( donald_g, layout=layout.auto, vertex.label=NA, vertex.size=2, edge.arrow.size=.1)
# 
# par(mfrow=c(2,3))
# 
# for ( graphing in stronger_condition_graph ){
#   V(graphing)$label <- data$subreddit
#   V(graphing)$label.cex = .6
#   graphing<-delete.vertices(graphing,which(degree(graphing) < 4))
#   plot( graphing,
#         layout=layout.auto,
#         vertex.label=ifelse(degree(graphing )>20,
#                             V(graphing)$label, NA),
#         vertex.size=1#,
#         #edge.arrow.size=.05
#       )
# }





#plot( decompose.graph(donald_g)[[1]], layout=layout.auto, vertex.label=NA, vertex.size=2, edge.arrow.size=.1 )


#nrow(data)

# median total score in 4383, 3rd quartile 11264, mean 144997
# num posts for pruned data is 22098 vs28742

t_d_weights <- read_csv('wtf.csv')
t_d_weights$total_score <- strtoi( t_d_weights$total_score )
set.seed(3000)


thresholds <- seq(.1, .6, .1)
stronger_condition_graph <- vector( "list", 6 )
total_edges <- nrow(t_d_weights)
#thresholds based on
i <- 1
for ( thresh in thresholds ){
 
  sample_per <- thresholds[[i]] * total_edges
  ndx <- sample( 1:total_edges, sample_per, replace=F)
  
  user_sample <- t_d_weights[ ndx, ]
  stronger_condition_graph[[i]] <- graph.data.frame( filter(user_sample,t_d_score < 9912), directed=F  )
  V(stronger_condition_graph[[i]])$label <- user_sample$subreddit
  V(stronger_condition_graph[[i]])$label.cex = .4
  V(stronger_condition_graph[[i]])$color[user_sample$subreddit] <- "red"
  i <- i + 1
}


# 
# sample_graph <- graph.data.frame( user_sample, directed = F )
# #V(sample_graph)$type <- V(sample_graph)$name %in% table(data$author)
# V(sample_graph)[t_d_weights$subreddit]$color <- "red"
# V(sample_graph)[t_d_weights$author]$color <- "blue"


par(mfrow=c(2,3))
for (sample_graph in stronger_condition_graph){

  sample_graph<-delete.vertices(sample_graph,which(degree(sample_graph) < 3))
  plot( sample_graph,
        layout=layout.auto,
        vertex.label=ifelse(degree(sample_graph )>2,
                            V(sample_graph)$label, NA),
        vertex.size=1#,
        #edge.arrow.size=.05
      )
}







layout.by.attr <- function(graph, wc, cluster.strength=1,layout=layout.auto) {  
  g <- graph.edgelist(get.edgelist(graph)) # create a lightweight copy of graph w/o the attributes.
  E(g)$weight <- 1
  
  attr <- cbind(id=1:vcount(g), val=wc)
  g <- g + vertices(unique(attr[,2])) + igraph::edges(unlist(t(attr)), weight=cluster.strength)
  
  l <- layout(g, weights=E(g)$weight)[1:vcount(graph),]
  return(l)
}

