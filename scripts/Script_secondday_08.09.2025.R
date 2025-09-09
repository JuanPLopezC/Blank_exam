#DAY 2 - 08.09.2025

library(here)
library(tidyverse)

#TASK 2 #----

##Reading the tidy version----

tidy_exam_data <- read_delim("data/tidy_exam_data_2025-09-08.txt", 
                             delim = "\t", escape_double = FALSE, 
                             trim_ws = TRUE)


##Delete variables using select variables----
#AA, bGS, BNplus, OrganConfined

tidy_exam_data <- tidy_exam_data %>%
  select(-African_american, -Biopsy_gleason_score, -Bladder_neck_positive, -Extra_diagnoses)

glimpse (tidy_exam_data)

#To pivot wider in order to get only 316 observations
tidy_exam_data <- tidy_exam_data %>%
  pivot_wider(
    names_from = Prostate_volume,
    values_from = Value_volume_measurement
  )


#Here i start with "Task2" - Anders 
##Task:A column showing whether `PVol` is higher than 100 or not: values High/Low
tidy_exam_data <- tidy_exam_data %>%
  mutate(
    PVol_HighLow = case_when(
        PVol >= 100 ~ "High",
      PVol < 100 ~ "Low",
      TRUE ~ ""
    )
  )
str(tidy_exam_data)


## Task: A numeric column showing `TimeToReccurence` in days (or weeks if you like)
tidy_exam_data <- tidy_exam_data %>%
  mutate(TimeToRecurrence_days = TimeToRecurrence * 7)

###This is to round to the nearest round number in the table 
tidy_exam_data <- tidy_exam_data %>%
  mutate(TimeToRecurrence_days = round(TimeToRecurrence_days))

###this is just to rearange the order of the columns
tidy_exam_data <- tidy_exam_data %>%
  relocate(TimeToRecurrence_days, .after = TimeToRecurrence_unit)


glimpse(tidy_exam_data)

## Create a new column----
#A column showing `recurrence` as Yes/No

tidy_exam_data <- tidy_exam_data %>%
  mutate(Recurrence2 = if_else(Recurrence== "0", "No", "Yes")) 

tidy_exam_data  %>% count(Recurrence2) #to compare it to the original one to see if this was correctly done

glimpse (tidy_exam_data)

#2 rows per ID because the variable Volumevolume measurement ( nå navn prostate_colum), PVol (prostate volumne) and TVol (tumor volume). 


# A numeric column showing multiplication of `AnyAdjTherapy_ (Adjuvant_radiation_therapy) and `PreopTherapy`(Preoperative_therapi) for each person
#assignment making a new variable Totaltherapy- in the real world the assignment doesn't make sense, since no one recived adjuvant therapy- so the value vil be 0 for everyone. 


tidy_exam_data <- tidy_exam_data %>%
  mutate(TotalTherapy = Adjuvant_radiation_therapy * Preoperative_therapy)

glimpse(tidy_exam_data)


#Set the order of columns:  `id, hospital, Age` and other columns
tidy_exam_data <- tidy_exam_data %>%
  select(ID, Hosp, Age, everything())

glimpse(tidy_exam_data)

#Arrange ID column of your dataset in order of increasing number or alphabetically.
tidy_exam_data <- tidy_exam_data %>%
  arrange(ID)

fileName <- paste0("data/tidy_exam_data_", Sys.Date(), ".txt")
write_delim(
  tidy_exam_data, 
  file = fileName,
  delim = "\t"
)

