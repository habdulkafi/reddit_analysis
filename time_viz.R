
library(igraph)
library(tidyverse)
library(scales)
library(dplyr)


#data1 <- filter(read_csv("data/b4_algo1_translated.csv"), n_links > 1)
#data2 <- filter(read_csv("data/after_algo1_translated.csv"), n_links >  1)
data1 <- filter(read_csv("data/b4_inaug_translated.csv"), n_links > 1)
data2 <- filter(read_csv("data/after_inaug_translated.csv"), n_links >  1)


grph1 <- graph.data.frame(data1, directed = F)
grph2 <- graph.data.frame(data2, directed = F)

V(grph1)$label <- names(V(grph1))
V(grph2)$label <- names(V(grph2))

#plot(grph, layout = layout.auto, vertex.label=ifelse(degree(grph )>30,V(grph)$label, NA), vertex.size=2)


defaults <- c("politics", "The_Donald", "Art","AskReddit","askscience","aww","books","creepy",
              "dataisbeautiful","Documentaries","EarthPorn","explainlikeimfive","food",
              "funny","Futurology","gadgets","gaming","GetMotivated","gifs","history","IAmA",
              "InternetIsBeautiful","Jokes","LifeProTips","listentothis","mildlyinteresting",
              "movies","Music","news","nosleep","nottheonion","OldSchoolCool","personalfinance",
              "philosophy","photoshopbattles","pics","science","Showerthoughts","space","sports",
              "television","tifu","todayilearned","UpliftingNews","videos","worldnews")

actual_defaults1 <- names(V(grph1))[names(V(grph1)) %in% defaults]
actual_defaults2 <- names(V(grph2))[names(V(grph2)) %in% defaults]

grph1 <- delete_vertices(grph1, actual_defaults1)
grph2 <- delete_vertices(grph2, actual_defaults2)

#plot(grph2, layout = layout.auto, vertex.label=ifelse(degree(grph2 )>15,V(grph2)$label, NA), vertex.size=2)

#grph3 <- delete_vertices(grph2, c("The_Donald"))

#plot(grph3, layout=layout.auto,  vertex.label=ifelse(degree(grph3 )>10,V(grph3)$label, NA), vertex.size=2)

grph1 <- delete_vertices(grph1, which(degree(grph1) <= 1))
grph2 <- delete_vertices(grph2, which(degree(grph2) <= 1))
#grph4 <- delete_vertices(grph4, which(degree(grph4) <= 2))

par(mfrow=c(1,2))
plot(grph1, layout=layout.auto, vertex.label=ifelse(degree(grph1 )>1,
                                                    V(grph2)$label, NA), vertex.size=2)
plot(grph2, layout=layout.auto, vertex.label=ifelse(degree(grph2 )>1,
                                                    V(grph2)$label, NA), vertex.size=2)
mtext("The_Donald users subreddit preferences before and after inauguration",
      sub="Labels added to subreddits with degree greater than 5",
      side = 3, line = -5, outer = TRUE)



