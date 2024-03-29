## Activity File: Warm-Up

- You are a security analyst at Wonka Corp. Thanks to your work so far, Wonka Corp's management was able to apprehend Ruth and Henry.

- The local authorities have video evidence that Slugworth delivered a cash payment to Wonka Corp's back door on October 13, 2019.

- You are tasked with gathering physical access logs to prove Henry or Ruth opened the back door for the delivery. This will help the authorities solidify their case.

### Instructions

Using only the command line, complete the following tasks from within the `/03-student/day2/warmup/` folder in your Ubuntu VM:
  
  1. Make a directory in the `warmup` folder called `additional_evidence`.

  2. Navigate to the directory that contains the `physical_access_logs`.

  3. Using preview commands, identify the physical access logs that contain files for October 13, 2019.

  4. Combine these files into a single file called `Physical_Access_evidence.`
  
  5. Move this new file over to the `additional_evidence` folder.
  
---
© 2020 Trilogy Education Services, a 2U, Inc. brand. All Rights Reserved.

#!/bin/bash

#Define Variables
WorkingFolder="/03-student/day2/warmup/"
fullpath="$WorkingFolder"
pwd=`pwd`
ls=`ls`
display=`tree -a $fullpath`
c="\e[1;33m"
n="\e[1;m"

#Navigate to files location and examine content.
cd $WorkingFolder
pwd 

#Make a directory in the `warmup` folder called `additional_evidence`.
mkdir additional_evidence

#Using preview commands, identify the physical access logs that contain files for October 13, 2019.
grep -il '10/13/19' ./physical_access_logs/*

#Results
physical4 and physical5

#Combine these files into a single file called `Physical_Access_evidence.`
grep -il '10/13/19' ./physical_access_logs/* | xargs cat > ./additional_evidence/Physical_Access_evidence

#Move this new file over to the `additional_evidence` folder.
#Why not make it in the right spot to being with?
#Assuming it is made in the phys folder.
#mv Physical_Access_evidence ../additional_evidence/Physical_Access_evidence

#Verify Completion

tree $WorkingFolderadditional_evidence