The run_analysis.R script performs a data tidying process on the dataset provided.

First download the dataset
Dataset was downloaded and extracted under the file/folder called UCI HAR Dataset

Variables were assigned to each data
features <- features.txt : 561 rows, 2 columns
The features selected for this database come from the accelerometer and gyroscope 3-axial raw signals tAcc-XYZ and tGyro-XYZ.
activities <- activity_labels.txt : 6 rows, 2 columns
List of activities performed when the corresponding measurements were taken and its codes (labels)
subject_test <- test/subject_test.txt : 2947 rows, 1 column
contains test data of 9/30 volunteer test subjects being observed
x_test <- test/X_test.txt : 2947 rows, 561 columns
contains recorded features test data
y_test <- test/y_test.txt : 2947 rows, 1 columns
contains test data of activities’code labels
subject_train <- test/subject_train.txt : 7352 rows, 1 column
contains train data of 21/30 volunteer subjects being observed
x_train <- test/X_train.txt : 7352 rows, 561 columns
contains recorded features train data
y_train <- test/y_train.txt : 7352 rows, 1 columns
contains train data of activities’code labels

Merged the training and the test sets to create one data set
A X dataset of 10299 rows and 561 columns was created by merging x_train and x_test using rbind() function
A Y dataset of 10299 rows and 1 column was created by merging y_train and y_test using rbind() function
A Subject dataset of 10299 rows and 1 column was created by merging subject_train and subject_test using rbind() function
A Merged_Data dataset of 10299 rows and 563 column was created by merging Subject, Y and X using cbind() function

Only the measurements on the mean and standard deviation for each measurement was extracted
A TidyData dataset of 10299 rows, 88 columns was created by subsetting Merged_Data, selecting only columns: subject, code 
and the measurements on the mean and standard deviation (std) for each measurement

Used descriptive activity names to name the activities in the data set
Numbers in code column of the TidyData was replaced with corresponding activity taken from second column of the activities variable

Appropriately labels the data set with descriptive variable names
code column in TidyData renamed into activities
All Acc in column’s name was replaced by Accelerometer
All Gyro in column’s name was replaced by Gyroscope
All BodyBody in column’s was name replaced by Body
All Mag in column’s name was replaced by Magnitude
All start with character f in column’s name was replaced by Frequency
All start with character t in column’s name was replaced by Time

From the data set above create a second, independent tidy data set with the average of each variable for each activity and each subject
FinalData dataset of 180 rows, 88 columns was created by sumarizing TidyData taking the means of each variable for each activity and each subject, 
after groupped by subject and activity.

Finally export FinalData into FinalData.txt file.
