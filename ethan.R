library(tidyverse)
library(igraph)
library(scales)

election_b <- read_csv("data/b4_election_translated.csv")
election_a <- read_csv("data/after_election_translated.csv")
algo1_b <- read_csv("data/b4_algo1_translated.csv")
algo1_a <- read_csv("data/after_algo1_translated.csv")
inaug_b <- read_csv("data/b4_inaug_translated.csv")
inaug_a <- read_csv("data/after_inaug_translated.csv")
algo2_b <- read_csv("data/b4_algo2_translated.csv")
algo2_a <- read_csv("data/after_algo2_translated.csv")

visualize <- function(dat, n){
defaults <- c("Art","AskReddit","askscience","aww","books","creepy",
              "dataisbeautiful","Documentaries","EarthPorn","explainlikeimfive","food",
              "funny","Futurology","gadgets","gaming","GetMotivated","gifs","history","IAmA",
              "InternetIsBeautiful","Jokes","LifeProTips","listentothis","mildlyinteresting",
              "movies","Music","news","nosleep","nottheonion","OldSchoolCool","personalfinance",
              "philosophy","photoshopbattles","pics","science","Showerthoughts","space","sports",
              "television","tifu","todayilearned","UpliftingNews","videos","worldnews")
dat <- dat %>% filter(n_links>n)
g <- graph.data.frame(dat, directed = F)
actual_defaults <- names(V(g))[names(V(g)) %in% defaults]
g <- delete_vertices(g, actual_defaults)
g <- delete_vertices(g, "The_Donald")
plot(g, layout = layout.auto, vertex.size=1, vertex.label.dist=1, vertex.label.degree=pi, vertex.label.cex=0.5)
}

visualize(election_b, 2)
visualize(election_a, 2)
visualize(algo1_b, 2)
visualize(algo1_a, 2)
visualize(inaug_b, 2)
visualize(inaug_a, 2)
visualize(algo2_b, 2)
visualize(algo2_a, 2)
