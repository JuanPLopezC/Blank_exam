# Blank_exam
Exam for RMED 2025 - Group Blank

Folders inside this project:

MIT licence

Questions:
-these are the questions for the exam
-exam.descr.md


Data:
-3 datafiles were given
--codebook_exam_data.html
--exam_datapt_join.txt
--exam_data.txt

- 4 datafiles were made thorugh the workingprosess
--tidy_exam_data_2025-09-08.txt
--tidy_exam_data_2025-09-09.txt
--joint_exam-data_2025-09-09.txt
--ggplot_exam_data_2025-09-10.tx


Scripts:
-


Results: 

Data cleaning 08.09.25
- Separeted column subject to hosp and ID
- Removed 40 duplicates in the dataset --> from 672 to 632
- Renamed column names 
- Committed and pushed into main script 
- Deleted our own branches


Tidying the data 
#08.09.25 
  - Transformed "ID" column from categorical to numerical 
  - Creating a "data_clean"" vector containing all of our changes 
  - Making a new file with the tidied data named: Tidy_exam_data.txt
#09.09.25
  - tidying the data trough splitting column: "volume.measurement" splitting columms PVol and making a new "Pvol high/low column"
  - Conducting the following task: Set the order of columns:id, hospital, age and other columns
  - And this task: Arrange ID column of your dataset in order of increasing number or alphabetically.
#10.09.25
  - Making a new datafile ready for ggplot: ggplot_exam_data_2025-09-10.txt
  - Dividing exercises from task 4 among the group
  - Conducting the exercises from task 4
  - Starting with task 5
#11.09.25 
  - Continuing and finishing work on task 5 among the group
  - Creating a new script for this task
  - Created a new file called:Codebook_updated_2025_11_09.txt


Task 3 (Anders)
#08.09.25
  - Created a column showing whether Pvol was hi gher than 100 or not: values High/Low - High is defined as a value over 100 
  - Created a column showing the "time to recccurance" in days
  - Tidying this two new columns trough removing decimals and rearanging order
#10.09.25
  - fixing error on time to reccurance_days column - making new ones with correct values
  - conducting the task: "explore and comment on the missing variables"
  Comment on the missing variables in the dataset: missing data - nine variables contained missing values (N/A): Tumorstage (13/316), PVol (9/316), Pvol_HighLow (9/316), TVol (6/316), Preoperative_PSA (3/316), TimeToReccurance(1/316) TimeToReccurance_days_new (1/316),TimeToReccurance_weeks_new (1/316), ttr_num (1/316)

 

 