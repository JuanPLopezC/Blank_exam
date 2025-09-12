# Script day 11.09.2025----

## Task 5#----

## Guri----
# Was the time to recurrence different for various `RBC.Age.Group` levels?
# Expecting that the variable time to recurrence is not normaly distributed, and run theese to commands to check.
shapiro.test(ggplot_exam_data$TimeToRecurrence_weeks_new)
hist(ggplot_exam_data$TimeToRecurrence_weeks_new)

# therefor choosing Kruskal wallies test
kruskal.test(TimeToRecurrence_weeks_new ~ factor(Storage_age_group), data = ggplot_exam_data)
#
# data:  TimeToRecurrence_weeks_new by factor(Storage_age_group)
# Kruskal-Wallis chi-squared = 1.0218, df = 2, p-value = 0.6
# NO, P-value > 0,05


# Was the time to recurrence different for various `T.Stage` levels?
kruskal.test(TimeToRecurrence_weeks_new ~ factor(Tumor_stage), data = ggplot_exam_data)
# Kruskal-Wallis rank sum test data:  TimeToRecurrence_weeks_new by factor(Tumor_stage)
# Kruskal-Wallis chi-squared = 7.9623, df = 1, p-value = 0.004776
# Answer: yes, there's a clear correlation between time to recurrense and tumor_stage, makes sense,

## Anders----
# Did having Adjuvant_radiation_therapy affected time to recurrence?

data <- read_tsv("data/ggplot_exam_data_2025-09-10.txt")

model1 <- data %>%
  lm(TimeToRecurrence_days_new ~ Adjuvant_radiation_therapy, data = .) %>%
  broom::tidy()
model1
#Answer:No—there was no significant association between adjuvant radiation therapy and time to recurrence (β = −172 days, p = 0.39) in this unadjusted model.

## JP----
# Did those that had recurrence had also larger `TVol` values than those without recurrence?

model2 <- data %>%
  lm(TVol ~ Recurrence, data = .) %>%
  broom::tidy()
model2
#Answer: Yes—patients with recurrence had significantly larger TVol than those without (β = +0.545, p = 2.87e−7; unadjusted model).
library(dplyr)

# Renaming sGS column - Anders 
ggplot_exam_data <- ggplot_exam_data |> rename(Surgical_gleason_score = sGS)

