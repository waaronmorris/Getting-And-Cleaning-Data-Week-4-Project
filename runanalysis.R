setwd("~/Coursera/Getting and Cleaning Data/Assignment 4")

##Load Libraries
library(plyr) 
library(data.table)
library(dplyr)

##Load Files
y_test <- read.table("data/test/y_test.txt", header = FALSE)
x_test <- read.table("data/test/X_test.txt", header = FALSE)
subject_test <- read.table("data/test/subject_test.txt", header = FALSE)
y_train <- read.table("data/train/y_train.txt", header = FALSE)
x_train <- read.table("data/train/X_train.txt", header = FALSE)
subject_train <- read.table("data/train/subject_train.txt", header = FALSE)
features <- read.table("data/features.txt", header = FALSE)
activity <- read.table("data/activity_labels.txt", header = FALSE)

## Merge Training and Test Sets

subject <- rbind(subject_train, subject_test)
x <- rbind(x_train, x_test)
y <- rbind(y_train, y_test)

##Rename Columns to the features provided via the dataset 
colnames(x) <- features[, 2]
required <- grep(".*Mean.*|.*Std.*", colnames(x), ignore.case=TRUE)
required <- c(required)
x <- x[, required]

##Remove Acronyms after shorting columns
colnames(x)<-gsub("Acc", "Accelerometer", colnames(x), ignore.case = TRUE)
colnames(x)<-gsub("Gyro", "Gyroscope", colnames(x), ignore.case = TRUE)
colnames(x)<-gsub("BodyBody", "Body", colnames(x), ignore.case = TRUE)
colnames(x)<-gsub("Mag", "Magnitude", colnames(all), ignore.case = TRUE)
colnames(x)<-gsub("^t", "Time", colnames(x), ignore.case = TRUE)
colnames(x)<-gsub("^f", "Frequency", colnames(x), ignore.case = TRUE)
colnames(x)<-gsub("tBody", "TimeBody", colnames(x), ignore.case = TRUE)
colnames(x)<-gsub("-mean()", "Mean", colnames(x), ignore.case = TRUE)
colnames(x)<-gsub("-std()", "STD", colnames(x), ignore.case = TRUE)
colnames(x)<-gsub("-freq()", "Frequency", colnames(x), ignore.case = TRUE)
colnames(x)<-gsub("angle", "Angle", colnames(x), ignore.case = TRUE)
colnames(x)<-gsub("gravity", "Gravity", colnames(x), ignore.case = TRUE)

##Merge the Activity Number with the Activity
activity <- merge(y, activity, by.x = "V1", by.y = "V1")[,2] 

## Descriptive Variable Names
colnames(subject)[1] <- "subject"
activity <- activity[,2]


##Create One Dataset
all <- cbind(x, activity, subject)

#convert to data table for easier summary
all <- data.table(all)

summary <- all[, lapply(.SD, mean), by = 'subject,activity']

## Write new file
write.table(summary, file = "summary.txt", row.names = TRUE)