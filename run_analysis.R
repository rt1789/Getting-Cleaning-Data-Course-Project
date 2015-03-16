library(plyr)

#Question 1 - merge the train and test set to merge into one data set

#Test Data
XTest_Data <- read.table("./Test/X_test.txt")
YTest_Data <- read.table("Test/y_test.txt")
Subject_Test_Data <- read.table("Test/subject_test.txt")

#Train Data
XTrain_Data <- read.table("./Train/X_Train.txt")
YTrain_Data <- read.table("Train/Y_Train.txt")
Subject_Train_Data <- read.table("Train/subject_train.txt")

#Merge the Train and Test data sets

XData_Set <- rbind(XTrain_Data,XTest_Data)
YData_Set <- rbind(YTrain_Data,YTest_Data)
Sub_Test_Set <- rbind(Subject_Train_Data,Subject_Test_Data)

# Question 2 Extract only the measurements on the mean and standard deviation for each measurement 

Feature_Data <- read.table("features.txt") 

# extract the columns with matching pattern of mean or std in the names 

Mean_std_Data <- grep("(mean|std)\\(", Feature_Data[, 2]) 

head(XData_Set,n=10)

# extract the columns with matching pattern of mean or std
XData_Set <- XData_Set[, Mean_std_Data] 

# rename the column names 
names(XData_Set) <- Feature_Data[Mean_std_Data, 2] 

# Question 3 Use descriptive activity names to name the activities in the data set 
############################################################################### 

Activity_Label_Data <- read.table("activity_labels.txt") 

# update values with correct activity names 
YData_Set[, 1] <- Activity_Label_Data[YData_Set[, 1], 2] 

# correct column name 
names(YData_Set) <- "Activity_Type" 

# Question 4 Appropriately label the data set with descriptive variable names 

# correct column name 
names(Sub_Test_Set) <- "Subject_Num" 

# merge all the data into a single data set 
Merged_Data <- cbind(XData_Set, YData_Set, Sub_Test_Set) 

# Question 5- From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject
 
Tidy_Data <- ddply(Merged_Data, .(Subject_Num, Activity_Type), function(x) colMeans(x[, 1:66])) 

write.table(Tidy_Data, "Tidy_Data.txt", row.name=FALSE) 

