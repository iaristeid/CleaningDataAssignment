################################################################################
## Getting and Cleaning Data Coursera Course Peer Assessments Project
## www.coursera.org
##
## You should create one R script called run_analysis.R that does the following.
## 1. Merges the training and the test sets to create one data set.
## 2. Extracts only the measurements on the mean and standard deviation for each
##    measurement. 
## 3. Uses descriptive activity names to name the activities in the data set
## 4. Appropriately labels the data set with descriptive activity names. 
## 5. Creates a second, independent tidy data set with the average of each
##    variable for each activity and each subject. 
################################################################################

################################################################################
## Load Features List and Activity Labels
################################################################################

features <- read.table("./features.txt",sep="",)
activity_labels <- read.table("./activity_labels.txt", sep="", header=FALSE)

################################################################################
## Load Test Data and Update Column Names
################################################################################

X_test <- read.table("./test/X_test.txt", sep="", header=FALSE)
y_test <- read.table("./test/y_test.txt", sep="", header=FALSE)
subject_test <- read.table("./test/subject_test.txt", sep="", header=FALSE)
names(X_test)=features[,2]
names(subject_test)="subject"
y_test_label <- merge(y_test,activity_labels,by.x="V1",by.y="V1")
names(y_test_label)=c("activityId","activityLabel")

################################################################################
## Load Train Data and Update Column Names
################################################################################

X_train <- read.table("./train/X_train.txt", sep="", header=FALSE)
y_train <- read.table("./train/y_train.txt", sep="", header=FALSE)
subject_train <- read.table("./train/subject_train.txt", sep="", header=FALSE)
names(X_train)=features[,2]
names(subject_train)="subject"
y_train_label <- merge(y_train,activity_labels,by.x="V1",by.y="V1")
names(y_train_label) =c("activityId","activityLabel")

################################################################################
## Merge Train and Test Data sets
################################################################################

global_test=cbind(subject_test,y_test_label,X_test)
global_train=cbind(subject_train,y_train_label,X_train) 
total <- rbind(global_test,global_train)
df.union <- unique(total) 

################################################################################
## Select mean and std values and write into tidy_data_1.txt
################################################################################

union <-df.union[, c(1, 3, grep("std", names(df.union)), grep("mean", names(df.union)))]
write.table(union, "tidy_data_1.txt", sep=";", row.names=FALSE) 

################################################################################
## Create a second, independent tidy data set with the average of each
## variable for each activity and each subject. 
################################################################################
# load plyr package
library(plyr)

# apply column means function to data subsetted by subject and activity label
tidy_2 <- ddply(union, .(subject, activityLabel), .fun=function(x){ colMeans(x[,-c(1:2)]) })
summary(tidy_2)
# write tidy data with means by subject and activity to text file,
# columns seperated by ";"
write.table(tidy_2, "tidy_data_2.txt", sep=";", row.names=FALSE)

