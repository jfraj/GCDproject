run_analysis<-function(maxrows=-1){
    library(plyr)
    library(reshape)
    #1.Merges the training and the test sets to create one data set.
    #Let's get the train data
    #For now, I limit the number of row
    #maxrows <- 5#for fast testing
    #maxrows<- -1#Will be ignored if negative according to docs
    
    ##This will be used for the column names
    df_names<-read.table("UCI HAR Dataset/features.txt", col.names=c("id", "feature"))
    cnames<-as.vector(df_names$feature)
    ##Improving the names
    #cnames <- sub("()", "", cnames, fixed = TRUE)
    cnames <- gsub("(", "", cnames, fixed = TRUE)
    cnames <- gsub(")", "", cnames, fixed = TRUE)
    cnames <- gsub(".", "", cnames, fixed = TRUE)
    cnames <- gsub("-", "", cnames, fixed = TRUE)
    cnames <- gsub(",", "to", cnames, fixed = TRUE)
    #print(cnames)
    
    #train
    ftrain<-"UCI HAR Dataset/train/X_train.txt"
    #df_train<-read.table(ftrain, nrows=maxrows, col.names=cnames)
    df_train<-read.table(ftrain, nrows=maxrows, col.names=cnames)
    flabels<-"UCI HAR Dataset/train/y_train.txt"
    df_train_labels<-read.table(flabels, nrows=maxrows)
    ftrain_subjects<-"UCI HAR Dataset/train/subject_train.txt"
    df_train_subjects<-read.table(ftrain_subjects, nrows=maxrows)
    
    
    #test
    ftest<-"UCI HAR Dataset/test/X_test.txt"
    df_test<-read.table(ftest, nrows=maxrows, , col.names=cnames)
    ftest_labels<-"UCI HAR Dataset/test/y_test.txt"
    df_test_labels<-read.table(ftest_labels, nrows=maxrows)
    ftest_subjects<-"UCI HAR Dataset/test/subject_test.txt"
    df_test_subjects<-read.table(ftest_subjects, nrows=maxrows)
    
    
    print(dim(df_train))
    print(dim(df_train_labels))
    print(dim(df_train_subjects))
    print(dim(df_test))
    print(dim(df_test_labels))
    
    #Combining subject and labels
    print(df_train_subjects)
    df_train$subject<-df_train_subjects[,1]
    df_test$subject<-df_test_subjects[,1]
    df_train$label<-df_train_labels[,1]
    df_test$label<-df_test_labels[,1]
    print(dim(df_train))
    
    #merge
    df_full<- rbind(df_test, df_train)
    #df_labels<- rbind(df_test_labels, df_train_labels)
    #df_subjects<- rbind(df_test_subjects, df_train_subjects)
    #print(names(df_full))
    #print(dim(df_full))
    #print(dim(df_labels))
    #print(dim(df_subjects))    
    
    #2.Extracts only the measurements on the mean and standard deviation for each measurement.
    ##The the measuremens for the mean and stand. dev. have mean and std in their name
    ##Lets create a vector of names using the features.txt file
    #df_sum<-apply(df_full, 2, mean)
    #df_sum<-rbind(df_sum, apply(df_full, 2, sd))
    #row.names(df_sum)<-c("mean", "sd")
    #
    #To find column names with mean in it use df_names[grep("mean", df_names$feature),]
    #df_names[grep("Mean|mean|std", df_names$feature),]##Did not find other combitnations
    #df_names[grep("Mean|mean|std", cnames),]##Did not find other combitnations
    vsummarynames<-grep("Mean|mean|std|label|subject",colnames(df_full))
    dfsummary<-df_full[,vsummarynames]
    print(dim(dfsummary))
    #print(names(dfsummary))
    
    #3. Uses descriptive activity names to name the activities in the data set
    #According to the readme file, the activity names and lable are given in the 
    #activity_labels.txt
    df_activities<-read.table("./UCI HAR Dataset/activity_labels.txt")
    dfsummary$activity<-df_activities[dfsummary$label,2]
    
    #print(names(dfsummary))
    #print(dfsummary[,c("label", "activity")])

    
    #4.Appropriately labels the data set with descriptive variable names.
    # The column names were already given in the previous steps

    
    #5. From the data set in step 4, creates a second, independent tidy data set 
    #   with the average of each variable for each activity and each subject.
    columns4tidy<-names(dfsummary)
    columns4tidy<- columns4tidy[! columns4tidy %in% c("label", "activity", "subject")]
    #print(names(vsummarynames))
    #print(columns4tidy)
    print("Here are...")
    print(dim(dfsummary))
    print(length(columns4tidy))
    
    ##Wide
    df_avg<-ddply(dfsummary, .(activity, subject), function (x) colMeans(x[,columns4tidy]))
    print(dim(df_avg))
    
    ##Or tall and skinny
    df_avg<-melt(df_avg, id=c("activity", "subject"), measure.vars=columns4tidy)
    print(names(df_avg))
    df_avg[order(df_avg$activity, df_avg$variable, df_avg$subject),]
    #Change the column order
    df_avg<-df_avg[,c(1,3,2,4)]
    write.table(df_avg, "averages.txt", row.name=FALSE)
    #print(class(df_avg))
    #print(df_avg[1:5])
    #print(dim(df_avg))
    #print(names(df_avg))
    #print(df_avg["angle.Y.gravityMean."])
    #print(df_avg["angle.X.gravityMean."])
    #print(cnames)
}
