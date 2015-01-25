# GCDproject
Getting and Cleaning Data course project

This code summarize wearable computing data collected from the accelerometers from the Samsung Galaxy S smartphone.  The data can be found here:
https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip

and its full description here:
http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones

This code is all containted in the file "run\_analysis.R" which defines a function named "run\_analysis".
Calling the function "run_analysis()" creates a text file with the average for each variable and each activity and each subject.

First, the training and test sets are merged into one data set.
Then only the measurements on the mean and standard deviation for each measurement are written in output file.
The format of the output is "long and skinny" where each line contains the average of one variable-activity-subject combination.
