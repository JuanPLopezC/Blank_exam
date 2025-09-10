# Blank_exam
Exam for RMED 2025 - Group Blank


This contains the work we do to answer to the questions for the exam

Folders inside this project:

questions:
-these are the questions for the exam
-exam.descr.md


Scripts
-Script_firstday_05.09.2025. 
the variable subject contains hospital 1-3 + ID nr( 2/4)
Start by splitting subject-> Hosp and ID
We probably need to.  


data:
-this one has the 3 datafiles that we were given
--codebook_exam_data.html
<<<<<<< HEAD
--exam_datapt_join.txt
--exam_data.txt
=======
--exam_data_join.txt
--exam_data.txt

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
- Merging the exam_data_join to the tidy_exam_data
#10.09.25
- Making new timetoreccurance columns - fixing errors from previous days
- Renaming hosp columns
- dividing exercises from task 3 among the group


Task 3 (Anders)
#08.09.25
  - Created a column showing whether Pvol was higher than 100 or not: values High/Low - High is defined as a value over 100 
  - Created a column showing the "time to recccurance" in days
  - Tidying this two new columns trough removing decimals and rearanging order
#10.09.25
- fixing error on time to reccurance_days column - making new ones with correct values
- conducting the exercise: "explore and comment on the missing variables"
  Answer --> Comment on the missing variables in the dataset: missing data - nine variables contained missing values (N/A): Tumorstage (13/316), PVol (9/316), Pvol_HighLow (9/316), TVol (6/316), Preoperative_PSA (3/316), TimeToReccurance(1/316) TimeToReccurance_days_new (1/316),TimeToReccurance_weeks_new (1/316), ttr_num (1/316)
- conducting the exercise: Stratify your data by a categorical column and report min, max, mean and sd of a numeric column.
- conducting the exercise: Use two categorical columns in your dataset to create a table (either with
  `table()`, `count()`, or `janitor::tabyl()`)
 

 