#Data

1.Using downfile() function to get zipfile,and unzip zipfile.

2.Read raw data into R by read.table() function.

For example: X_test<-read.table("X_test.txt")

3.Merges the training and the test sets to create one data set.

Using cbind() to merge train data to a complete one,
as test data too. Using rbind() to merge train and test data together.

4.Extracts only the measurements on the mean and standard deviation for each measurement. By using grepl() to
select the col names required.(grepl() need to library dplyr package) 

5.Uses descriptive activity names to name the activities in the data set.

Setting levels and labels by using factor()
There are six activities in "activity_labels.txt"

6.Appropriately labels the data set with descriptive variable names.

Change some names into more descriptive names. For example: "Acc" -> "Accelerometer"

7.From the data set in step 4, creates a second,
independent tidy data set with the average of each variable for each activity and each subject.

Using Group_by() to group second dataset by "subject" and "activity", summarise_each() can get the 
average of each variable.%>%m expression makes it more handy.

8.Write the second dataset into text file.("Second_tidy_data.txt")


