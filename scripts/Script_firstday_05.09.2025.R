#MAIN SCRIPT FOR BLANK EXAM - STARTING 05-09-2025#

library(dplyr)
library (usethis)
library(here)
library(tidyverse)
library(skimr)

use_git_config(fetch.prune = "true")
here("data", "exam_data.txt")

#exploring the data
data <- read_delim(here("data", "exam_data.txt"))
skim(data)                  
summary(data)
head(data)
tail(data)
glimpse(data)
gg_miss_var(data)


data %>% count(subject)
any(duplicated(data))
any(duplicated(data$subject))
sum(duplicated(data))
sum(duplicated(data$subject))
names(data)


#separate collum subject til Hosp og ID
data <-data %>% 
  separate(col =subject, 
           into = c("Hosp", "ID"), 
           sep = "-")

#Removing duplicates. Checking afterwars that the clean_data has 40 less rows. 
data_clean<- data %>%
  distinct()
nrow(data_clean)
nrow(data)


