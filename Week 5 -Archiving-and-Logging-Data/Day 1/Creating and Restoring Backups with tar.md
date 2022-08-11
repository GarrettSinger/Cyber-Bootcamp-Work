## Activity File: Creating and Restoring Backups with `tar`

### Part 1: Creating Backups with `tar`

In this two-part activity, you are a junior administrator at *Rezifp Pharma Inc.*

- The company conducts clinical trials on drugs for oncology, immunology, and vaccines.  In recent weeks, there have been a series of malware attacks. The company is now strengthening its backup activities.   

- In response to the malware attacks, your department has decided to create daily *full backups* of the files associated with the E-Prescription Treatment database, which is the main system for many departments. 

You have been tasked with:

- Creating a name for the `tar` archive using the department's standard naming convention.
 
- Creating daily full backups of the directories and files in the `~/Documents/epscript` directory.

- Printing the file permission, owner, size, date, and time for each file in the archive.
 
- Verifying the archive after it is written to check for errors.

- Creating a file containing the output of the `tar` command for later review by the SysOps team, which will check file structure, permissions, and errors.

#### Lab Environment

- To complete the activity, log into the lab environment using the following credentials:  
    - Username: `sysadmin` 
    - Password: `cybersecurity`

#### Instructions

1. Move to the `~/Documents/epscript` directory.
cd ~/Documents/epscript
2. List the `epscript` directory contents and answer the following question:

    - What directories and files are located there?
.
├── backup
│   └── 20190814epscript.tar
├── doctors
│   ├── doctors.10.csv
│   ├── doctors.11.csv
│   ├── doctors.12.csv
│   ├── doctors.13.csv
│   ├── doctors.14.csv
│   ├── doctors.15.csv
│   ├── doctors.16.csv
│   ├── doctors.17.csv
│   ├── doctors.18.csv
│   ├── doctors.19.csv
│   ├── doctors.1.csv
│   ├── doctors.20.csv
│   ├── doctors.2.csv
│   ├── doctors.3.csv
│   ├── doctors.4.csv
│   ├── doctors.5.csv
│   ├── doctors.6.csv
│   ├── doctors.7.csv
│   ├── doctors.8.csv
│   ├── doctors.9.csv
│   └── doctors.csv
├── emerg_back_sun.tar
├── emerg_backup.snar
├── emergency
│   ├── admit
│   │   ├── file1.txt
│   │   ├── file3.txt
│   │   ├── file4.txt
│   │   └── file5.txt
│   └── discharge
│       └── file2.txt
├── testenvir
│   ├── doctor
│   │   ├── doctors.10.csv
│   │   ├── doctors.11.csv
│   │   ├── doctors.12.csv
│   │   ├── doctors.13.csv
│   │   ├── doctors.14.csv
│   │   ├── doctors.15.csv
│   │   ├── doctors.16.csv
│   │   ├── doctors.17.csv
│   │   ├── doctors.18.csv
│   │   ├── doctors.19.csv
│   │   ├── doctors.1.csv
│   │   ├── doctors.20.csv
│   │   ├── doctors.2.csv
│   │   ├── doctors.3.csv
│   │   ├── doctors.4.csv
│   │   ├── doctors.5.csv
│   │   ├── doctors.6.csv
│   │   ├── doctors.7.csv
│   │   ├── doctors.8.csv
│   │   ├── doctors.9.csv
│   │   └── doctors.csv
│   ├── patient
│   │   ├── patient.0a.txt
│   │   ├── patient.0b.txt
│   │   ├── patients.10.csv
│   │   ├── patients.11.csv
│   │   ├── patients.12.csv
│   │   ├── patients.13.csv
│   │   ├── patients.14.csv
│   │   ├── patients.15.csv
│   │   ├── patients.16.csv
│   │   ├── patients.17.csv
│   │   ├── patients.18.csv
│   │   ├── patients.19.csv
│   │   ├── patients.1.csv
│   │   ├── patients.20.csv
│   │   ├── patients.2.csv
│   │   ├── patients.3.csv
│   │   ├── patients.4.csv
│   │   ├── patients.5.csv
│   │   ├── patients.6.csv
│   │   ├── patients.7.csv
│   │   ├── patients.8.csv
│   │   ├── patients.9.csv
│   │   └── patients.csv
│   └── treatment
│       ├── backup
│       │   └── 10May2019-235536-0700.tar
│       ├── treatments.10.csv
│       ├── treatments.11.csv
│       ├── treatments.12.csv
│       ├── treatments.13.csv
│       ├── treatments.14.csv
│       ├── treatments.15.csv
│       ├── treatments.16.csv
│       ├── treatments.17.csv
│       ├── treatments.18.csv
│       ├── treatments.19.csv
│       ├── treatments.1.csv
│       ├── treatments.20.csv
│       ├── treatments.2.csv
│       ├── treatments.3.csv
│       ├── treatments.4.csv
│       ├── treatments.5.csv
│       ├── treatments.6.csv
│       ├── treatments.7.csv
│       ├── treatments.8.csv
│       ├── treatments.9.csv
│       └── treatments.csv
└── treatments
    └── backup
        └── 10May2019-235536-0700.tar

	

