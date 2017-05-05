library(tidyverse)
library(igraph)
library(scales)


visualize <- function( filename, n){
  dat <- read_csv(paste0("data/", filename, ".csv"))
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
  png(filename = paste0("images/", filename, ".png"), width = 1920, height = 1080)
  plot(g, layout = layout.auto, vertex.size=2, vertex.label.dist=.5, 
       vertex.label.degree=pi, vertex.label.cex=1.5, main=filename)
  dev.off()
}



files <- c("b4_election_translated", "after_election_translated", "b4_algo1_translated",
  "after_algo1_translated", "b4_inaug_translated", "after_inaug_translated", 
  "b4_algo2_translated", "after_algo2_translated")

for (file in files) {
  visualize(file, 2)
}
