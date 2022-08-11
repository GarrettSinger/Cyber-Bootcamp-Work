## Activity File: Service Users

- In the previous activity, we stopped and removed a few old services from the system.

- In this activity, you will continue auditing the same server for your senior administrator.

- The senior administrator would like you to remove any old service users from the system and create a new user that will be dedicated to running the Tripwire program.

- To complete this activity, you will use the `adduser` and `deluser` commands with the correct flags to clean up the system and create this new Tripwire user. 

    - Tripwire can only be run as `root`, so you will also need to add a line to the `sudoers` file to allow this.

### Instructions

1. To clean up our system and to prevent any unwanted abuse of remnant service users, remove the following service users associated with the services that you removed in the previous activity:

    - Service users for the `vsftpd` service
	sudo deluser --remove-all-files ftp

    - **Note**: If you are stuck on where to find these service users, you can search through `/etc/passwd` for clues.

2. Create a `tripwire` user that will be dedicated to running Tripwire.

sudo adduser --system --no-create-home tripwire

    - Verify that this user is a service user.
	
	id tripwire

    - Verify that this user does not have a home folder.
	ls /home

    - Verify that this user is locked without a password.
	grep tripwire /etc/passwd

    - Verify that this user does not have a login shell.
	grep tripwire /etc/passwd



3. Add a line to the `sudoers` file to allow this user to run only `tripwire` using `sudo` privileges.

sudo nano /etc/sudoers
sudo visudo

4. Change the permission of the `tripwire` program to only allow the `owner` to execute.


find it: find . -type f -name tripwire
OR
which tripwire

sudo chmod 700 tripwire 

**Bonus**:

5. Remove the following service users associated with the services that you removed in the previous bonus activity:

   - Service users for any `dovecot`-related services.
   sudo deluser --remove-all-files dovecot

---

© 2020 Trilogy Education Services, a 2U, Inc. brand. All Rights Reserved.
