#Script fourth day 10.09.2025#

#We had to do more tidy on the data because we found there were some wrong variables, we started using the joint_exam_data from 09.09.2025


#Here i try fix the timetoreccurance error - Anders  
#This is to make the correct columns in days and weeks and round the values so that it doesn't include decimals
tidy_exam_data <- readr::read_tsv("data/joint_exam_data_2025-09-09.txt") %>%
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
tidy_exam_data <- tidy_exam_data %>%
  select(-any_of(c("TimeToRecurrence_days", "timetoreccurance_days")))



#Doing some of the exercises about stratifying#
#Stratify your data by a categorical column and report min, max, mean and sd of a numeric column for a defined set of observations - use a pipe `%>%`!    
#- Only for persons with `T.Stage == 1`


tidy_exam_data %>% 
  group_by(Recurrence2) %>% 
  filter(Tumor_stage==1) %>%
  summarise(
    min_pvol = min(PVol, na.rm = TRUE),
    max_pvol = max(PVol, na.rm = TRUE),
    mean_pvol = mean(PVol, na.rm = TRUE),
    sd_pvol = sd(PVol, na.rm = TRUE)
)

# Only for persons with `Median.RBC.Age == 25`
tidy_exam_data %>% 
  group_by(Recurrence2) %>% 
  filter(Median_storage_age_group==25) %>%
  summarise(
    min_pvol = min(PVol, na.rm = TRUE),
    max_pvol = max(PVol, na.rm = TRUE),
    mean_pvol = mean(PVol, na.rm = TRUE),
    sd_pvol = sd(PVol, na.rm = TRUE)
  )

