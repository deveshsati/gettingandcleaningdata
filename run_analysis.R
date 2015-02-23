  # Read the files from the directory
  xTrain <- read.table("UCI HAR Dataset/train/X_train.txt")
  yTrain <- read.table("UCI HAR Dataset/train/Y_train.txt")
  subTrain <- read.table("UCI HAR Dataset/train/subject_train.txt")
  
  xTest <- read.table("UCI HAR Dataset/test/X_test.txt")
  yTest <- read.table("UCI HAR Dataset/test/Y_test.txt")
  subTest <- read.table("UCI HAR Dataset/test/subject_test.txt")
  
  # Merge the Training files and assign names to the 1st two columns
  mergedTrain <- cbind(subTrain, yTrain, xTrain)
  names(mergedTrain)[1:2] <- c("SubjectID", "ActivityID")
  
  mergedTest <- cbind(subTest, yTest, xTest)
  names(mergedTest)[1:2] <- c("SubjectID", "ActivityID")
  
  # Merge the above two dataframes to get a data frame that combines Test and Training Data
  # This is the answer to Part 1 of the Course Project
  mergedSet <- rbind(mergedTest, mergedTrain)
  
  #Solution for Part 2 - Extracts only the measurements on the mean and standard deviation for each measurement.
  # Read the features.txt file
  features <- read.table("UCI HAR Dataset/features.txt")
  
  #The second column of features dataframe contains factors.
  # Use lapply to convert it to vectors
  # This will give all the features names. We will use to rename columns to mergedSet
  featuresVec <- lapply(features$V2, as.character)
  names(mergedSet)[3:563] <- featuresVec 
  
  # Create the logical vector to extract column names that contain 'mean' or 'std'
  extractLogical <- grepl("(*mean*|*std*)", names(mergedSet))
  
  # Since we need the 1st two columns(SubjectID and ActivityID) as well, edit the logical vector to include the 1st two columns
  extractLogical[1:2] <- c(TRUE, TRUE)
  
  # Extract the set
  # This is the solution to Part 2 of the Course Project
  extractedSet <- mergedSet[, extractLogical]
  
  
  # Part 3: Uses descriptive activity names to name the activities in the data set
  # Replace the Activity IDs with the following values
  extractedSet$ActivityID[extractedSet$ActivityID == 1] <- "WALKING"
  extractedSet$ActivityID[extractedSet$ActivityID == 2] <- "WALKING_UPSTAIRS"
  extractedSet$ActivityID[extractedSet$ActivityID == 3] <- "WALKING_DOWNSTAIRS"
  extractedSet$ActivityID[extractedSet$ActivityID == 4] <- "SITTING"
  extractedSet$ActivityID[extractedSet$ActivityID == 5] <-  "STANDING"
  extractedSet$ActivityID[extractedSet$ActivityID == 6] <-  "LAYING"
  
  # Part 4: Appropriately labels the data set with descriptive variable names.
  # create a function to do this
  clean.up.column.names<-function(v)
  {
  
  v=gsub('-','.',v)         
  v=gsub('\\(','',v)
  v=gsub(')','',v)
  v=gsub('BodyBody','Body',v)
  v=gsub(',', '.', v)
  v            
  }
  
  # Call the function on the names of all columns
  # This is the solution to Part 4 of the Course Project
  names(extractedSet) <- clean.up.column.names(names(extractedSet))
  
  # Part 5: From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.
  # Use ddply function
  tidySet <- ddply(extractedSet, .(SubjectID, ActivityID), numcolwise(mean))
  View(tidySet)
