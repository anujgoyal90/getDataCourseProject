#Set working directory to location of data folder on local drive

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

#Next, look at the column headers of all tables and give them descriptive names. 
#This resolves part 4 of the assignment early on.

names(activity_labels)<-c("activity_id","activity_type")
names(features)<-c("feature_id","feature_type")

#The subjects in the test and training data are given the same name to help with merging the datasets later 
#Similarly the activity id in test and training data are given the same name to help merging datasets later

names(subject_test)<-c("subject_id")
names(subject_train)<-c("subject_id")
names(y_train_data)<-c("activity_id")
names(y_test_data)<-c("activity_id")

#since there are 561 feature types and x_test_data and x_train_data have 561 variables, these must describe the variables
#these are more descriptive names for the variables than V, V.1, V.2 and so on

names(x_test_data)<-features$feature_type
names(x_train_data)<-features$feature_type

# create the training and test data sets by merging the subject id, activity id and measurements data sets

trainingData<-cbind(subject_train,y_train_data,x_train_data)
testData<-cbind(subject_test,y_test_data,x_test_data)

#Next step is to merge the training and test data row-wise. This solves part 1 of the assignment.
#The previous steps ensure that all column headers are the same in both datasets to help with merging

finlaData<-rbind(trainingData,testData)

#For part 2, we need to subset the data by column names containing mean or std dev of a measurement.
# Looking at the column names in finalData, create a logical vector of the columns to include

columnNames<-names(finalData)
logicalVector <- (grepl("subject_id",columnNames)|grepl("activity_id",columnNames)|grepl("mean()",columnNames)|grepl("std()",columnNames))

#Finally, subset the data to the desired columns only
finalData = finalData[logicalVector==TRUE]

#For part 3, add the activity names in activity_label sheet to the final data by merging by activity id
finalData <- merge(activity_labels, finalData, by='activity_id',all.x=TRUE)

#For part 5, we melt the final data by activity id, activity type and subject id
#First, we need to identify the measure variables which are the mean and std dev observations
measureVariables <- finalColumnNames[(grepl("mean()",finalColumnNames)|grepl("std()",finalColumnNames))]
finalDataMelt <-melt(finalData,id=c("activity_id","activity_type","subject_id"),measure=measureVariables)

#Lastly, recast the data to average all measured variables by subject id, activity id and activity type
tidyData <- dcast(finalDataMelt, subject_id + activity_id + activity_type ~ variable, mean)

#Write the tidied data to a new txt file called tidyData.txt
write.table(tidyData, './tidyData.txt',row.names=TRUE)
