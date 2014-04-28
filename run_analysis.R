## PEER ASSIGNMENT
##
## 1) Merges the training and the test sets to create one data set.
## 2) Extracts only the measurements on the mean and standard deviation for each measurement. 
## 3) Uses descriptive activity names to name the activities in the data set
## 4) Appropriately labels the data set with descriptive activity names. 
## 5) Creates a second, independent tidy data set with the average of each variable for each activity and each subject. 
##

  ## Load the full list of Features, add column names "FEATURE_ID" and "FEATURE_NAME"
  df_AllFeatures <- read.csv( file = "features.txt", header=FALSE, sep = "")
  colnames(df_AllFeatures) <- c("FEATURE_ID","FEATURE_NAME")
  
  ## Load the activity labels into a data frame, add column names "ACTIVITY_ID" and "ACTIVITY_NAME"
  df_AllActivity_labels <- read.csv( file = "activity_labels.txt", header=FALSE, sep = "")
  colnames(df_AllActivity_labels) <- c("ACTIVITY_ID","ACTIVITY_NAME")
  
  ## Create a list of columns to be used in the extracts
  ColumnNamesMEAN <- as.character(df_AllFeatures$FEATURE_NAME[grep("mean()",df_AllFeatures$FEATURE_NAME)])
  ColumnNamesSTD <- as.character(df_AllFeatures$FEATURE_NAME[grep("std()",df_AllFeatures$FEATURE_NAME)])
  
  ## Load data files - test
  df_subject_test <- read.csv( file = "test/subject_test.txt", header=FALSE, sep = ",")
  colnames(df_subject_test) <- c("SUBJECT_ID")
  df_y_test <- read.csv( file = "test/y_test.txt", header=FALSE, sep = ",")
  colnames(df_y_test) <- c("ACTIVITY_ID")
  df_x_test <- read.csv( file = "test/X_test.txt", header=FALSE, sep = "")
  colnames(df_x_test) <- df_AllFeatures$FEATURE_NAME
  
  ## Add column "ACTIVITY_ID"
  df_subject_test$ACTIVITY_ID <- df_y_test$ACTIVITY_ID
  tdfMEAN <- subset(df_x_test , select = c(ColumnNamesMEAN))  
  tdfSTD <- subset(df_x_test , select = c(ColumnNamesSTD))  
  tdfMEAN_STD <- cbind(tdfMEAN,tdfSTD)
  
  ## Final data set - TEST
  dataTest <- cbind(df_subject_test,tdfMEAN_STD)
  
  ## Load files - Training
  df_subject_train <- read.csv( file = "train/subject_train.txt", header=FALSE, sep = ",")
  colnames(df_subject_train) <- c("SUBJECT_ID")
  df_y_train <- read.csv( file = "train/y_train.txt", header=FALSE, sep = ",")
  colnames(df_y_train) <- c("ACTIVITY_ID")
  df_x_train <- read.csv( file = "train/X_train.txt", header=FALSE, sep = "")
  colnames(df_x_train) <- df_AllFeatures$FEATURE_NAME
  
  ## Add column "ACTIVITY_ID"
  df_subject_train$ACTIVITY_ID <- df_y_train$ACTIVITY_ID
  tdfTrainMEAN <- subset(df_x_train , select = c(ColumnNamesMEAN))  
  tdfTrainSTD <- subset(df_x_train , select = c(ColumnNamesSTD))  
  tdfTrainMEAN_STD <- cbind(tdfTrainMEAN,tdfTrainSTD)
  
  ## Final data set - TEST
  dataTrain <- cbind(df_subject_train,tdfTrainMEAN_STD)
  
  dataAll <- rbind(dataTest,dataTrain)
  ## Merge data sets
  dataAllOut = merge(dataAll, df_AllActivity_labels, by.x="ACTIVITY_ID", by.y="ACTIVITY_ID", all=TRUE)

  # Write to a file
  write.csv(dataAllOut, "DataPeerAssignment.csv")

