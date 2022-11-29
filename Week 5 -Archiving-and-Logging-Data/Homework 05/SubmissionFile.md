## Week 5 Homework Submission File: Archiving and Logging Data

Please edit this file by adding the solution commands on the line below the prompt.

Save and submit the completed file for your homework submission.

---

### Step 1: Create, Extract, Compress, and Manage tar Backup Archives

1. Command to **extract** the `TarDocs.tar` archive to the current directory:

tar xvvWf ./TarDocs.tar

2. Command to **create** the `Javaless_Doc.tar` archive from the `TarDocs/` directory, while excluding the `TarDocs/Documents/Java` directory:

tar -cvvWf Javaless_Doc.tar /TarDocs

3. Command to ensure `Java/` is not in the new `Javaless_Docs.tar` archive:

tar --exclude='./TarDocs/Documents/Java' -cvvWf Javaless_Docs.tar  ./TarDocs/


**Bonus** 
- Command to create an incremental archive called `logs_backup_tar.gz` with only changed files to `snapshot.file` for the `/var/log` directory:

sudo tar -czvvWf logs_backup_tar.gz --listed-incremental=snapshot.snar --level=0 /var/log


#### Critical Analysis Question

- Why wouldn't you use the options `-x` and `-c` at the same time with `tar`?

--- -c is to create and -x to extract. It makes no sense to create an archive just to extract it. You tell tar what to include when you create the archive. You can use -v, multiple even, to list the files info as they are compressed.

Likewise, You would not need to extract files to parse the contents when -t can be used to list the contents.

Using these two (-x and -c) in concert would be a massive waste of computing resources and inefficient to any task.


### Step 2: Create, Manage, and Automate Cron Jobs

1. Cron job for backing up the `/var/log/auth.log` file:

--- 0 6 * * 3 tar -czvf auth_log_bacup.tar.gz /var/log/auth.log 


### Step 3: Write Basic Bash Scripts

1. Brace expansion command to create the four subdirectories:

mkdir -p ~/backups/{freemem,diskuse,openlist,freedisk}

2. Paste your `system.sh` script edits below:

    ```bash
    free -h > ~/backups/freemem/freemem.txt
	df -h > ~/backups/freedisk/freedisk.txt
	lsof > ~/backups/openlist/openlist.txt
	du -h > ~/backups/diskuse/diskuse.txt
    ```

3. Command to make the `system.sh` script executable:

sudo chmod +x system.sh

**Optional**
- Commands to test the script and confirm its execution:

sudo ./system.sh

**Bonus**
- Command to copy `system` to system-wide cron directory:

---sudo cp system.sh /etc/cron.weekly/system

### Step 4. Manage Log File Sizes
 
1. Run `sudo nano /etc/logrotate.conf` to edit the `logrotate` configuration file. 

    Configure a log rotation scheme that backs up authentication messages to the `/var/log/auth.log`.

    - Add your config file edits below:

    ```bash
    /var/log/auth.log {
    missingok
    notifempty
    weekly
    compress
    delaycompress
    rotate 7
    }
    ```
---

### Bonus: Check for Policy and File Violations

1. Command to verify `auditd` is active:

sudo systemctl status auditd

2. Command to set number of retained logs and maximum log file size:

    - Add the edits made to the configuration file below:

    ```bash
    max_log_file = 7 
    num_logs = 35 

    ```

3. Command using `auditd` to set rules for `/etc/shadow`, `/etc/passwd` and `/var/log/auth.log`:


    - Add the edits made to the `rules` file below:

    ```bash
    -w /etc/shadow -p wa -k shadow
    -w /etc/passwd -p wa -k passwd
	-w /var/log/auth.log -p wa -k auth.log
    ```

4. Command to restart `auditd`:
sudo systemctl restart auditd

5. Command to list all `auditd` rules:
sudo auditctl -l

6. Command to produce an audit report:
sudo aureport

7. Create a user with `sudo useradd attacker` and produce an audit report that lists account modifications:

sysadmin@UbuntuDesktop:~$ sudo aureport -m

Account Modifications Report
=================================================
# date time auid addr term exe acct success event
=================================================
truncated
3. 04/18/2022 23:03:06 1000 UbuntuDesktop pts/1 /usr/sbin/useradd attacker yes 255986
4. 04/18/2022 23:03:06 1000 UbuntuDesktop pts/1 /usr/sbin/useradd ? yes 255987


8. Command to use `auditd` to watch `/var/log/cron`:

sudo auditctl -w /var/log/cron

9. Command to verify `auditd` rules:

sudo auditctl -l

---

### Bonus (Research Activity): Perform Various Log Filtering Techniques

1. Command to return `journalctl` messages with priorities from emergency to error:

sudo journalctl -p "emerg".."crit" 

1. Command to check the disk usage of the system journal unit since the most recent boot:

sudo journalctl -b 0 --disk-usage 

1. Comand to remove all archived journal files except the most recent two:

sudo journalctl --vacuum-files=2

1. Command to filter all log messages with priority levels between zero and two, and save output to `/home/sysadmin/Priority_High.txt`:

sudo journalctl -p "0".."2" >> ~/Priority_High.txt

1. Command to automate the last command in a daily cronjob. Add the edits made to the crontab file below:

    ```bash
    0 0 * * * journalctl -p "0".."2" >> ~/Priority_High.txt
    ```

---
© 2020 Trilogy Education Services, a 2U, Inc. brand. All Rights Reserved.
