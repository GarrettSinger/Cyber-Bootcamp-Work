## Activity File: Finding Your Way 
 
- In this activity you will continue your role as a security analyst at Wonka Corp.

- Your manager has identified why PeanutButtery.net was targeted: Henry had hidden a secret recipe for a revolutionary Wonka candy within the file system, and Slugworth was trying to find it.

- Your manager at Wonka needs you to search through the files and file directories of the PeanutButtery.net server to find the hidden recipes in its file system.

- You are tasked with scanning the directories of the site PeanutButtery.net to uncover the secret recipes hidden by Henry

### Instructions

Using only the command line, complete the following tasks in the `/03-student/day2/finding_your_way/` folder in your Ubuntu VM:

1. Navigate into the `PeanutButtery.net` directory.

2. Find all directories that have the word "secret" in their directory name.

3. Find all files that have the word "recipe" in their file name. 
    
#### Bonus

 You manager believes the recipe is for a peanut candy, and would like you to narrow your search to include only those recipes.
 - Use a single command to find all the files that have the words "recipe" and "peanut" in their name.
 
 **Hint:** Research how to use the AND functionality with the `find` command.
  
#!/bin/bash

#Define Variables
WorkingFolder="/03-student/day2/finding_your_way/"
fullpath="$WorkingFolder"
pwd=`pwd`
ls=`ls`
display=`tree -a $fullpath`
c="\e[1;33m"
n="\e[1;m"

#1. Navigate into the `PeanutButtery.net` directory.
cd $WorkingFolder
pwd 

#2. Find all directories that have the word "secret" in their directory name.
find -type d -iname *secret*

#sysadmin@UbuntuDesktop:/03-student/day2/finding_your_way$ find -type d -iname *secret*
#./PeanutButtery.net/other/disregard/wonkasecretrecipes

#3. Find all files that have the word "recipe" in their file name. 
find -type f -iname *recipe*

#sysadmin@UbuntuDesktop:/03-student/day2/finding_your_way$ find -type f -iname *recipe*
#./PeanutButtery.net/other/disregard/wonkasecretrecipes/recipe_peanutballs
#./PeanutButtery.net/other/disregard/wonkasecretrecipes/recipe_yumbars
#./PeanutButtery.net/other/disregard/wonkasecretrecipes/recipe_peanutsquares
#./PeanutButtery.net/other/disregard/wonkasecretrecipes/recipe_crunchybars

#Bonus!
find -type f -iname *recipe* -a -iname *peanut*

#./PeanutButtery.net/other/disregard/wonkasecretrecipes/recipe_peanutballs
#./PeanutButtery.net/other/disregard/wonkasecretrecipes/recipe_peanutsquares

