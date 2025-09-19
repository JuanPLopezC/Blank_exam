# Script 2025-10-09----


# install.packages("ggplot2")
# install.packages("ggcorrplot")
library(readr)
library(dplyr)
library(GGally)
library(tidyverse)
library(ggcorrplot)
library(here)

## Reading the ggplot version from 10.09.2025----
# starting fresh with a new name of datafile and new script for task 4, concerning ggplot.
ggplot_exam_data <- read_tsv(here("data","ggplot_exam_data_2025-09-10.txt"))

## Anders----
### Choosing solely numeric columns and filtrating columns that causes issues (missing N/A, or ID)
num <- ggplot_exam_data %>%
  select(where(is.numeric)) %>%
  select(-any_of(c("ID", "ttr_num", "TimeToRecurrence_weeks_new"))) %>%
  mutate(across(everything(), ~ ifelse(is.finite(.), ., NA_real_))) %>%
  select(where(~ sum(!is.na(.)) >= 3)) %>%
  select(where(~ sd(., na.rm = TRUE) > 0))

## Making a correlation matrix
cm <- cor(num, use = "pairwise.complete.obs", method = "pearson")

## filtrating
ok <- (rowSums(!is.finite(cm)) == 0) & (colSums(!is.finite(cm)) == 0)
cm_ok <- cm[ok, ok, drop = FALSE]

## Shorter labels
labs <- make.unique(abbreviate(colnames(cm_ok), minlength = 12))
colnames(cm_ok) <- rownames(cm_ok) <- labs

## making the heatmap
plot_1 <- ggcorrplot(
  cm_ok,
  type = "lower",
  lab = FALSE,
  outline.col = "white",
  show.diag = TRUE,
  hc.order = TRUE
) +
  theme(
    axis.text.x = element_text(angle = 45, hjust = 1, vjust = 1, size = 8),
    axis.text.y = element_text(size = 8)
  )

plot_1

# Exercise: Is there a relation between the `PVol` and `TVol` variables? Yes, there is a weak negative association between PVol and TVol (Spearman ρ = −0.21, p < 0.001). Anders
ggplot_exam_data2 <- ggplot_exam_data %>%
  select(PVol, TVol) %>%
  filter(!is.na(PVol), !is.na(TVol))

# Checking for correlation
spear <- cor.test(ggplot_exam_data2$PVol, ggplot_exam_data2$TVol, method = "spearman")

spear

# Setting up for the plot
dat <- read_tsv(here("data","ggplot_exam_data_2025-09-10.txt")) %>%
  select(PVol, TVol) %>%
  filter(is.finite(PVol), is.finite(TVol), PVol > 0) %>% # log10 trenger PVol > 0
  mutate(TVol = factor(TVol))

# boxplot and jitter
plot_2 <- ggplot(dat, aes(TVol, PVol)) +
  geom_boxplot(outlier.shape = NA) +
  geom_jitter(width = 0.15, alpha = 0.5, size = 1) +
  scale_y_log10() +
  labs(
    title = "PVol by TVol",
    x = "TVol (category)",
    y = "PVol (log10 scale)"
  ) +
  theme_minimal()

plot_2

# Adding Spearman correlation to the boxplot
sp <- cor.test(dat$PVol, as.numeric(dat$TVol), method = "spearman")
plot_2a <- plot_2 + annotate("text",
  x = Inf, y = Inf,
  label = sprintf(
    "Spearman rho = %.2f, p = %.3g",
    sp$estimate, sp$p.value
  ),
  hjust = 1.05, vjust = 1.5, size = 4
)

plot_2a

## Guri----
# Exercise: Does the distribution of `Preoperativte_PSA` differ by `Tumor_stage`? yes, see plot.
plot_3 <- ggplot(ggplot_exam_data, aes(x = factor(Tumor_stage), y = Preoperative_PSA)) +
  geom_boxplot(fill = "lightblue", color = "darkblue") +
  labs(
    title = "Distribution of Preoperative PSA by Tumor stage",
    x = "Tumor stage",
    y = "Preoperative PSA"
  ) +
  theme_minimal()
summary(ggplot_exam_data$Preoperative_PSA)
summary(ggplot_exam_data$Tumor_stage)

plot_3

# exercise: Does the distribution of `PVol` differ by `sGS`? Yes, see plot.
plot_4 <- ggplot(ggplot_exam_data, aes(x = factor(sGS), y = PVol)) +
  geom_boxplot(fill = "lightblue", color = "darkblue") +
  labs(
    title = "Distribution of Prostate Volume by Surgical Gleason score",
    x = "Surgical Gleason Score",
    y = "Prostate Volume"
  ) +
  theme_minimal()

plot_4


summary(ggplot_exam_data$PVol)
summary(ggplot_exam_data$sGS)

# Does the distribution of `TVol` differ by `sGS`? Yes.See plot.
plot_5 <- ggplot(ggplot_exam_data, aes(x = factor(sGS), y = TVol)) +
  geom_boxplot(fill = "lightblue", color = "darkblue") +
  labs(
    title = "Distribution of Tumor Volume by Surgical Gleason score",
    x = "Surgical Gleason Score",
    y = "Tumor Volume"
  ) +
  theme_minimal()

plot_5

summary(ggplot_exam_data$TVol)
summary(ggplot_exam_data$sGS)



# Does the distribution of `TVol` differ by `sGS`?
# both TVOl and sGs are categorical, not continues variables,therefor choosing grouped bar plot for this task.
# there are quite a few NA for postopr gleasonscore ( is it like this in real life?), so I choose to keep the values.

plot_5b <- ggplot_exam_data %>%
  ggplot(aes(x = factor(TVol), fill = factor(sGS))) +
  geom_bar(position = "dodge") +
  labs(
    title = "Distribution of Tumor volume by Gleason score",
    x = "Tumor volume",
    y = "Number of patients",
    fill = "sGS (postoperative Gleason score)"
  ) +
  theme_minimal()

plot_5b

## JP----
# Task: Where there more `T.Stage == 2` in the group with `PreopTherapy == 1` than in the group `PreopTherapy == 0`?


plot_6_1 <- ggplot_exam_data %>%
  mutate(Preoperative_therapy2 = if_else(Preoperative_therapy == "0", "No", "Yes")) %>%
  filter(Tumor_stage == 2) %>%
  ggplot(aes(Preoperative_therapy2)) +
  geom_bar(width = 0.3, fill = "darkblue")
plot_6_1

plot_6_2 <- plot_6_1 +
  xlab("Preoperative therapy") +
  ylab("Number of patients") +
  labs(
    title = "Number of patients with tumor stage 2",
    subtitle = "stratified by preoperative therapy groups"
  )

plot_6_2

plot_6 <- plot_6_2 +
  theme(
    plot.title = element_text(
      size = 20,
      face = "bold"
    )
  ) +
  theme_minimal()

plot_6
