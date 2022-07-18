#!/bin/bash
​
#Making the Environment
mkdir Homework-03
cd Homework-03
mkdir ./Lucky_Duck_Investigations
mkdir ./Lucky_Duck_Investigations/Roulette_loss_Investigation
mkdir ./Lucky_Duck_Investigations/Roulette_loss_Investigation/Player_Analysis
mkdir ./Lucky_Duck_Investigations/Roulette_loss_Investigation/Dealer_Analysis
mkdir ./Lucky_Duck_Investigations/Roulette_loss_Investigation/Player_Dealer_Correlation
​
touch ./Lucky_Duck_Investigations/Roulette_loss_Investigation/Player_Dealer_Correlation/Notes_Player_Dealer_Correlation
touch ./Lucky_Duck_Investigations/Roulette_loss_Investigation/Player_Analysis/Notes_Player_Analysis
touch ./Lucky_Duck_Investigations/Roulette_loss_Investigation/Dealer_Analysis/Notes_Dealer_Analysis
​
wget "https://tinyurl.com/3-HW-setup-evidence" && chmod +x ./3-HW-setup-evidence && ./3-HW-setup-evidence
​
mv ./Dealer_Schedules_0310/0310* ./Lucky_Duck_Investigations/Roulette_loss_Investigation/Dealer_Analysis/
​
mv ./Dealer_Schedules_0310/0312* ./Lucky_Duck_Investigations/Roulette_loss_Investigation/Dealer_Analysis/
​
mv ./Dealer_Schedules_0310/0315* ./Lucky_Duck_Investigations/Roulette_loss_Investigation/Dealer_Analysis/
​
mv ./Roulette_Player_WinLoss_0310/0310* ./Lucky_Duck_Investigations/Roulette_loss_Investigation/Player_Analysis/
​
mv ./Roulette_Player_WinLoss_0310/0312* ./Lucky_Duck_Investigations/Roulette_loss_Investigation/Player_Analysis/
​
mv ./Roulette_Player_WinLoss_0310/0315* ./Lucky_Duck_Investigations/Roulette_loss_Investigation/Player_Analysis/
​
cd ./Lucky_Duck_Investigations/Roulette_loss_Investigation/Player_Analysis/
​
#Create file with all losses
grep -i '\-\$' * | sed 's/_win_loss_player_data:/ /' > Roulette_Losses
​
#Add loss times to file (Date, Time) Important format for later array work.
cat Roulette_Losses | awk -F' ' '{print $1, $2}' >> Notes_Player_Analysis
​
#Make Temp file to hold Dates and times
cat Roulette_Losses | awk -F' ' '{print $1, $2, $3}' >> Dates_and_times
​
#Find most common words in file to find the player.
#sed -e 's/\s/\n/g ; s/,/\n/g' < Roulette_Losses | sort | uniq -c | sort -nr | head  -10
​
#Add Name of person to file
echo Mylie Schmidt >> Notes_Player_Analysis
​
#Add Count of occurances to file
grep -i 'Mylie Schmidt' ./Roulette_Losses |wc -l >> Notes_Player_Analysis 
​
cd ../Dealer_Analysis/
​
#Make file to hold temp data. Can you do this with Variables instead?
mkdir ./TempFiles

#Make Temp files with split data: Date and Times in question
awk '{print $1}'  ../Player_Analysis/Dates_and_times > ./TempFiles/Dates
awk '{print $2, $3}'  ../Player_Analysis/Dates_and_times > ./TempFiles/Times
​
#Create columns for the array with files
readarray -t Dates < ./TempFiles/Dates
readarray -t Times < ./TempFiles/Times
​
#count holder
i=0;
​
#Establish count max value and increment through 
for Date in "${Dates[@]}";
​
#Start loop
do
​
#This echo was testing value reflection was working right.
#echo "The date this loss is on is ${Dates[$i]} at ${Times[$i]}";
​
#grep the files to find those working at that time. " is needed to grab full time value or am/pm is ambiguous
#grep -i "${Times[$i]}"  ./${Dates[$i]}*  
​
#Output show Billy Jones in the Roulette collumn for all these times but let's pull that with awk since we know it is a unique column.
#grep "${Times[$i]}"  ./${Dates[$i]}* | awk -F' ' '{print $1, $2, $5, $6}'
​
#Can we add the date back to the start of this output? Yes we can!
Date=`echo ${Dates[$i]}`
​
Evidence=`grep "${Times[$i]}"  ./${Dates[$i]}* | awk -F' ' '{print $1, $2, $5, $6}'`
#Test success output the requested info to file
echo $Date $Evidence >> Dealers_working_during_losses
​
​
#Increment counter
let "i=i+1"
​
#end of loop
done
​
#Remove Tempfiles folder and temp files within. See Top comment make variables instead of wasting resources on temp files?
rm -rfd ./TempFiles
​
#Record The primary dealer working and the times where losses occurred
cat Dealers_working_during_losses >> Notes_Dealer_Analysis 
​
#Record how many times this occurred
cat Dealers_working_during_losses |wc -l >> Notes_Dealer_Analysis
​
#Navigate to the correlation location and provide your statement.
cd ../Player_Dealer_Correlation
echo "Viewing the Player logs to examine the most common player participating during the dates and times the losses occured is Mylie Schmidt.
​
Viewing the Dealer schedules during these losses on the 10th, 12th, and 15th shows that dealer working the roulette table was Billy Jones.
​
This set of evidence leads us to believe Billy Jones and Mylie Schmidt were working together to pull off this theft." >> Notes_Player_Dealer_Correlation
​
#Create Manager filter script that can analyze by input
cd ../Dealer_Analysis
touch roulette_dealer_finder_by_time.sh
​
#Write script to file
echo '#!/bin/bash' >> roulette_dealer_finder_by_time.sh
​
#Use Cat and a holder to escape the command and write it as is to file
cat <<"EOT" >> roulette_dealer_finder_by_time.sh
grep -i "$2 $3" ./$1* | awk -F" " '{print $1, $2, $5, $6}'
EOT
​
​
#Make Executable
chmod +x roulette_dealer_finder_by_time.sh
​
#Test script works to put out based on arguments
#./roulette_dealer_finder_by_time.sh 0310 05:00:00 AM
​
#BONUS!!!
​
#Make File
touch roulette_dealer_finder_by_time_and_game.sh
​
​
#Write script
#This grep uses the time and AM/PM as a single variable. Not as flexible Formatting needs to be precise. "00:00:00 AM/PM"
echo '#!/bin/bash' >> roulette_dealer_finder_by_time_and_game.sh
cat <<"EOT" >> roulette_dealer_finder_by_time_and_game.sh
grep -i "$2" ./$1* | awk -F" " '{print $1, $2,'$3','$4' }'
EOT
​
#make executable
chmod +x roulette_dealer_finder_by_time_and_game.sh
​
#Run test: Column numbers are now args 3 & 4. Choices are 3,4 5,6 7,8
#./roulette_dealer_finder_by_time.sh 0310 '05:00:00 AM' '$7' '$8'