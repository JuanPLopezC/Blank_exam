#MAIN SCRIPT FOR BLANK EXAM - STARTING 05-09-2025#

ata <- read_delim(here("data", "exam_data.txt"))
skim(data)                  
summary(data)
head(data)
tail(data)
glimpse(data)
gg_miss_var(data)
library(dplyr)

data %>% count(subject)
any(duplicated(data))
any(duplicated(data$subject))
sum(duplicated(data))
sum(duplicated(data$subject))
names(data)



data <-data %>% 
  separate(col =subject, 
           into = c("Hosp", "ID"), 
           sep = "-")

