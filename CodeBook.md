##Introduction
The run\_analysis.R code produces a file of average features for each subject and each activity of the given data set ([described here](http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones)).
Here are the steps:
* Getting and cleaning (removing "-", "(", ")", "." and ",") the feature names
* Create a data frame with the train and test data set with column names cleaned above
* Merging subject and activity(labels) with their respective data sets (train or test)
* Merging test and train data frame with rbind
* keep only the features with mean and std (for standard deviation) in the data frame
* map the activity label with the activity name
* create a new data frame with the average of each variable for each activity and each subject using the ddply
* Make a long and skinny data frame to show one subject-activity-variable per row
* Tidy the data with reordering of the columns and ordering the rows
* Write the table in a text file named average.txt

##Variables
The definitions are devided into text output variables (produced by the code run\_analysis.R) and the variables inside the code.


###Output variables
* activity: Performed while recording data with phone (WALKING, WALKING\_UPSTAIRS, WALKING\_DOWNSTAIRS, SITTING, STANDING, LAYING)
* variable: From the phone's embedded accelerometer and gyroscope.  Comprise 3-axial linear acceleration and 3-axial angular velocity.  Only mean and standard deviation measurement names are included. For more information, see the features_info.txt in the UCI HAR Dataset directory.  The names have been modified to remove ("-", "(", ")", "." and ",").
* subject: Id for the 30 volunteers within an age bracket of 19-48 years
* average: Average to all the measurements for the given subject, activity and variable


###Code variables
* ffeatures: path to the file containing the feature names
* ftrain: path to the train data
* ftrain_labels: path to the activity labels for the train data
* ftrain_subjects: path to the subject id of the train data
* ftest: path to the test data
* ftest_labels: path to the activity labels for the test data
* ftest_subjects: path to the subject id of the test data
* factivities: path the the activity name corresponding to the activity labels
A description of the variables in the output are in the file feature_info.txt
(note that the characters "-", "(", ")", "." and "," have been removed from the names)
* df_names: feature names
* cnames: cleaned (removing "-", "(", ")", "." and ",") names for the feature
* df_train: data from made by reading ftrain
* df\_train\_labels: data from made by reading ftrain_labels
* df\_train\_subjects: data from made by reading ftrain_subjects
* df_test: data from made by reading ftest
* df\_test\_labels: data from made by reading ftest_labels
* df\_test\_subjects: data from made by reading ftest_subjects
* df\_full: rbind of df\_train and df_test
* vsummarynames: names of the mean and standard deviation features
* dfsummary: data frame subset of df\_full with only columns in vsummarynames
* df\_activities: data from made by reading factivities
* columns4tidy: columns names from dfsummary that will be used in the final data set
* df_avg: data frame with average of the columns columns4tidy from dfsummary grouped by activity and subject
