#SCRIPT FIRST DAY - 05-09-2025#

#Opening tidyverse and here package ----
library(tidyverse)
library(here)

#Reading file using read_delim ----
exam_data <- read_delim(here( "data/exam_data.txt"))

#Exploring the data ----
skimr::skim(exam_data)
glimpse(exam_data)
summary(exam_data)

exam_data %>%
  distinct(subject)


#It contains 672 rows and 21 columns.
#Data seems to be repeated. It says that we have 316 unique subjects and some missing, 40.
#There is one variable starting with numbers: 1_Age




