#Script fourth day 10.09.2025#

#We had to do more tidy on the data because we found there were some wrong variables, we started using the joint_exam_data

joint_exam_data <- read_delim("data/joint_exam_data_2025-09-09.txt", 
                             delim = "\t", escape_double = FALSE, 
                             trim_ws = TRUE)



#Doing some of the exercises about stratifying#
#Stratify your data by a categorical column and report min, max, mean and sd of a numeric column for a defined set of observations - use a pipe `%>%`!    
#- Only for persons with `T.Stage == 1`
#- Only for persons with `Median.RBC.Age == 25`


