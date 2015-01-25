run_analysis<-function(maxrows=-1){
    ##This functions creates a text file summary of the mean and std activities
    ##Argument maxrows is for testing with fewer rows (default -1 means all rows)
    library(plyr)
    library(reshape)
    
    ##Data file names
    ffeatures<-"UCI HAR Dataset/features.txt"
    ftrain<-"UCI HAR Dataset/train/X_train.txt"
    ftrain_labels<-"UCI HAR Dataset/train/y_train.txt"
    ftrain_subjects<-"UCI HAR Dataset/train/subject_train.txt"
    ftest<-"UCI HAR Dataset/test/X_test.txt"
    ftest_labels<-"UCI HAR Dataset/test/y_test.txt"
    ftest_subjects<-"UCI HAR Dataset/test/subject_test.txt"
    factivities<-"./UCI HAR Dataset/activity_labels.txt"
    
    ############################################################################
    #1.Merges the training and the test sets to create one data set.
    
    ##This will be used for the column names
    df_names<-read.table(ffeatures, col.names=c("id", "feature"))
    cnames<-as.vector(df_names$feature)
    ##Improving the names by removing annoying characters 
    cnames <- gsub("(", "", cnames, fixed = TRUE)
    cnames <- gsub(")", "", cnames, fixed = TRUE)
    cnames <- gsub(".", "", cnames, fixed = TRUE)
    cnames <- gsub("-", "", cnames, fixed = TRUE)
    cnames <- gsub(",", "to", cnames, fixed = TRUE)
    
    ##train set
    df_train<-read.table(ftrain, nrows=maxrows, col.names=cnames)
    df_train_labels<-read.table(ftrain_labels, nrows=maxrows)
    df_train_subjects<-read.table(ftrain_subjects, nrows=maxrows)
    
    
    #test set
    df_test<-read.table(ftest, nrows=maxrows, , col.names=cnames)
    df_test_labels<-read.table(ftest_labels, nrows=maxrows)
    df_test_subjects<-read.table(ftest_subjects, nrows=maxrows)
    
    
    #Combining subject and labels
    df_train$subject<-df_train_subjects[,1]
    df_test$subject<-df_test_subjects[,1]
    df_train$label<-df_train_labels[,1]
    df_test$label<-df_test_labels[,1]
    
    #merge
    df_full<- rbind(df_test, df_train)
    

    ############################################################################
    #2.Extracts only the measurements on the mean and standard deviation for each measurement.

    vsummarynames<-grep("Mean|mean|std|label|subject",colnames(df_full))
    dfsummary<-df_full[,vsummarynames]
    
    ############################################################################
    #3. Uses descriptive activity names to name the activities in the data set

    #According to the readme file, the activity names and lable are given in the 
    #activity_labels.txt
    df_activities<-read.table(factivities)
    dfsummary$activity<-df_activities[dfsummary$label,2]
    
    
    ############################################################################
    #4.Appropriately labels the data set with descriptive variable names.

    #The column names were already given in the previous steps

    
    ############################################################################
    #5. From the data set in step 4, creates a second, independent tidy data set 
    #   with the average of each variable for each activity and each subject.

    ##Get the all value columns
    columns4tidy<-names(dfsummary)
    columns4tidy<- columns4tidy[! columns4tidy %in% c("label", "activity", "subject")]
    
    ##Get the mean for all the activity,subject pairs
    df_avg<-ddply(dfsummary, .(activity, subject), function (x) colMeans(x[,columns4tidy]))
    
    ##Because there are so many variables, make tall and skinny
    df_avg<-melt(df_avg, id=c("activity", "subject"), measure.vars=columns4tidy)
    df_avg<-rename(df_avg, c("value"="average"))

    ##Order to make it more readable
    df_avg[order(df_avg$activity, df_avg$variable, df_avg$subject),]

    ##Change the column order to be more readable
    df_avg<-df_avg[,c(1,3,2,4)]
    
    ##Write the to a file
    write.table(df_avg, "averages.txt", row.name=FALSE)
}
