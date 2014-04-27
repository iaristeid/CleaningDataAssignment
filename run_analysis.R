features <- read.table("./features.txt",sep=" ",header=FALSE)
activity_labels <- read.table("./activity_labels.txt", sep=" ", header=FALSE)
X_test <- read.table("./test/X_test.txt", sep=" ", header=FALSE)
y_test <- read.table("./test/y_test.txt", sep=" ", header=FALSE)
subject_test <- read.table("./test/subject_test.txt", sep=" ", header=FALSE)
names(X_test)=features[,2]
names(subject_test)="subject"
merge(y_test,activity_labels,by.x="V1",by.y="V1")
y_test_label <- merge(y_test,activity_labels,by.x="V1",by.y="V1")
names(y_test_label)=c("activityId","activityLabel")
X_train <- read.table("./train/X_train.txt", sep=" ", header=FALSE)
y_train <- read.table("./train/y_train.txt", sep=" ", header=FALSE)
subject_train <- read.table("./train/subject_train.txt", sep=" ", header=FALSE)
names(X_train)=features[,2]
names(subject_train)="subject"
y_train_label <- merge(y_train,activity_labels,by.x="V1",by.y="V1")
names(y_train_label) =c("activityId","activityLabel")
global_test=cbind(subject_test,y_test_label,X_test)
global_train=cbind(subject_train,y_train_label,X_train) 
total <- rbind(global_test,global_train)
df.union <- unique(total) 
myvars1 <- names(total) %in% c("subject","activityLabel","tBodyAcc-mean()-X","tBodyAcc-mean()-Y","tBodyAcc-mean()-Z","tBodyAcc-std()-X","tBodyAcc-std()-Y","tBodyAcc-std()-Z")
myvars2 <- names(total) %in% c("subject","activityLabel","tGravityAcc-mean()-X","tGravityAcc-mean()-Y","tGravityAcc-mean()-Z","tGravityAcc-std()-X","tGravityAcc-std()-Y","tGravityAcc-std()-Z") 
union1 <-df.union[myvars1]
union2 <-df.union[myvars2]
write.csv(union1,"bodyAcc.csv")
write.csv(union2,"GravityAcc.csv") 
