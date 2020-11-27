# Load package and get data
library(reshape2)

getDataDir <- "./getData"
getDataUrl <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
getDataFilename <- "getData.zip"
getDataDFn <- paste(getDataDir, "/", "getData.zip", sep = "")
dataDir <- "./data"

if (!file.exists(getDataDir)) {
  dir.create(getDataDir)
  download.file(url = getDataUrl, destfile = getDataDFn)
}
if (!file.exists(dataDir)) {
  dir.create(dataDir)
  unzip(zipfile = getDataDFn, exdir = dataDir)
}


# Load the datasets

# train data
x_train <- read.table(paste(sep = "", dataDir, "/UCI HAR Dataset/train/X_train.txt"))
y_train <- read.table(paste(sep = "", dataDir, "/UCI HAR Dataset/train/Y_train.txt"))
subject_train <- read.table(paste(sep = "", dataDir, "/UCI HAR Dataset/train/subject_train.txt"))

# test data
x_test <- read.table(paste(sep = "", dataDir, "/UCI HAR Dataset/test/X_test.txt"))
y_test <- read.table(paste(sep = "", dataDir, "/UCI HAR Dataset/test/Y_test.txt"))
subject_test <- read.table(paste(sep = "", dataDir, "/UCI HAR Dataset/test/subject_test.txt"))


# Merge train and test data sets 
x_data <- rbind(x_train, x_test)
y_data <- rbind(y_train, y_test)
subject_data <- rbind(subject_train, subject_test)


# Load activity labels and features

# activity labels
activityLabels <- read.table(paste(sep = "", dataDir, "/UCI HAR Dataset/activity_labels.txt"))
activityLabels[,2] <- as.character(activityLabels[,2])

# features
features <- read.table(paste(sep = "", dataDir, "/UCI HAR Dataset/features.txt"))


# Extract only the data on mean and standard deviation
targetCols <- grep("-(mean|std).*", as.character(features[,2]))
targetColNames <- features[targetCols, 2]
targetColNames <- gsub("-mean", "Mean", targetColNames)
targetColNames <- gsub("-std", "Std", targetColNames)
targetColNames <- gsub("[-()]", "", targetColNames)


# Merge datasets and add labels
x_data <- x_data[targetCols]
allData <- cbind(subject_data, y_data, x_data)
colnames(allData) <- c("Subject", "Activity", targetColNames)

allData$Activity <- factor(allData$Activity, levels = activityLabels[,1], labels = activityLabels[,2])
allData$Subject <- as.factor(allData$Subject)


# Create a tidy data set

meltedData <- melt(allData, id = c("Subject", "Activity"))
tidyData <- dcast(meltedData, Subject + Activity ~ variable, mean)

write.table(tidyData, "./tidy_dataset.txt", row.names = FALSE, quote = FALSE)