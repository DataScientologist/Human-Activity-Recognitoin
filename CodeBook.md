
CODEBOOK

Getting and Cleaning Data Course Project

SOURCE DATA - http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones

Data Description:
The experiments have been carried out with a group of 30 volunteers within an age bracket of 19-48 years. Each person performed six activities (WALKING, WALKING_UPSTAIRS, WALKING_DOWNSTAIRS, SITTING, STANDING, LAYING) wearing a smartphone (Samsung Galaxy S II) on the waist. Using its embedded accelerometer and gyroscope, we captured 3-axial linear acceleration and 3-axial angular velocity at a constant rate of 50Hz. The experiments have been video-recorded to label the data manually. The obtained dataset has been randomly partitioned into two sets, where 70% of the volunteers was selected for generating the training data and 30% the test data. 

The sensor signals (accelerometer and gyroscope) were pre-processed by applying noise filters and then sampled in fixed-width sliding windows of 2.56 sec and 50% overlap (128 readings/window). The sensor acceleration signal, which has gravitational and body motion components, was separated using a Butterworth low-pass filter into body acceleration and gravity. The gravitational force is assumed to have only low frequency components, therefore a filter with 0.3 Hz cutoff frequency was used. From each window, a vector of features was obtained by calculating variables from the time and frequency domain.

Full Detail: http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones


PROCESS

1) Merges the training and the test sets to create one data set.

Merged datasets in to single element "Data"
  Y_test.txt
  Y_train.txt
  X_test.txt
  X_train.txt
  subject_train.txt
  subject_test.txt



2) Extracts only the measurements on the mean and standard deviation for each measurement.

From the merged data extract only columns that contain "Mean()" or "std()"

3) Uses descriptive activity names to name the activities in the data set

Update Activity_Id with the descriptive names provided.
  1 WALKING
  2 WALKING_UPSTAIRS
  3 WALKING_DOWNSTAIRS
  4 SITTING
  5 STANDING
  6 LAYING

4)  Appropriately labels the data set with descriptive variable names.
change "t" to  "Time
change "f" to "Frequency"
change "Acc" to "Accelerometer"
change "Gyro" to "Gyroscope"
change "Mag" to "Magnitude"
change "BodyBody" to "Body"

5) From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.

exported tidy data set to "Tidy.txt"
