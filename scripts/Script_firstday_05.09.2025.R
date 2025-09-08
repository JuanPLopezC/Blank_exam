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

