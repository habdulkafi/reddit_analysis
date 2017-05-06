library(tidyverse)
library(igraph)
library(scales)



data <- read_csv("data/total_count_nov_feb_t_d.csv")


data %>% ggplot(aes(day_of_month, total_score)) + 
  geom_point() + geom_line() + 
  ylab("Total Score on The_Donald") + 
  xlab("Date") + 
  scale_y_continuous(labels=comma)

ggsave("images/algos_total_score_nov_feb_t_d.png", width = 11, height = 8.5)
