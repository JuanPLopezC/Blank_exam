
#SCRIPT FOR BLANK EXAM#

#TASK 1 - 05.09.2025#----
##Opening tidyverse and here package ----
library(dplyr)
library (usethis)
library(here)
library(tidyverse)
library(skimr)

use_git_config(fetch.prune = "true")
here("data", "exam_data.txt")

##Exploring the data ----
skimr::skim(exam_data)
summary(exam_data)
summary(data)
head(data)
tail(data)
glimpse(data)
gg_miss_var(data)
exam_data %>%
  distinct(subject)


###From the exploration:----
#It contains 672 rows and 21 columns.
#Data seems to be repeated. It says that we have 316 unique subjects and some missing, 40.
#There is one variable starting with numbers: 1_Age. With spaces: T stage, volume measurement. With other things: .value

#We should change and rename some of the variables:

##Subject needs to be separated and renamed: Hosp and ID
##RBC.Age.Group : Storage_age_group
##Median.RBC.Age : Median_storage_age_group
##1_Age: Age
##AA : African_american
## FamHx : Family_history
##T stage : Tumor_stage
##bGS : Biopsy_gleason_score
##BN+ : Bladder_neck_positive
##OrganConfined: Extra_diagnoses
##PreopPSA: Preoperative_PSA
##PreopTherapy: Preoperative_therapy
##Units: Allogeneic_units
##AnyAjdTherapy: Adjuvant_therapy
##AdjRadTherapy: Adjuvant_radiation_therapy
##Recurrence: stays the same
##Censor: same
##TimeToRecurrence: same
##TimeToRecurrence_unit : same
##volume measurement: Prostate_volume
##.value: Value_volume_measurement
#exploring the data


###To be able to find duplicates ----
data %>% count(subject)
any(duplicated(data))
any(duplicated(data$subject))
sum(duplicated(data))
sum(duplicated(data$subject))
names(data)


#Separate collum subject til Hosp og ID
data_clean <-exam_data %>% 
  separate(col =subject, 
           into = c("Hosp", "ID"), 
           sep = "-")
data_clean

##Change ID from chr to numeric
data_clean$ID <- as.numeric(as.character(data_clean$ID))
str(data_clean)

##Renaming the variables according to the suggestions above ----

data_clean <- data_clean %>%
  rename("Storage_age_group" = "RBC.Age.Group" ) %>%
  rename("Median_storage_age_group" = "Median.RBC.Age" ) %>%
  rename("Age" ="1_Age") %>%
  rename("African_american" ="AA") %>%
  rename( "Family_history" = "FamHx") %>%
  rename("Tumor_stage" ="T stage") %>%
  rename("Biopsy_gleason_score" = "bGS") %>%
  rename("Bladder_neck_positive" = "BN+") %>%
  rename("Extra_diagnoses" = "OrganConfined") %>%
  rename("Preoperative_PSA" = "PreopPSA") %>%
  rename("Preoperative_therapy" = "PreopTherapy") %>%
  rename("Allogeneic_units" = "Units") %>%
  rename("Adjuvant_therapy" = "AnyAdjTherapy") %>%
  rename("Adjuvant_radiation_therapy" = "AdjRadTherapy") %>%
  rename("Prostate_volume" = "volume measurement") %>%
  rename("Value_volume_measurement" = ".value")

glimpse(data_clean)

##Removing duplicates. Checking afterwars that the clean_data has 40 less rows.---- 
data_clean<- data_clean %>%
  distinct()
nrow(data_clean)
nrow(exam_data)



##Make the tidy version of the database based on the changes we did in each branch and save it with today's date----

fileName <- paste0("data/tidy_exam_data_", Sys.Date(), ".txt")
write_delim(
  data_clean, 
  file = fileName,
  delim = "\t"
)

##Reading the tidy version----

tidy_exam_data <- read_delim("data/tidy_exam_data_2025-09-08.txt", 
                                        delim = "\t", escape_double = FALSE, 
                                        trim_ws = TRUE)


glimpse (tidy_exam_data)


#TASK 2 #----

##Delete variables using select variables----
#AA, bGS, BNplus, OrganConfined

tidy_exam_data <- tidy_exam_data %>%
  select(-African_american, -Biopsy_gleason_score, -Bladder_neck_positive, -Extra_diagnoses)

glimpse (tidy_exam_data)


## Create a new column----
#A column showing `recurrence` as Yes/No

tidy_exam_data <- tidy_exam_data %>%
  mutate(Recurrence2 = if_else(Recurrence== "0", "No", "Yes")) %>% count(Recurrence)

tidy_exam_data  %>% count(Recurrence) #to compare it to the original one to see if this was correctly done

glimpse (tidy_exam_data)
