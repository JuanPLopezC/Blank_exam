---
  title: Written Exam group blank
Group members: Juan P Lopez, Anders Mellbye and Guri Kringeland
Description: "Exam submission – Group Blank – R course for PhD students at Medical Faculty, Univ.of Bergen."
---
  
  
#tidying collum Hosp- deleting charakters and keeping the number. 
  tidy_exam_data <-tidy_exam_data %>%
  mutate(Hosp = gsub("Hosp", "", Hosp))%>%
  rename("Hospital" = "Hosp")

  