
#MERGE VALUES
valuesTrain <- read.table("train/X_train.txt")
valuesTest <- read.table("test/X_test.txt")
valuesMerged <- rbind(valuesTrain, valuesTest)

# DEBUG COMMAND IF NECESSARY str(valuesMerged)

#MERGE ACTIVITY VALUES
activityTrain <- read.table("train/y_train.txt")
activityTest <- read.table("test/y_test.txt")
activityMerged <- rbind(activityTrain, activityTest)

# DEBUG COMMAND IF NECESSARY str(activityMerged)

#MERGE SUBJECTS
subjectTrain <- read.table("train/subject_train.txt")
subjectTest <- read.table("test/subject_test.txt")
subjectMerged <- rbind(subjectTrain, subjectTest)

# DEBUG COMMAND IF NECESSARY str(subjectMerged)

#LOAD and FILTER FEATURES - only mean and std
features <- read.table("features.txt")
#array of indexes
filtered_features <- grep("-mean\\(\\)|-std\\(\\)", features[, 2])

#apply array of indexs to the merged data
valuesMerged <- valuesMerged[, filtered_features]

#applying labels for values
names(valuesMerged) <- features[filtered_features, 2]

#normalize labels
names(valuesMerged) <- tolower(names(valuesMerged))  

#read activities labels
activitiesLabels <- read.table("activity_labels.txt")
#normalize activities labels
activitiesLabels[, 2] = tolower(as.character(activitiesLabels[, 2]))

# Add labels to the activity values
activityMerged[,1] = activitiesLabels[activityMerged[,1], 2]

#applying labels for activities
names(activityMerged) <- "activity"

#applying labels for subjects
names(subjectMerged) <- "subject"


# TIDY DATA IS READY TO BE COMPOSED, bind all columns from the datasets (activity,values and subjects) to get the final dataset
tidyData <- cbind(subjectMerged,activityMerged, valuesMerged)

#WRITE TO DISK
write.table(tidyData, "tidyData.txt")

# GROUPING BY ACTIVITY AND SUBJECT  THEN APLYING AVERAGE FOR VARIABLES
agg<-aggregate(tidyData, by=list(activiy=tidyData$activity,subject=tidyData$subject), FUN=mean, na.rm=TRUE)
# REMOVING ORIGINAL ACTIVITY AND SUBJECT COLUMNS SINCE THEY ARE NOW SHOWING UP AS GROUPS (COLUMNS 1 AND 2)
agg<-agg[,-c(3,4)] 

#WRITE TO DISK
write.table(agg, "averageTidyData.txt")
