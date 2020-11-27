Getting and Cleaning Data Course Project
---------------------------------------------
&nbsp;

#### Description

The purpose of this project is to collect, work with, and clean a data set. The goal is to prepare a tidy data that can be used for later analysis. 

The data and its description can be obtained from the followings links:

https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip

http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones

&nbsp;

#### Processing the Data

An R script included in this repository does the following:

1. Downloads the data set from web if not yet existing in the working directory.  
2. Reads the train and test datasets and combines them into single x, y, and subject datasets.  
3. Loads the activity labels and features datasets. 
4. Extracts the "-mean" and "-std" columns and modifies them into Mean and Std.
4. Extracts only the data on mean and standard deviation.
5. Combines x, y and subject datasets into one dataset named allData. Also adds the activity labels and features.  
6. Creates a tidy data set consisting the average (mean) of each variable for each subject and each activity.
7. Writes out a text file named tidy_dataset.txt.
