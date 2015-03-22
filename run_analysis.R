library(plyr)

#Question 1 - merge the test and train data to merge into one data set resp.

#Read the Test Data into a table and store in a variable

XTest_Data <- read.table("./Test/X_test.txt")
YTest_Data <- read.table("Test/y_test.txt")
Subject_Test_Data <- read.table("Test/subject_test.txt")

#Read the Train Data into a table and store in a variable

XTrain_Data <- read.table("./Train/X_Train.txt")
YTrain_Data <- read.table("Train/Y_Train.txt")
Subject_Train_Data <- read.table("Train/subject_train.txt")

#Merge the Train and Test data sets and store in a variable

XData_Set <- rbind(XTrain_Data,XTest_Data)
YData_Set <- rbind(YTrain_Data,YTest_Data)
Sub_Test_Set <- rbind(Subject_Train_Data,Subject_Test_Data)

# Question 2 - Read the features data into a table and extract only the measurements on the mean and standard deviation for each measurement 

Feature_Data <- read.table("features.txt") 

Mean_std_Data <- grep("(mean|std)\\(", Feature_Data[, 2])

#head(XData_Set,n=10)

# extract the data using the row numbers of matching pattern of mean or std
XData_Set <- XData_Set[, Mean_std_Data] 

# cleanup the column names by removing "()" and rename the column names of the merged data  
names(XData_Set) <- gsub("(\\()(\\))", "", Feature_Data[Mean_std_Data, 2]) 

# Question 3 Use descriptive activity names to name the activities in the data set 

#read the activity labels data into a table
Activity_Type_Data <- read.table("activity_labels.txt") 

# update values in the Y data set with correct activity names using the activity Type data 
YData_Set[, 1] <- Activity_Type_Data[YData_Set[, 1], 2] 


# Question 4 Appropriately label the data set with descriptive variable names 

# update column name of the Subject test data set to reflect a more meaningful description
names(Sub_Test_Set) <- "Subject_Num" 

# update the column name of the Y Train and Test data set to reflect a more meaningful description
names(YData_Set) <- "Activity_Type" 

# merge all the data into a single data set 

Merged_Data <- cbind(XData_Set,Sub_Test_Set, YData_Set) 


# Question 5- From the data set, creates a second independent tidy data set with the average of each variable for each activity and each subject

# function to calculate the average
mean_df <- function(x) colMeans(x[, 1:66])
 
#calculate the average of each variable for each activity and each subject
Tidy_average_Data <- ddply(Merged_Data, .(Activity_Type,Subject_Num), mean_df)

# create a data set as a txt file created with write.table() using row.name=FALSE
write.table(Tidy_Data, "Tidy_average_Data.txt", row.name=FALSE) 

