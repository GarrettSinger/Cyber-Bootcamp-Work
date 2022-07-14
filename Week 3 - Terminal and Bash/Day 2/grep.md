## Activity File: grep  
 
- You will continue your role as a security analyst at Wonka Corp.

- Your manager now needs to know which of the secret recipes include guavaberries. 

  - Even if Slugworth was able to obtain the secret recipe, they won't be able to produce the candy since Wonka is the sole owner of the guavaberry plant.

- Your task is to determine which of the secret recipes contain guavaberries in the list of ingredients.

### Instructions

 Using only the command line, continue to complete the following tasks in the `/03-student/day2/finding_your_way/` folder in your Ubuntu VM:

1. Navigate back into the `PeanutButtery.net` directory that contained the secret recipes. 

2. Find all recipes that include the word "guavaberries" in their list of ingredients.
    
#### Bonus

Your manager realized that some of the recipes require guavaberries as _optional_, and is now concerned Slugworth can still make these secret recipes.

- Compose a single command to find all the files that have the word "guavaberries" OR "optional" in the recipe. 
---
© 2020 Trilogy Education Services, a 2U, Inc. brand. All Rights Reserved.

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

#2. Find all recipes that include the word "guavaberries" in their list of ingredients.
grep -irl guavaberries *.*

#PeanutButtery.net/other/disregard/wonkasecretrecipes/recipe_peanutballs
#PeanutButtery.net/other/disregard/wonkasecretrecipes/recipe_yumbars
#PeanutButtery.net/other/disregard/wonkasecretrecipes/recipe_peanutsquares
#PeanutButtery.net/other/disregard/wonkasecretrecipes/recipe_crunchybars

#Bonus!
grep -ir "guavaberries\|optional" *.*

#PeanutButtery.net/other/disregard/wonkasecretrecipes/recipe_peanutsquares: Note: optional - another berry that can be substituted is blueberries

