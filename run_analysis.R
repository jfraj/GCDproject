run_analysis<-function(){
    #1.Merges the training and the test sets to create one data set.
    #Let's get the train data
    #For now, I limit the number of row
    maxrows <- 5#for fast testing
    #maxrows<- -1#Will be ignored if negative according to docs
    
    ##This will be used for the column names
    df_names<-read.table("UCI HAR Dataset/features.txt", col.names=c("id", "feature"))
    
    
    ftrain<-"UCI HAR Dataset/train/X_train.txt"
    df_train<-read.table(ftrain, nrows=maxrows, col.names=as.vector(df_names$feature))
    #Now the test data
    ftest<-"UCI HAR Dataset/test/X_test.txt"
    df_test<-read.table(ftrain, nrows=maxrows, col.names=as.vector(df_names$feature))
    df_full<- rbind(df_test, df_train)
    
    #2.Extracts only the measurements on the mean and standard deviation for each measurement.
    ##The the measuremens for the mean and stand. dev. have mean and std in their name
    ##Lets create a vector of names using the features.txt file
    #df_sum<-apply(df_full, 2, mean)
    #df_sum<-rbind(df_sum, apply(df_full, 2, sd))
    #row.names(df_sum)<-c("mean", "sd")
}