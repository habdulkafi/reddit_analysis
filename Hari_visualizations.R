
strlibrary(igraph)
library(tidyverse)
library(scales)
library(dplyr)


# read in edge list
data <- read_csv( 'top_t_d_2000_500_no_def_subred.csv' )

thresholds <- seq(2, 7) * 2500
stronger_condition_graph <- vector( "list", 6 )
i <- 1
for ( thresh in thresholds ){
  stronger_condition_graph[[i]] <- graph.data.frame( filter( data, total_score > thresholds[i]   ), directed=F  )
  i <- i + 1
}


#e <- filter(data, total_score>50000 )


#stronger_condition_graph <- graph.data.frame( e, directed=T )
#donald_g <- graph.data.frame( data, directed=T )

#V(donald_g)$type <- V(donald_g)$name %in% table(data$author)

#V(donald_g)[data$subreddit]$color <- "red"
#V(donald_g)[data$author]$color <- "blue"



#V(stronger_condition_graph)$label <- e$subreddit
#V(stronger_condition_graph)$label.cex = .6

set.seed(1234) 

#plot( donald_g, layout=layout.auto, vertex.label=NA, vertex.size=2, edge.arrow.size=.1)




par(mfrow=c(2,3))

for ( graphing in stronger_condition_graph ){
  V(graphing)$label <- data$subreddit
  V(graphing)$label.cex = .6
  graphing<-delete.vertices(graphing,which(degree(graphing) < 2))
  plot( graphing, 
        layout=layout.auto, 
        vertex.label=ifelse(degree(graphing )>15,
                            V(graphing)$label, NA), 
        vertex.size=1#, 
        #edge.arrow.size=.05
      )  
}



#plot( decompose.graph(donald_g)[[1]], layout=layout.auto, vertex.label=NA, vertex.size=2, edge.arrow.size=.1 )


nrow(data)













layout.by.attr <- function(graph, wc, cluster.strength=1,layout=layout.auto) {  
  g <- graph.edgelist(get.edgelist(graph)) # create a lightweight copy of graph w/o the attributes.
  E(g)$weight <- 1
  
  attr <- cbind(id=1:vcount(g), val=wc)
  g <- g + vertices(unique(attr[,2])) + igraph::edges(unlist(t(attr)), weight=cluster.strength)
  
  l <- layout(g, weights=E(g)$weight)[1:vcount(graph),]
  return(l)
}

