
library(igraph)
library(tidyverse)
library(scales)
library(dplyr)


data <- read_csv("b4_algo1_500_100_2.csv")

data <- data %>% filter(n_links > 1)
grph <- graph.data.frame(data, directed = F)

V(grph)$label <- names(V(grph))

plot(grph, layout = layout.auto, vertex.label=ifelse(degree(grph )>30,V(grph)$label, NA), vertex.size=2)


defaults <- c("Art","AskReddit","askscience","aww","books","creepy",
              "dataisbeautiful","Documentaries","EarthPorn","explainlikeimfive","food",
              "funny","Futurology","gadgets","gaming","GetMotivated","gifs","history","IAmA",
              "InternetIsBeautiful","Jokes","LifeProTips","listentothis","mildlyinteresting",
              "movies","Music","news","nosleep","nottheonion","OldSchoolCool","personalfinance",
              "philosophy","photoshopbattles","pics","science","Showerthoughts","space","sports",
              "television","tifu","todayilearned","UpliftingNews","videos","worldnews")

actual_defaults <- names(V(grph))[names(V(grph)) %in% defaults]


grph2 <- delete_vertices(grph, actual_defaults)

plot(grph2, layout = layout.auto, vertex.label=ifelse(degree(grph2 )>15,V(grph2)$label, NA), vertex.size=2)

grph3 <- delete_vertices(grph2, c("The_Donald"))

plot(grph3, layout=layout.auto,  vertex.label=ifelse(degree(grph3 )>10,V(grph3)$label, NA), vertex.size=2)

grph4 <- delete_vertices(grph3, which(degree(grph3) <= 1))
grph4 <- delete_vertices(grph4, which(degree(grph4) <= 2))

plot(grph4, layout=layout.auto,  vertex.label=ifelse(degree(grph4 )>30,V(grph4)$label, NA), vertex.size=2)




