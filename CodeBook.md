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

#More Information

The experiments have been carried out with a group of 30 volunteers within an age bracket of 19-48 years. Each person performed six activities (WALKING, WALKING_UPSTAIRS, WALKING_DOWNSTAIRS, SITTING, STANDING, LAYING) wearing a smartphone (Samsung Galaxy S II) on the waist. Using its embedded accelerometer and gyroscope, we captured 3-axial linear acceleration and 3-axial angular velocity at a constant rate of 50Hz. The experiments have been video-recorded to label the data manually. The obtained dataset has been randomly partitioned into two sets, where 70% of the volunteers was selected for generating the training data and 30% the test data. 

The sensor signals (accelerometer and gyroscope) were pre-processed by applying noise filters and then sampled in fixed-width sliding windows of 2.56 sec and 50% overlap (128 readings/window). The sensor acceleration signal, which has gravitational and body motion components, was separated using a Butterworth low-pass filter into body acceleration and gravity. The gravitational force is assumed to have only low frequency components, therefore a filter with 0.3 Hz cutoff frequency was used. From each window, a vector of features was obtained by calculating variables from the time and frequency domain. See 'features_info.txt' for more details. 
