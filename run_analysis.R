# GOAL
# Merges the training and the test sets to create one data set.
# Extracts only the measurements on the mean and standard deviation for each measurement.
# Uses descriptive activity names to name the activities in the data set
# Appropriately labels the data set with descriptive variable names.
# From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.



#Setup

if(!file.exists("./data")){dir.create("./data")}
url <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
download.file(url,destfile="./data/Dataset.zip")

# Unzip the datafile
unzip(zipfile="./data/Dataset.zip",exdir="./data")


path <- file.path("./data" , "UCI HAR Dataset")
files<-list.files(path, recursive=TRUE)
files



#Read in relevant Data
ActivityTest  <- read.table(file.path(path, "test" , "Y_test.txt" ),header = FALSE)
ActivityTrain <- read.table(file.path(path, "train", "Y_train.txt"),header = FALSE)

SubjectTrain <- read.table(file.path(path, "train", "subject_train.txt"),header = FALSE)
SubjectTest  <- read.table(file.path(path, "test" , "subject_test.txt"),header = FALSE)

FeaturesTest  <- read.table(file.path(path, "test" , "X_test.txt" ),header = FALSE)
FeaturesTrain <- read.table(file.path(path, "train", "X_train.txt"),header = FALSE)



# Merges the training and the test sets to create one data set.


# Concatonate table rows
Subject <- rbind(SubjectTrain, SubjectTest)
Activity<- rbind(ActivityTrain, ActivityTest)
Features<- rbind(FeaturesTrain, FeaturesTest)

# Name the variables
names(Subject)<-c("subject")
names(Activity)<- c("activity")
FeaturesNames <- read.table(file.path(path, "features.txt"),head=FALSE)
names(Features)<- FeaturesNames$V2

# Merge Columns
SubjecTivity <- cbind(Subject, Activity)
Data <- cbind(Features, SubjecTivity)


# Extracts only the measurements on the mean and standard deviation for each measurement.

#subset features with stings  "Mean()" or "std()" in them
subsetFeaturesNames<-FeaturesNames$V2[grep("mean\\(\\)|std\\(\\)", FeaturesNames$V2)]

# Subset theNames
theNames<-c(as.character(subsetFeaturesNames), "subject", "activity" )
Data<-subset(Data,select=theNames)


# Uses descriptive activity names to name the activities in the data set
activityLabels <- read.table(file.path(path, "activity_labels.txt"),header = FALSE)

# Create column names for activity labels
colnames(activityLabels)<- c("activity","activityName")

#Merge column names with data
# This failed but will revisit this method. - data <- merge(x=Data, y=activityLabels, by="activityid")
Data$activity[Data$activity == 1] <- "Walking"
Data$activity[Data$activity == 2] <- "Walking Upstair"
Data$activity[Data$activity == 3] <- "Walking Downstairs"
Data$activity[Data$activity == 4] <- "Sitting"
Data$activity[Data$activity == 5] <- "Standing"
Data$activity[Data$activity == 6] <- "Laying"

# Appropriately labels the data set with descriptive variable names.

# Get the column names and make them unique
colnames <-colnames(data)
colnames <- make.names(colnames, unique=TRUE)

# Replace old column names with new
names(Data)<-gsub("^t", "Time", names(Data))
names(Data)<-gsub("^f", "Frequency", names(Data))
names(Data)<-gsub("Acc", "Accelerometer", names(Data))
names(Data)<-gsub("Gyro", "Gyroscope", names(Data))
names(Data)<-gsub("Mag", "Magnitude", names(Data))
names(Data)<-gsub("BodyBody", "Body", names(Data))


# From the data set in step 4, 
# creates a second, independent tidy data set with the average of each variable for each activity and each subject.

library(dplr)


# Create a datafram table (Dplyr)
tidy <- tbl_df(Data)

# Create unique column names, otherwise the summary will give errors
colnames(tidy) <- make.names(colnames(tidy) , unique=TRUE)

# Group the data by subject and activity
tidygroup <-group_by(tidy, subject, activity)

# Calculate the mean for all features using a Dplyr function
tidymean <- summarise_each(tidygroup, funs(mean))

# Reapply the clean column names
colnames(tidymean) <- Data

# Check the first 10 rows and 6 columns
tidymean[1:10, 1:6]


library(data.table)


Data.dt <- data.table(Data)
#This takes the mean of every column broken down by participants and activities
TidyData <- Data.dt[, lapply(SD, mean), by = 'subject,activity']
write.table(TidyData, file = "Tidy.txt", row.names = FALSE)

