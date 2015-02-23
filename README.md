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

  

