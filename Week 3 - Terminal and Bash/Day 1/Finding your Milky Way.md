## Activity File: Finding your Milky Way 
 
- You will continue in your role as security analyst at Wonka Corp, investigating the employee potentially selling secret recipes to Slugworth Corp.

- Your manager at Wonka Corp needs you to create an additional directory, as they believe there is a second employee working with Slugworth Corp.

- You also must copy and move several of the evidence files after creating this new directory.

### Instructions

Using only the command line, continue to complete the following tasks in the `/03-student/day1/take_5` folder in your Ubuntu VM:

  1. Create an additional folder called `Internal_Investigation_Employee_B`.

  2. Using absolute paths, move the file `email_evidence` from `Internal_Investigation_Employee_A` to `Internal_Investigation_Employee_B` as you have been told there will not be email evidence for the first employee. 

  3. Using absolute paths, copy the file `log_evidence` from `Internal_Investigation_Employee_A` to `Internal_Investigation_Employee_B`, as you have been told there will likely be log evidence from both employees.

  4. Check your directories to confirm the files are all in the correct locations.

---
© 2020 Trilogy Education Services, a 2U, Inc. brand. All Rights Reserved.

Continue this by adding to the original script!

#!/bin/bash

#Define Variables
workingfrom="Activities/Week1"
folder="Internal_Investigation_Employee_A"
folderb="Internal_Investigation_Employee_B"
fullpath="$HOME/$workingfrom/$folder"
pwd=`pwd`
ls=`ls`
display=`tree -a $fullpath`
c="\e[1;33m"
n="\e[1;m"

#Set Directory Home
cd $HOME

#Cleanup between runs to ensure accuracy and repeatability
if [ -d $fullpath ]
then
echo -e "$c Deleting previous folder structure $n"
rm -rf $fullpath && mkdir -p $workingfrom/$folder
else
#Instruction T1 and MW1. Make a folder to hold this weeks work
echo -e "$c Making file structure $n"
mkdir -p $workingfrom/$folder
mkdir -p $workingfrom/$folderb
fi 

#Instruction T2. Set working directory
echo -e "$c Traversing to path $fullpath $n"
cd $fullpath

#Instruction T3. Print Working directory
echo -e "$c Current Working Directory Is: $(pwd) $n"
echo "Current Working Directory Is: $(pwd)" >> Take5Output

#Instruction T4. Make files
echo -e "$c Creating files here: $(pwd) $n"
touch email_evidence log_evidence web_evidence

#Instruction M2, M3, & M4. Move & copy files
mv ./email_evidence ../$folderb
cp log_evidence ../$folderb
ls ../$folderb >> Take5Output

#Instruction T5. Delete web_evidence file
echo "$commentcolor Removing web_evidence"
rm web_evidence

#Instruction 6. List all files created
echo -e "$c listing files in current directory $n"
echo -e "\nFiles in this directory:\n $display" >> Take5Output

#Verify output file
echo -e "$c Reading output file for verification $n"
cat $fullpath/Take5Output



