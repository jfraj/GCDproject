run_analysis<-function(maxrows=-1){
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
    df_train<-read.table(ftrain, nrows=maxrows)
    flabels<-"UCI HAR Dataset/train/y_train.txt"
    df_train_labels<-read.table(flabels, nrows=maxrows)
    ftrain_subjects<-"UCI HAR Dataset/train/subject_train.txt"
    df_train_subjects<-read.table(ftrain_subjects, nrows=maxrows)
    
    
    #test
    ftest<-"UCI HAR Dataset/test/X_test.txt"
    df_test<-read.table(ftest, nrows=maxrows)
    ftest_labels<-"UCI HAR Dataset/test/y_test.txt"
    df_test_labels<-read.table(ftest_labels, nrows=maxrows)
    ftest_subjects<-"UCI HAR Dataset/test/subject_test.txt"
    df_test_subjects<-read.table(ftest_subjects, nrows=maxrows)
    
    
    print(dim(df_train))
    print(dim(df_train_labels))
    print(dim(df_test))
    print(dim(df_test_labels))
        
    #merge
    df_full<- rbind(df_test, df_train)
    df_labels<- rbind(df_test_labels, df_train_labels)
    df_subjects<- rbind(df_test_subjects, df_train_subjects)
    print(dim(df_full))
    print(dim(df_labels))
    print(dim(df_subjects))    
    cat ("Press [enter] to continue")
    line <- readline()

    cat ("Press [enter] to continue")
    line <- readline()
    
    
    
    #2.Extracts only the measurements on the mean and standard deviation for each measurement.
    ##The the measuremens for the mean and stand. dev. have mean and std in their name
    ##Lets create a vector of names using the features.txt file
    #df_sum<-apply(df_full, 2, mean)
    #df_sum<-rbind(df_sum, apply(df_full, 2, sd))
    #row.names(df_sum)<-c("mean", "sd")
    #
    #To find column names with mean in it use df_names[grep("mean", df_names$feature),]
    #df_names[grep("Mean|mean|std", df_names$feature),]##Did not find other combitnations
    df_names[grep("Mean|mean|std", cnames),]##Did not find other combitnations
    vsummarynames<-grep("Mean|mean|std",colnames(df_full))
    dfsummary<-df_full[,vsummarynames]
    print(dim(dfsummary))
    
    #3-4 Seems like the names are ok... for now
    
    #5. From the data set in step 4, creates a second, independent tidy data set 
    #   with the average of each variable for each activity and each subject.
    df_avg<-colMeans(dfsummary)
    print(class(df_avg))
    print(df_avg[1:5])
    print(dim(df_avg))
    print(names(df_avg))
    #print(df_avg["angle.Y.gravityMean."])
    #print(df_avg["angle.X.gravityMean."])
    #print(cnames)
}
