## Activity File: Warm-Up

- You continue to be a security analyst at Wonka Corp.

- Thanks to your great work, the authorities were able to charge Slugworth.
- The prosecutor on the case has subpoenaed you for a list of additional data to help build the case against Slugworth.
- You are tasked with gathering additional information specified in the subpoena.

### Instructions

Using only the command line, complete the following tasks from within the `/03-student/day3/warmup` folder in your Ubuntu VM:


 1.  Create a folder called `subpoena_request`. 

2.  As specified in the subpoena, gather the following and place them in the `subpoena_request` folder:
    - Files from the `WEBACCESS` directory, dated 0719.
    
    - Employee mobile phone logs from the `PHONE_LOGS` directory, which provide proof of calls made to Slugworth's number:  454-555-3894.
      - Place these specific call logs in a new file called `Calls_to_Slugworth.`

#### Bonus

  - Find the employee phone directory. Use a single `grep` command to determine if any other employees besides Ruth and Henry were contacting Slugworth. 

---
© 2020 Trilogy Education Services, a 2U, Inc. brand. All Rights Reserved.


#!/bin/bash

#Define Variables
WorkingFolder="/03-student/day3/warmup/"
fullpath="$WorkingFolder"
pwd=`pwd`
ls=`ls`
display=`tree -a $fullpath`
c="\e[1;33m"
n="\e[1;m"

#Navigate to files location and examine content.
cd $WorkingFolder
pwd 

#Make a directory in the `warmup` folder called `subpoena_request`.
mkdir subpoena_request

#As specified in the subpoena, gather the following and place them in the `subpoena_request` folder:

find WEBACCESS -type f -iname "*0719*" | xargs cp -t ./subpoena_request
grep -ir 454-555-3894 PHONE_LOGS/ > ./subpoena_request/Calls_to_Slugworth 

BONUS:
grep '212-555-2732\|212-555-2733\|212-555-2734' ./DIRECTORIES/*
