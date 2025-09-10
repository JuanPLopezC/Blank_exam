#Script fourth day 10.09.2025#

#We had to do more tidy on the data because we found there were some wrong variables, we started using the joint_exam_data

tidy_exam_data <- read_delim("data/joint_exam_data_2025-09-09.txt", 
                             delim = "\t", escape_double = FALSE, 
                             trim_ws = TRUE)

#Here i try fix the timetoreccurance error - Anders  
#This is to make the correct columns in days and weeks and round the values so that it doesn't include decimals
tidy_exam_data <- readr::read_tsv("data/joint_exam_data_2025-09-10.txt") %>%
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
