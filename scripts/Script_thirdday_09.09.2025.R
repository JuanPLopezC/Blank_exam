#Script day 3 - 09.09.2025#

library(here)
library(tidyverse)


##Reading the tidy version from 09.09.2025----

tidy_exam_data <- read_delim("data/tidy_exam_data_2025-09-09.txt", 
                             delim = "\t", escape_double = FALSE, 
                             trim_ws = TRUE)

#Read additional data#
additional_data <- read_delim("data/exam_data_join.txt", 
           delim = "\t", escape_double = FALSE, 
           trim_ws = TRUE)

#Join the additional data#

joint_exam_data <- tidy_exam_data %>%
  left_join(additional_data, join_by(ID == id))

glimpse(joint_exam_data)

#to save it as a new database
fileName <- paste0("data/joint_exam_data_", Sys.Date(), ".txt")
write_delim(
  joint_exam_data, 
  file = fileName,
  delim = "\t"
)
