##Introduction
The run\_analysis.R code produce a file of average features for each subject and each activity of the given data set.
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
###Data file names
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

###Data
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
