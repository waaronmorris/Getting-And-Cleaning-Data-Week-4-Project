==================================================================
Getting and Cleaning Data in R 
Assignment 4
==================================================================

This project reads the "Human Activity Recognition Using Smartphones Dataset Version 1.0", cleans the data by renaming column headers and changing some row values into understandable text, andp roduces a clean dataset that will be used in downstream analysis.

A brief description of the script:
==================================
1. The script loads the packages required t run the script.
2. The script merges the 2 feature datasets, the 2 test datasets
3. The script rename the dependent variables to their logical names, as provided in the dataset.
4. The script removes the independent variables that do not deal with a STD or mean.
5. The Script changes the dependent variable into readable test-as opossed to the integer provided.
6. The Script the merges the dependent, independent, and subject datasets to create one dataset.
7. The Script writes this dataset to the working directory.