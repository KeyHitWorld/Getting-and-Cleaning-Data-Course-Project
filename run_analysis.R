#0 Prepare for Data
Url <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
File <- "ProjectDataset.zip"

if (!file.exists(zipFile)) {
  download.file(Url, File, mode = "wb")
}

#Prepare dplyr package
install.packages("dplyr")
library(dplyr)

#Unzip zipfile
unzip(File)
dir()

Features<-read.table("features.txt")
Activities<-read.table("activity_labels.txt")

#You need to change your working directory to "~/test"
X_test<-read.table("X_test.txt")
y_test<-read.table("y_test.txt")
subject_test<-read.table("subject_test.txt")

#You need to change your working directory to "~/train"
subject_train<-read.table("subject_train.txt")
X_train<-read.table("X_train.txt")
y_train<-read.table("y_train.txt")


#Step 1 Merges the training and the test sets to create one data set
Traindata<-cbind(X_train,y_train,subject_train)
Testdata<-cbind(X_test,y_test,subject_test)
CompleteData<-rbind(Traindata,Testdata)


#Step 2 Extracts only the measurements on the mean and standard deviation for each measurement.
colnames(CompleteData) <- c("subject", Features[, 2], "activity")
#Keep the cols you need
columnsyouNeed <- grepl("subject|activity|mean|std", colnames(CompleteData))
CompleteData <- CompleteData[, columnsyouNeed]

#Step 3 Uses descriptive activity names to name the activities in the data set
CompleteData$activity <- factor(CompleteData$activity, levels = activities[, 1], labels = activities[, 2])

#Step 4 Appropriately labels the data set with descriptive variable names.
#Get col names
ColNames <- colnames(CompleteData)
#remove some characters
ColNames <- gsub("[\\(\\)-]", "", ColNames)

ColNames <- gsub("^f", "frequencyDomain", ColNames)
ColNames <- gsub("^t", "timeDomain", ColNames)
ColNames <- gsub("Acc", "Accelerometer", ColNames)
ColNames <- gsub("Gyro", "Gyroscope", ColNames)
ColNames <- gsub("Mag", "Magnitude", ColNames)
ColNames <- gsub("Freq", "Frequency", ColNames)

#Finish and store new names
colnames(CompleteData)<-ColNames

#step5 From the data set in step 4, creates a second,
#independent tidy data set with the average of each variable for each activity and each subject.

SecondMeans<-CompleteData %>% SecondMeans<-group_by(subject, activity) %>% summarise_each(funs(mean))

#Write to "Second_tidy_data.txt"

write.table(SecondMeans, "Second_tidy_data.txt")

#All steps are done



