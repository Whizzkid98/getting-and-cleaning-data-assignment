## A demonstration of my ability  to collect, work with, and clean a data set.

# The code below will first check if the file directory exists and then
# the download.file command will download the files from the url provided

filename <- "getdata2project.zip"
if (!file.exists(filename)){
  fileURL <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
  download.file(fileURL, filename, method="curl")
}  



# This code will first check if the file exists and then unzip the file
# since it's a zip file

if (!file.exists("UCI HAR Dataset")) { 
  unzip(filename) 
}

# Below is an assignment of all data frames using the read.table command 
# And I covered the col.names parameter as well

features <- read.table("UCI HAR Dataset/features.txt", col.names = c("n","functions"))
activities <- read.table("UCI HAR Dataset/activity_labels.txt", col.names = c("code", "activity"))
subject_test <- read.table("UCI HAR Dataset/test/subject_test.txt", col.names = "subject")
x_test <- read.table("UCI HAR Dataset/test/X_test.txt", col.names = features$functions)
y_test <- read.table("UCI HAR Dataset/test/y_test.txt", col.names = "code")
subject_train <- read.table("UCI HAR Dataset/train/subject_train.txt", col.names = "subject")
x_train <- read.table("UCI HAR Dataset/train/X_train.txt", col.names = features$functions)
y_train <- read.table("UCI HAR Dataset/train/y_train.txt", col.names = "code")

#using both rbind and cbind to merge the dataset

X <- rbind(x_train, x_test)
Y <- rbind(y_train, y_test)
Subject <- rbind(subject_train, subject_test)
Merged_Data <- cbind(Subject, Y, X)

# The purpose of the code below is to extract the mean and standard deviation
# for each measurement
TidyData <- Merged_Data %>% select(subject, code, contains("mean"), contains("std"))

#naming the activities in the dataset
TidyData$code <- activities[TidyData$code, 2]

# labelling the data set with descriptive variable names.
names(TidyData)[2] = "activity"
names(TidyData)<-gsub("Acc", "Accelerometer", names(TidyData))
names(TidyData)<-gsub("Gyro", "Gyroscope", names(TidyData))
names(TidyData)<-gsub("BodyBody", "Body", names(TidyData))
names(TidyData)<-gsub("Mag", "Magnitude", names(TidyData))
names(TidyData)<-gsub("^t", "Time", names(TidyData))
names(TidyData)<-gsub("^f", "Frequency", names(TidyData))
names(TidyData)<-gsub("tBody", "TimeBody", names(TidyData))
names(TidyData)<-gsub("-mean()", "Mean", names(TidyData), ignore.case = TRUE)
names(TidyData)<-gsub("-std()", "STD", names(TidyData), ignore.case = TRUE)
names(TidyData)<-gsub("-freq()", "Frequency", names(TidyData), ignore.case = TRUE)
names(TidyData)<-gsub("angle", "Angle", names(TidyData))
names(TidyData)<-gsub("gravity", "Gravity", names(TidyData))

# creating a second, independent tidy data from the  dataset above

FinalData <- TidyData %>%
  group_by(subject, activity) %>%
  summarise_all(funs(mean))

# Using the write.table command to turn the FinalData into a text file

write.table(FinalData, "FinalData.txt", row.name=FALSE)
