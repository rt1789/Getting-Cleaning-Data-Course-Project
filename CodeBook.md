Title: CodeBook.md
Author: Rajini Thummala
Date: March 21, 2015

Data Set Information:
The experiments have been carried out with a group of 30 volunteers within an age bracket of 19-48 years. Each person performed 
six activities (WALKING, WALKING_UPSTAIRS, WALKING_DOWNSTAIRS, SITTING, STANDING, LAYING) wearing a smartphone (Samsung Galaxy S II)
on the waist. Using its embedded accelerometer and gyroscope, we captured 3-axial linear acceleration and 3-axial angular velocity 
at a constant rate of 50Hz. The experiments have been video-recorded to label the data manually. The obtained dataset has been
randomly partitioned into two sets, where 70% of the volunteers was selected for generating the training data and 30% the test data.


The sensor signals (accelerometer and gyroscope) were pre-processed by applying noise filters and then sampled 
in fixed-width sliding windows of 2.56 sec and 50% overlap (128 readings/window). The sensor acceleration signal, which has
gravitational and body motion components, was separated using a Butterworth low-pass filter into body acceleration and gravity. 
The gravitational force is assumed to have only low frequency components, therefore a filter with 0.3 Hz cutoff frequency was used.
From each window, a vector of features was obtained by calculating variables from the time and frequency domain.

Raw Data: Input data is avaialble for download at the folliwing link:
https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip 

For each record in the dataset it is provided:
- Triaxial acceleration from the accelerometer (total acceleration) and the estimated body acceleration.
- Triaxial Angular velocity from the gyroscope.
- A 561-feature vector with time and frequency domain variables.
- Its activity label.
- An identifier of the subject who carried out the experiment. 

Download the data and store it on the local drive, uncompress or extract the data. The goal of the R script is to do the following:

   1. Merges the training and the test sets to create one data set.
   2. Extracts only the measurements on the mean and standard deviation for each measurement. 
   3. Uses descriptive activity names to name the activities in the data set
   4.Appropriately labels the data set with descriptive variable names. 
   5.From the data set in step 4, creates a second, independent tidy data set with the average of each variable for 
    each activity and each subject.


Processed data: run_analysis.R script assumes that the working directory is set to the folder which contains the test, train folders
and files activity_labels and feaures.txt files.

R script contains the following steps:
1. Reads the X, Y and Subject Test data into its own data table each respectively.
2. Merges the X, Y and Subject Train data into own data table
3. Merges the X Test, X Train into a single data table using rbind() to create a new table called XData_Set
4. Merges the Y test, y train into a single data table using rbind() to create a new table called YData_Set
5. Merges the subject test and subject Train data set to create a new table called Sub_Test_Set
6. Next it reads the features data into a table and extracts only the measurements on the mean and standard deviation 
   to create a new data set called Mean_std_Data
7. clean the data using gsub to give meaningful columns names and update the column names of XData_Set
8. Read the activity labels files and update the column names of the YData_Set, this provides a descriptive activity names
9. Merge the XData_Set, YData_Set and Sub_Test_Set to create a single data set
10.Apply the mean_df function which calculates the average of each variable for each activity and subject
11. using the ddply function and mean_df using group by by Activity and Subject to create a new Tidy average data set
12. using write.table(), create a data set as a txt file.  The name of this file is "Tidy_average_Data.txt".
