#0 Prepare for Data
Url <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
File <- "ProjectDataset.zip"

if (!file.exists(File)) {
  download.file(Url, File, mode = "wb")
}


# unzip zip file
dataPath <- "UCI HAR Dataset"
if (!file.exists(dataPath)) {
  unzip(zipFile)
}

#Prepare dplyr package
install.packages("dplyr")
library(dplyr)

#Read features and Activities labels(no need to change your work directory)
features <- read.table(file.path(dataPath, "features.txt"), as.is = TRUE)
activities <- read.table(file.path(dataPath, "activity_labels.txt"))
colnames(activities) <- c("activityId", "activityLabel")

#read train data(no need to change your work directory)
trainingSubjects <- read.table(file.path(dataPath, "train", "subject_train.txt"))
trainingValues <- read.table(file.path(dataPath, "train", "X_train.txt"))
trainingActivity <- read.table(file.path(dataPath, "train", "y_train.txt"))

#read test data(no need to change your work directory)
testSubjects <- read.table(file.path(dataPath, "test", "subject_test.txt"))
testValues <- read.table(file.path(dataPath, "test", "X_test.txt"))
testActivity <- read.table(file.path(dataPath, "test", "y_test.txt"))


#Step 1 Merges the training and the test sets to create one data set
CompleteData <- rbind(
  cbind(trainingSubjects, trainingValues, trainingActivity),
  cbind(testSubjects, testValues, testActivity)
)


#Step 2 Extracts only the measurements on the mean and standard deviation for each measurement.
colnames(CompleteData) <- c("subject", features[, 2], "activity")
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
ColNames <- gsub("mean", "Mean", ColNames)
ColNames <- gsub("std", "StandardDeviation", ColNames)
ColNames <- gsub("BodyBody", "Body", ColNames)
#Finish and store new names
colnames(CompleteData)<-ColNames

#step5 From the data set in step 4, creates a second,
#independent tidy data set with the average of each variable for each activity and each subject.

Sec_Means<-CompleteData %>% group_by(subject, activity) %>% summarise_each(funs(mean))
 names(Sec_Means)
#Write to "Second_tidy_data.txt"

write.table(Sec_Means, "Sec_tidy_data.txt",row.name=FALSE,quote=FALSE )

#All steps are done



