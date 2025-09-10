

#starting fresh with a new name of datafile and new script for task 4, concerning ggplot. 
ggplot_exam_data <- read_tsv("data/ggplot_exam_data_2025-09-10.txt")


#Does the distribution of `Preoperativte_PSA` differ by `Tumor_stage`? yes, see plot. 
ggplot(ggplot_exam_data, aes(x = factor(Tumor_stage), y = Preoperative_PSA)) +
  geom_boxplot(fill = "lightblue", color = "darkblue") +
  labs(
    title = "Distribusjon av Preoperative PSA etter Tumor stage",
    x = "Tumor stage",
    y = "Preoperativ PSA"
  ) +
  theme_minimal()
summary(ggplot_exam_data$Preoperative_PSA)
summary(ggplot_exam_data$Tumor_stage)


# Does the distribution of `PVol` differ by `sGS`? Yes, see plot. 
ggplot(ggplot_exam_data, aes(x = factor(sGS), y = PVol)) +
  geom_boxplot(fill = "lightblue", color = "darkblue") +
  labs(
    title = "Distribusjon av Protate Volum etter surgical Gleason score",
    x = "Surgical Gleason Score",
    y = "Prostate Volume"
  ) +
  theme_minimal()

summary(ggplot_exam_data$PVol)
summary(ggplot_exam_data$sGS)

#Does the distribution of `TVol` differ by `sGS`? Yes.See plot.  
  ggplot(ggplot_exam_data, aes(x = factor(sGS), y = TVol)) +
  geom_boxplot(fill = "lightblue", color = "darkblue") +
  labs(
    title = "Distribusjon av Tumor Volum etter surgical Gleason score",
    x = "Surgical Gleason Score",
    y = "Tumor Volume"
  ) +
  theme_minimal()

summary(ggplot_exam_data$TVol)
summary(ggplot_exam_data$sGS)

#Does the distribution of `TVol` differ by `sGS`?  
# both TVOl and sGs are categorical, not continues variables,therefor choosing grouped bar plot for this task. 
#there are quite a few NA for postopr gleasonscore ( is it like this in real life?), so I choose to keep the values. 

ggplot_exam_data %>%
  ggplot(aes(x = factor(TVol), fill = factor(sGS))) +
  geom_bar(position = "dodge") +
  labs(
    title = "Fordeling av Tumor volum etter gleason score",
    x = "Tumor_volum",
    y = "Antall",
    fill = "sGS (postoperativ Gleason score)"
  ) +
  theme_minimal()




#task 5
#cheatdata("blood_storage", package = "medicaldata")
#blood_data <- blood_storage



