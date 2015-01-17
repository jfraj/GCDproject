run_analysis<-function(){
    #1.Merges the training and the test sets to create one data set.
    #Let's get the train data
    #For now, I limit the number of row
    maxrows <- 5#for fast testing
    #maxrows<- -1#Will be ignored if negative according to docs
    ftrain<-"UCI HAR Dataset/train/X_train.txt"
    df_train<-read.table(ftrain, nrows=maxrows)
    dim(df_train)
    #Now the test data
    ftest<-"UCI HAR Dataset/test/X_test.txt"
    df_test<-read.table(ftrain, nrows=maxrows)
    df_full<- rbind(df_test, df_train)
    
    #2.Extracts only the measurements on the mean and standard deviation for each measurement.
    ##Make sure there are no field with meand and sd in each rows...
    df_sum<-apply(df_full, 2, mean)
    df_sum<-rbind(df_sum, apply(df_full, 2, sd))
    row.names(df_sum)<-c("mean", "sd")
}