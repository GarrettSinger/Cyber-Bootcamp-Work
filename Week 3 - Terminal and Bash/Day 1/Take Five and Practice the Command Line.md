## Activity File: Take Five and Practice the Command Line

- You are playing the role of a security analyst at Wonka Corp. 

- Wonka Corp believes one of their employees might be selling secret recipes to Slugworth Corp.

- You have been tasked with creating evidence files for email, logs, and web access.  

- These files are currently empty, but will be used later to organize your investigation notes on the rogue employee.

### Instructions

Using only the command line, complete the following tasks from within the `/03-student/day1/take_5/` folder in your Ubuntu VM:

  1. Create a folder called `Internal_Investigation_Employee_A`.

  2. Navigate into the `Internal_Investigation_Employee_A` folder.

  3. From within the `Internal_Investigation_Employee_A` folder, print the working directory to confirm you are in the correct place.

  4. Create three files inside the `Internal_Investigation_Employee_A` folder:
      * `email_evidence`
      * `log_evidence`
      * `web_evidence`
  5. Delete the file called `web_evidence` as you realized Wonka has no web logs captured.
  6. Display (list) all the files created.
  7. Clear the terminal window.

**Hint:** Don't be afraid to ask your neighbor or TA for help if you're having trouble with a command.

---
© 2020 Trilogy Education Services, a 2U, Inc. brand. All Rights Reserved.

#!/bin/bash

#Define Variables
workingfrom="Activities/Week1"
folder="Internal_Investigation_Employee_A"
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
#Instruction 1. Make a folder to hold this weeks work
echo -e "$c Making file structure $n"
mkdir -p $workingfrom/$folder
fi 

#Instruction 2. Set working directory
echo -e "$c Traversing to path $fullpath $n"
cd $fullpath

#Instruction 3. Print Working directory
echo -e "$c Current Working Directory Is: $(pwd) $n"
echo "Current Working Directory Is: $(pwd)" >> Take5Output

#instruction 4. Make files
echo -e "$c Creating files here: $(pwd) $n"
touch email_evidence log_evidence web_evidence

#Instruction 5. Delete web_evidence file
echo "$commentcolor Removing web_evidence"
rm web_evidence

#Instruction 6. List all files created
echo -e "$c listing files in current directory $n"
echo -e "\nFiles in this directory:\n $display" >> Take5Output

#Verify output file
echo -e "$c Reading output file for verification $n"
cat $fullpath/Take5Output

