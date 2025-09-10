#Script fourth day 10.09.2025#

#library(tidyverse)

#Here i try fix the timetoreccurance error - Anders  
#This is to make the correct columns in days and weeks and round the values so that it doesn't include decimals
joint_exam_data <- readr::read_tsv("data/joint_exam_data_2025-09-09.txt") %>%
  mutate(
    unit_norm = str_to_lower(str_trim(TimeToRecurrence_unit)), 
    ttr_num   = readr::parse_number(as.character(TimeToRecurrence)),
    TimeToRecurrence_days_new = case_when(
      str_starts(unit_norm, "week") ~ ttr_num * 7,
      str_starts(unit_norm, "day")  ~ ttr_num,
      TRUE ~ NA_real_
    ),
    TimeToRecurrence_weeks_new = TimeToRecurrence_days_new / 7
  ) %>%
  mutate(
    TimeToRecurrence_days_new  = as.integer(round(TimeToRecurrence_days_new, 0)),
    TimeToRecurrence_weeks_new = as.integer(round(TimeToRecurrence_weeks_new, 0))
  )

#This is to delete the old column - timetoreccurance_days
joint_exam_data <- joint_exam_data %>%
  select(-any_of(c("TimeToRecurrence_days", "timetoreccurance_days")))

#We had to do more tidy on the data because we found there were some wrong variables, we started using the joint_exam_data from 09.09.2025

#tidying collum Hosp- deleting charakters and keeping the number. 
joint_exam_data <-joint_exam_data %>%
  mutate(Hosp = gsub("Hosp", "", Hosp))%>%
  rename("Hospital" = "Hosp")

glimpse(joint_exam_data)

#Task: Stratify your data by a categorical column and report min, max, mean and sd of a numeric column. - Anders 
#library(dplyr)
#library(tidyr)

joint_exam_data %>%
  group_by(
    Tumor_stage_lab = if_else(is.na(Tumor_stage), "Missing", as.character(Tumor_stage))
  ) %>%
  summarise(
    n    = n(),
    min  = min(Preoperative_PSA, na.rm = TRUE),
    max  = max(Preoperative_PSA, na.rm = TRUE),
    mean = mean(Preoperative_PSA, na.rm = TRUE),
    sd   = sd(Preoperative_PSA, na.rm = TRUE),
    .groups = "drop"
  )



#Doing some of the exercises about stratifying#
#Stratify your data by a categorical column and report min, max, mean and sd of a numeric column for a defined set of observations - use a pipe `%>%`!    
#- Only for persons with `T.Stage == 1`


joint_exam_data %>% 
  group_by(Recurrence2) %>% 
  filter(Tumor_stage==1) %>%
  summarise(
    min_pvol = min(PVol, na.rm = TRUE),
    max_pvol = max(PVol, na.rm = TRUE),
    mean_pvol = mean(PVol, na.rm = TRUE),
    sd_pvol = sd(PVol, na.rm = TRUE)
)

# Only for persons with `Median.RBC.Age == 25`
joint_exam_data %>% 
  group_by(Recurrence2) %>% 
  filter(Median_storage_age_group==25) %>%
  summarise(
    min_pvol = min(PVol, na.rm = TRUE),
    max_pvol = max(PVol, na.rm = TRUE),
    mean_pvol = mean(PVol, na.rm = TRUE),
    sd_pvol = sd(PVol, na.rm = TRUE)
  )


#Only for persons with `TimeToReccurence` later than 4 weeks
joint_exam_data %>% 
  group_by(Recurrence2) %>% 
  filter(TimeToRecurrence_weeks_new>4) %>%
  summarise(
    min_pvol = min(PVol, na.rm = TRUE),
    max_pvol = max(PVol, na.rm = TRUE),
    mean_pvol = mean(PVol, na.rm = TRUE),
    sd_pvol = sd(PVol, na.rm = TRUE)
  )


# Only for persons recruited in `Hospital==1` and `TVol == 2`
joint_exam_data %>% 
  group_by(Recurrence2) %>% 
  filter(Hospital == 1, TVol== 2) %>%
  summarise(
    min_pvol = min(PVol, na.rm = TRUE),
    max_pvol = max(PVol, na.rm = TRUE),
    mean_pvol = mean(PVol, na.rm = TRUE),
    sd_pvol = sd(PVol, na.rm = TRUE)
  )

#Exercise: Use two categorical columns in your dataset to create a table (either with table(), count(), or janitor::tabyl()) - Anders 
#library(dplyr), #library(tidyr), 
library(forcats)
tab <- joint_exam_data %>%
  mutate(
    Tumor_stage = fct_explicit_na(as.factor(Tumor_stage), na_level = "Missing"),
    Hospital        = as.factor(Hospital)
  ) %>%
  count(Tumor_stage, Hospital, name = "n", .drop = FALSE) %>%
  pivot_wider(names_from = Hospital, values_from = n, values_fill = 0)

tab

#Save new data file ready for ggplot
fileName <- paste0("data/ggplot_exam_data_", Sys.Date(), ".txt")
write_delim(
  joint_exam_data, 
  file = fileName,
  delim = "\t"
)

