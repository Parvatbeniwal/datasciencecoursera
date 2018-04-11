# install.packages("reshape2")

library(reshape2)


## Downloading and unziping the dataset:
fileURL <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip "
download.file(fileURL, "prog_assignment_dataset.zip" , method="curl")


## If file exist don not unzip it 
if (!file.exists("/Users/psingh/Downloads/UCI HAR Dataset")) { 
     unzip(filename) 
}

## Loading  activity labels
activity_Labels <- read.table("/Users/psingh/Downloads/UCI HAR Dataset/activity_labels.txt")
activity_Labels[,2] <- as.character(activity_Labels[,2])

##   Loading Features and converting column as character
features <- read.table("/Users/psingh/Downloads/UCI HAR Dataset/features.txt")
features[,2] <- as.character(features[,2])

## Extract only the data on mean and standard deviation
featuresDesired <- grep(".*mean.*|.*std.*", features[,2])
featuresNames <- features[featuresDesired,2]

#Replacing with gsub recusively
featuresNames = gsub('-mean', 'Mean', featuresNames)
featuresNames = gsub('-std', 'Std', featuresNames)
featuresNames <- gsub('[-()]', '', featuresNames)


## Loading the datasets and ColumnBinding tables
trainX <- read.table("/Users/psingh/Downloads/UCI HAR Dataset/train/X_train.txt")[featuresDesired]
trainY <- read.table("/Users/psingh/Downloads/UCI HAR Dataset/train/Y_train.txt")
trainSubjects <- read.table("/Users/psingh/Downloads/UCI HAR Dataset/train/subject_train.txt")
trainX <- cbind(trainSubjects, trainY, trainX)

testX <- read.table("/Users/psingh/Downloads/UCI HAR Dataset/test/X_test.txt")[featuresDesired]
testY <- read.table("/Users/psingh/Downloads/UCI HAR Dataset/test/Y_test.txt")
testSubjects <- read.table("/Users/psingh/Downloads/UCI HAR Dataset/test/subject_test.txt")
testX <- cbind(testSubjects, testY, testX)

## merge datasets and add labels
finalData <- rbind(trainX, testX)
colnames(finalData) <- c("subject", "activity", featuresNames)

## turn activities & subjects into factors
finalData$activity <- factor(finalData$activity, levels = activity_Labels[,1], labels = activity_Labels[,2])
finalData$subject <- as.factor(finalData$subject)

finalDataMelted <- melt(finalData, id = c("subject", "activity"))
finalDataMean <- dcast(finalDataMelted, subject + activity ~ variable, mean)

write.table(finalDataMean, "/Users/psingh/datasciencecoursera/Getting_And_Cleaning_Project/tidy.txt", row.names = FALSE, quote = FALSE)