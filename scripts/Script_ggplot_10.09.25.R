#Script for fifth day - ggplot 10.09.09#


#library(here)
#library(tidyverse)
#library(patchwork)


##Reading the ggplot version from 10.09.2025----

ggplot_exam_data <- read_delim("data/ggplot_exam_data_2025-09-10.txt", 
                             delim = "\t", escape_double = FALSE, 
                             trim_ws = TRUE)

ggplot_exam_data
