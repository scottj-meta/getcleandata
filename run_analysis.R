# Getting and Cleaning Data Course Project
# August 2015

# load libraries

library(plyr)

# get the data, put in local ./data subdir
dir_name <- file.path("./data" , "UCI HAR Dataset")

if(!file.exists(dir_name)){
  
  if(!file.exists("./data")){dir.create("./data")}
  fileUrl <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
  download.file(fileUrl,destfile="./data/Dataset.zip",method="curl")
  unzip(zipfile="./data/Dataset.zip",exdir="./data")
}

#note that if you re-run this code, you should reset working directory to default
setwd(dir_name)

# load files for subject_test and _train data, assign to tables

sub_test <- read.table("./test/subject_test.txt", header=FALSE)
sub_train <- read.table("./train/subject_train.txt", header=FALSE)

# load files for x test and train, and y test and train

x_test <- read.table("./test/X_test.txt", header=FALSE)
x_train <- read.table("./train/X_train.txt", header=FALSE)
y_test <- read.table("./test/y_test.txt", header=FALSE)
y_train <- read.table("./train/y_train.txt", header=FALSE)


# cbine like information, rbind train and test and assign column ids

names(sub_train) <- "Subject_ID"
names(sub_test) <- "Subject_ID"
names(y_test) <- "Activity"
names(y_train) <- "Activity"
feature_col <- read.table("features.txt")
names(x_train) <- feature_col$V2
names(x_test) <- feature_col$V2

all_train <- cbind(sub_train, y_train, x_train)
all_test <- cbind(sub_test, y_test, x_test)
all_entries <- rbind(all_train, all_test)

# Extract measurements for mean and stdev from the all_entries table

means_std <- feature_col$V2[grep("mean\\(\\)|std\\(\\)", feature_col$V2)]
criteria <- c(as.character(means_std), "Subject_ID", "Activity")
all_entries <- subset(all_entries, select = criteria)


# convert Activity from integer to label, using factor, referenced activity_labels.txt for values

all_entries$Activity <- factor(all_entries$Activity, labels=c("Walking", "Walking Upstairs", "Walking Downstairs", "Sitting", "Standing", "Laying"))

# Change variable names, clean up a bit

names(all_entries) <- gsub("^t", "time_", names(all_entries))
names(all_entries) <- gsub("^f", "frequency_", names(all_entries))
names(all_entries) <- gsub("BodyAcc", "Body_Acceleration", names(all_entries))
names(all_entries) <- gsub("GravityAcc", "Gravity_Acceleration", names(all_entries))
names(all_entries) <- gsub("BodyAccJerk", "Body_Acceleration_Jerk", names(all_entries))
names(all_entries) <- gsub("BodyGyro", "Body_Gyroscope", names(all_entries))
names(all_entries) <- gsub("BodyGyroJerk", "Body_Gyroscope_Jerk", names(all_entries))
names(all_entries) <- gsub("BodyAccMag", "Body_Acceleration_Magnitude", names(all_entries))
names(all_entries) <- gsub("BodyAccJerkMag", "Body_Acceleration_Jerk_Magnitude", names(all_entries))
names(all_entries) <- gsub("BodyGyroMag", "Body_Gyroscope_Magnitude", names(all_entries))
names(all_entries) <- gsub("BodyGyroJerkMag", "Body_Gyroscope_Jerk_Magnitude", names(all_entries))
names(all_entries) <- gsub("BodyBody", "Body", names(all_entries))
names(all_entries) <- gsub("-X", "", names(all_entries))
names(all_entries) <- gsub("-Y", "", names(all_entries))
names(all_entries) <- gsub("-Z", "", names(all_entries))

# A second tidy dataset with the average of each variable for each activity and each subject
tidy_output <- ddply(all_entries, c("Subject_ID", "Activity"), numcolwise(mean))
write.table(tidy_output, file="tidy_output.txt", row.names=FALSE)



