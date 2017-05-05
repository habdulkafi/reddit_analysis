


library(igraph)
library(tidyverse)
library(scales)
library(ggplot2)

library(ggthemes)
theme_set(theme_fivethirtyeight())


plot_bar_graph <- function(filename, titlename) {

  data <- read_csv(paste0("data/",filename, ".csv"))
  
  
  plot_data <- data %>% 
    group_by(subreddit) %>%
    summarise(count=n()) %>%
    ungroup(subreddit) %>%
    arrange(desc(count)) %>%
    mutate(rank = row_number()) %>%
    filter(rank <= 20 & rank > 1) 
  
  plot_data$subreddit <- factor(plot_data$subreddit, levels=plot_data$subreddit)
  
  
  plot_data %>%
    ggplot(aes(subreddit, count)) + 
    geom_col() + 
    theme(axis.text.x = element_text(angle = 90, hjust = 1), 
          axis.title = element_text(), axis.title.x = element_blank()) + 
    labs(y="Number of Links") +
    ggtitle(paste0("Number of Links\n", titlename))
  
  
  
  ggsave(paste0("images/",filename, ".png"), width = 11, height = 8.5)

}

plot_bar_graph("b4_algo1_500_100_2", "before the first algorithm change")
plot_bar_graph("after_algo1_500_100_2", "after the first algorithm change")
plot_bar_graph("b4_algo2_500_100_2", "before the second algorithm change")
plot_bar_graph("after_algo2_500_100_2", "after the second algorithm change")
plot_bar_graph("b4_election_500_100_2", "before the election")
plot_bar_graph("after_election_500_100_2", "after the election")
plot_bar_graph("b4_inaug_500_100_2", "before the inauguration")
plot_bar_graph("after_inaug_500_100_2", "after the inauguration")








  