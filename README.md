# gettingandcleaningdata Course Project

1. The R script assumes that Samsung data files have been unzipped to a folder "UCI HAR Dataset"

2. The final output is a wide-tidy data set with 180 rows and 81 variables. It includes values for Subject ID and Activity ID

3. The final output follows the principles of tidy data:
  a) Each variable measure is in a different column
  b) Each different observation should be in a different row
  
4. The variable names were taken from the feature.txt file

5. The variable names have been cleaned to remove any parentheses, comma or hyphens. Also, some repeated occurrence of the same word (such as BodyBody) have been removed.

6. The Activity names were taken from the activity_labels.txt files and are present as-is

7. The final output tidy data set has been ordered by the SubjectID

8. A bried working of the script is as follows:
- Read the files from the directory into data frames
- Merge the Training files into one dataframe and Test files into another dataframes
- For both the data frames created above, the first column is SubjectID and the second columns is ActivityID
- Merge these two frames to create a single consolidated dataframe called mergedSet (10299 X 563)
- Read the features.txt file into a dataframe. Extract the values from the second column using lapply function. These are the features for which data was generated.
- Use the extracted feature names to rename the columns of mergedSet 
- To get the observations for mean and standard deviations only I have used grepl command. Since mean and meanFreuqncy mean two very different things, I have searched only for mean, not Mean of meanFreq. The total number of columns matching this criteria were 79 (46 + 33)
- The value returned from the grepl is used to subset the dataframe to return a dataframe with 81 variables. (2 for SubjectID and ActivityID and 79 as per the output of grepl). The subsetted dataframe is named extractedSet (10299 X 81)
- Then the values in ActivityID column were converted to sensible names using the mapping given in activity_labels.txt file
- Next, the column names were cleaned to remove any parentheses, comma or hyphens. Also, some repeated occurrence of the same word (such as BodyBody) have been removed.
- Finally ddply function was used to group the extractedSet by combinations of SubjectID and ActivityID and the resultant column values were averaged. This resulted in the final tidySet data frame (180 X 81)

