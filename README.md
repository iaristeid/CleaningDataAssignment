CleaningDataAssignment
======================
This is a guide to anyone who needs to execute my code for getting and cleaning data for coursera project.

## Input files

* Under subdirectories test and train: 
  * X_*.txt, 
  * subject_*.txt
  * y_*.txt


## Steps to be executed

* First I unzipped the data set directory "UCI HAR Dataset" under R data directory ("C:/Users/iari/Documents/R/data/UCI HAR Dataset")
* Then I editted files ./test/X_test.txt and ./train/X_train.txt in order to replace multiple spaces with single space (because I used it as table separator)
* Then I executed the script "run_analysis.R" which performs:
  * Per input directory: 
    * reads the input files into data frames
    * updates headers of X_* with feature names, subject_* with subjects, y_* with activityIId & activity name
    * joins all three datasets into one global dataset
  * unions test and train global datasets into a total dataset
  * removes duplicates
  * selects columns to include in two final datasets


## Output files

* Writes the two final datasets into csvs bodyAcc.csv and GravityAcc.csv
