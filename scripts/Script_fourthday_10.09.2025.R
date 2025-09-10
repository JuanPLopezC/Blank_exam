#Script fourth day 10.09.2025#

#We had to do more tidy on the data because we found there were some wrong variables, we started using the joint_exam_data

tidy_exam_data <- read_delim("data/joint_exam_data_2025-09-09.txt", 
                             delim = "\t", escape_double = FALSE, 
                             trim_ws = TRUE)