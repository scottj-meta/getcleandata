#Getting and Cleaning Data: Course Project
##Introduction

This repository holds the course project from "Getting and Cleaning Data" course, from Coursera.org.  The project's primary objective is to use a R script to generate a tidy data set that can then be used for further analysis. 

##About the Data Source

The data used in this project was generated as part of an experiment, conducted at Smartlab at the University of Genova, Genoa Italy.  The experiment, "Human Activity Recognition Using Smartphones Dataset", was conducted on 30 volunteers within an age bracket of 19-48 years.  The volunteers ran through a series of six activites while wearing a Samsung Galaxy II smartphone.  

The smartphone's embedded accelerometer and gyroscope gathered 10,299 measurements against 561 features.  Two sets of data were collected, testing and training data.

The data is located in various files: 

- 'features_info.txt': Shows information about the variables used on the feature vector.

- 'features.txt': List of all features.

- 'activity_labels.txt': Links the class labels with their activity name.

- 'train/X_train.txt': Training set.

- 'train/y_train.txt': Training labels.

- 'test/X_test.txt': Test set.

- 'test/y_test.txt': Test labels.

The script assumes these files are located in a ./data/UCI\ HAR\ Dataset/ subdirectory from the current working directory.

##run_analysis.R

Run_analysis.R ih will perform the following activities:

1. If not currently present, it will create the appropriate ./data subdirectory
2. If required, it will download the dataset zip file and unzip the contents into the ./data subdirectory
3. Each testing and training file will be read into their own data tables
4. Labels will be applied to the data table columns, for each testing and training data table
5. All testing and training data will be merged together into a large data table
6. The "Activity" field, an integer field by default, will be converted to the text value for each of the 6 Activities
7. The feature values / column names will be cleaned up and made more human-readable
8. The cleaned up data will be processed, and the attributes' averages(mean) will be calculated
9. Finally, the data will be written to a file called "tidy_output.txt"

Note that CodeBook.md has more information about the data.

