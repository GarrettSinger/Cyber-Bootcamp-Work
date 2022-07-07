##  Activity File: Oh Henry, What Did You Do?
 
- You continue in your role as a security analyst at Wonka Corp, investigating the employees potentially selling secret recipes to Slugworth Corp.

- Your manager at Wonka Corp has identified two possible insiders who may be working with Slugworth Corp: Henry and Ruth.

- Your manager has quickly pulled some files from Henry and Ruth's computers, without their knowledge.

- Some of the files contain gibberish, but some may have useful data.

- Your manager has asked you to preview the files to see if they have readable text data that can be analyzed later.

### Instructions

Using only the command line, complete the following tasks from the `/03-student/day1/oh_henry/` folder in your Ubuntu VM:

  1. There are two folders inside the `/03-student/day1/oh_henry/` folder. One for files captured from Henry, and one for files captured from Ruth.

     * Use the preview commands to determine which of the files contain readable text data.

  3. Remove the files that contain non-readable text data.
    
#### Bonus

  The files each have a timestamp at the bottom.

 * Use the `mv` command to rename each file by adding the date found on the bottom of the file.
 
   - For example: `File1` has a date of October 11, 2019. Rename it to `file1-10_11_2019`.
---
© 2020 Trilogy Education Services, a 2U, Inc. brand. All Rights Reserved.


#!/bin/bash

#Define Variables
WorkingFolder="/03-student/day1/oh_henry/"
workingfrom="Activities/Week1"
folder="Oh_Henry_Files"
fullpath="$WorkingFolder"
pwd=`pwd`
ls=`ls`
display=`tree -a $fullpath`
c="\e[1;33m"
n="\e[1;m"

#Instruction 1 Navigate to files location and examine content.
cd $WorkingFolder
pwd 

#Use more, head, or less to find files with readable text.
#Once done, remove not readable files.
cd ./henry
rm b7.txt bb.txt dj.txt sd.txt ta.txt 
cd ../ruth
rm 77.txt aa.txt as.txt dc.txt sd.txt ta.txt 

#Contains text:
#Henry:   `do.txt sp.txt wp.txt`  
#Ruth:    `l8.txt hy.txt ud.txt`

#Rename remaining files
mv l8.txt l8.txt_10_13_2019
mv hy.txt hy.txt_10_14_2019
mv ud.txt ud.txt_10_15_2019
cd ../henry
mv do.txt do.txt_10_13_2019
mv sp.txt sp.txt_10_14_2019
mv wp.txt wp.txt_10_15_2019

#Verify Completion

echo -e "\nFiles in this directory:\n $display" >> ~/$workingfrom/Oh_Henry_Output

cat ~/$workingfrom/Oh_Henry_Output
