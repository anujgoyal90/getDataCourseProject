#Set working directory to location of folder on local drive

setwd("C://Users//AnujGoyal//Desktop//R//Course Project//UCI HAR Dataset")

#Next step is to load all the relevant files to memory

x_test_data<-read.table("./test/X_test.txt")
y_test_data<-read.table("./test/y_test.txt")
x_train_data<-read.table("./train/X_train.txt")
y_train_data<-read.table("./train/y_train.txt")
subject_test<-read.table("./test/subject_test.txt")
subject_train<-read.table("./train/subject_train.txt")
activity_labels<-read.table("./activity_labels.txt")
features<-read.table("./features.txt")

#Next, look at the column headers of all tables and give them descriptive names. This resolves part 4 of the assignment early on.
names(activity_labels)<-c("activity_id","activity_type")
names(features)<-c("feature_id","feature_type")
names(subject_test)<-c("subject_id")
names(subject_train)<-c("subject_id") #these are given the same name to help merge later
names(y_train_data)<-c("activity_id")
names(y_test_data)<-c("activity_id") #these are given the same name to help merge later
names(x_test_data)<-features$feature_type
names(x_train_data)<-features$feature_type #since there are 561 feature types and x_test_data has 561 variables, these must describe the variables

# create the training and test data sets by merging the subject id, activity id and observations data sets
trainingData<-cbind(subject_train,y_train_data,x_train_data)
testData<-cbind(subject_test,y_test_data,x_test_data)

# final data just merges the training and test datasets. The previous steps ensure that all column names are the same in both datasets
#This solves part 1 of the assignment
finaData<-rbind(trainingData,testData)

#For part 2, we need to subset the data by column names containing mean or std dev of a measurement.
# Looking at the column names in finalData, create a logical vector of the columns to include

columnNames<-names(finalData)
logicalVector <- (grepl("subject_id",columnNames)|grepl("activity_id",columnNames)|grepl("mean()",columnNames)|grepl("std()",columnNames))

#Finally, subset the data to the desired columns only
finalData = finalData[logicalVector==TRUE]

#For step 3, add the activity names in activity_label sheet to the final data by merging by activity id
finalData <- merge(activity_labels, finalData, by='activity_id',all.x=TRUE)
