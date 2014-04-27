
## Guidelines

This is a brief explanation of the cleaning process, please refer to the source code anytime since each step is commented there in detail

#### Step 1
All values,activities and subjects read from the disk and both train and tests datasets were merged for each one.
For each step I verified if the sample size lenght was matching for each of the datasets otherwise the later column merging would be impossible.
The checking was done manually(and is commented in the code) throught the str function

#### Step 2
Load features and filter only the ones that had "mean" and "sdt" in their names

#### Step 3
use the remaing features names as names for the values variables and make then all lower case (good pratice)

#### Step 4
read the activities names from file and aplying as names for the activities variables and make then all lower case (good pratice)

#### Step 5
read the activities names from file and aplying as values for the activities values since it's a discrete variable

#### Step 6
merge all (subjects + activities + values) and write to disk (tidyData.txt)

#### Step 7
group by subject and activity and calculate mean for each variable and write to disk (averageTidyData.txt)