3. Prepare the directory for backup by standardizing the filenames:

    - Your department uses the [ISO 8601](https://www.cl.cam.ac.uk/~mgk25/iso-time.html) standard for representing the date in the naming convention for all archives.    
        
        - Using the standard for representing the date, YYYY-MM-DD, allows sysadmins to locate an archive quickly.

        - Use the date **May 5, 2019** and convert it to the ISO 8601 format *without dashes*.
			20190505
    - Add the filename `epscript.tar` to the end of the ISO 8601 date.
		20190505epscript.tar
    - What will be the archive name?
		20190505epscript.tar
		
4.  Write a `tar` command that creates an archive with the following characteristics:
	
	tar cvvWpf 20190505escript.tar ./epscript/
	
    - Recall that `[ISO_8601_date]epscript.tar` is the archive file name.

    - The file backup will include the `epscript` directory and includes all directories and files contained within it.

    - File permission, owner, size, and date and time information are recorded for each file in the archive.

    - The archive is **verified** after writing it, in order to validate the integrity of the data.

        **Hint:** This is a new option. [See the man page](http://man7.org/linux/man-pages/man1/tar.1.html).

    - The output from the `tar` command is written to the file `[archive_name].txt` for later review by the SysOps team to check file structure, permissions, and errors.

        - Note: `archive_name` is the `tar` archive name you created using `[ISO_8601_date]epscript.tar`.

tar -cvvWpf 20190505epscript.tar ./epscript/ > 20190505epscript.txt


5.  Using the `less` command, review the output of the `.txt` file.

      - What is displayed in the output file?
	  Verify FILENAME

### Part 2: Restoring Backups with `tar`

The E-Prescription Treatment database was attacked and the database was taken offline. 

- Fortunately, the team had a recent full backup and was able to recover the database, making the system operational. However, a pharmacy technician noticed that some files in the Patient database were missing, and the team discovered that the wrong full backup was used. The system was taken offline again.

- It is critical that the missing patient files are restored as soon as possible. You have spoken to the pharmacy technician and received a list of the names of patients whose files are missing.  

You have been tasked to:

- List the contents of an archive to determine what it contains.

- Create a directory to restore the patient data for review.

- Extract only the patient files to the directory so they can be checked by the pharmacy technician. 

- Validate that the archive does not contain errors, using a new `tar` option.


### Instructions 

1. Move to the `~/Documents/epscript/backup` directory.
cd ~/Documents/epscript/backup

2. List the contents of the directory to display the `20190814epscript.tar` file. You will search this archive for the missing patient data.

tar tvvf 20190505epsctrip.tar

3. Extract the patient directory from the `20190814epscript.tar` archive.  

    - Extract patient data to the `patient_search` directory in the `~/Documents/epscript/backup` directory.   

    - Test for any errors when extracting. This will check the integrity of the archive.
	
tar xvvf 20190505epscript.tar -C ./patient_search/ ./epscript/testenvir/patient

4. List the contents of the `patient_search` directory to check that the patient directory and files were extracted there.  

tree patient_search 

#### Bonus

5. View the specific patient directory and file information contained within the archive.

    - Use `grep` to find the following two patient's file information located in the archive:
      - Mark Lopez
	  grep -iR "mark,lopez" ./patient_search
	  
      - Megan Patel
	  grep -iR "megan,patel" ./patient_search

---

© 2020 Trilogy Education Services, a 2U, Inc. brand. All Rights Reserved.  