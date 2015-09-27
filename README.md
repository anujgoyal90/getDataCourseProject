# How to run the run_analysis.R script

Firstly, you will need to download the data for this project which is saved here: https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip

Once you have downloaded and unzipped the data, set the "UCI HAR Dataset" folder as your working directory.

In line 5 of the run_analysis.R, replace the working directory with the location where you have stored the data

Beyond that, the script can be run as usual. The final output of the script is a file called tidyData.txt which will be saved in the working directory i.e the "UCI HAR Dataset" folder in your local location.

#Description:

The script has 5 sub-sections which solve 5 parts of the Course project for the Getting and Cleaning Data course offered by Johns Hopkins University via Coursera

Part 1: Merges the training and the test sets to create one data set.

Part 2: Extracts only the measurements on the mean and standard deviation for each measurement. 

Part 3: Uses descriptive activity names to name the activities in the data set.

Part 4: Appropriately labels the data set with descriptive variable names.

Part 5: From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.
