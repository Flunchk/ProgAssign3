## About this project

This project takes data from The UCI Machine Learning repositry and produces an ouput based on the requirements stated in the Readme.md file

## Data Source

Source data can be found at https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip and should work if extracted into your R working Directory.

## Overview of the Data

From The UCI Machine Learning Repo:
"The experiments have been carried out with a group of 30 volunteers within an age bracket of 19-48 years. Each person performed six activities (WALKING, WALKING_UPSTAIRS, WALKING_DOWNSTAIRS, SITTING, STANDING, LAYING) wearing a smartphone (Samsung Galaxy S II) on the waist. Using its embedded accelerometer and gyroscope, we captured 3-axial linear acceleration and 3-axial angular velocity at a constant rate of 50Hz. The experiments have been video-recorded to label the data manually. The obtained dataset has been randomly partitioned into two sets, where 70% of the volunteers was selected for generating the training data and 30% the test data.

The sensor signals (accelerometer and gyroscope) were pre-processed by applying noise filters and then sampled in fixed-width sliding windows of 2.56 sec and 50% overlap (128 readings/window). The sensor acceleration signal, which has gravitational and body motion components, was separated using a Butterworth low-pass filter into body acceleration and gravity. The gravitational force is assumed to have only low frequency components, therefore a filter with 0.3 Hz cutoff frequency was used. From each window, a vector of features was obtained by calculating variables from the time and frequency domain."

##Attribute Information:

For each record in the dataset it is provided:
- Triaxial acceleration from the accelerometer (total acceleration) and the estimated body acceleration.
- Triaxial Angular velocity from the gyroscope.
- A 561-feature vector with time and frequency domain variables.
- Its activity label.
- An identifier of the subject who carried out the experiment. 

# Code Walkthrough 

##SETUP DIRECTORYS AND FILES
This part loads the text files provided into R using the "paste" function. This turns the text files into tables for R.

##SETUP DATA
Here read.table is used to load the various tables of attributes into R varibles for manipulation.

##TRAINING SET MERGE
To meet the requirement to merge the training sets the code uses the R functions cbind and rbind (column and row binding respectively) 

##MEAN AND STD EVAL CALCULATION
This part of the code extracts the  mean and standard evaluation from the code as per the requirements of the project.

This is done through the use of Grep against the merged training set and is mislabbeled as a calculation. I noticed after uploading code and may not fix in time.

##CHANGE TO DESCRIPTIVE NAMES AND LABEL
The data provided does not have very user freindly names so this part of the code uses "gsub" to substitute for more human readable names as per the requirements.

##Stage 5
Stage 5 is used to create the second data set. It is virtually the same process as listed above but not seperated into different sections as code has already been explained.

It should probably have been labelled as Stage 6 but I was counting the 5 stages of the requirement and not including the initial data file read, OOOPS!
##Final Output
Finally we get the output from both tables, this is summarised using "ddply" from the plyr package. It then uses a write.table to output the results. Note as per instructions proviided col.names is set to FALSE


