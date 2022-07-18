## Activity File: `Sudo` Wrestling

So far, we have been using administrator privileges to stop processes, install software, copy sensitive files, run programs, and edit configuration files.

Now that we know users had weak passwords, we want to make sure none of them have unauthorized `sudo` access. The next steps provided by your senior administrator have to do with locking access to the compromised system, including `sudo` access.

In this activity, you will explore the `sudo + less` exploit, shown in the previous demonstration, and check the compromised system in order to determine if it is vulnerable. You will also edit the `sudoers` file to remove `sudo` access. Being able to determine what users or processes have root access and why is a core skill for a system administrator.

- This activity will use the same lab environment that you have been using for the previous activities.   
  -  Username: `sysadmin`   
    - Password: `cybersecurity`

### Instructions

1. Print the name of your current user to the terminal.
whoami

2. Determine what `sudo` privileges the sysadmin user has.
sudo -l

3. In a text document inside your research folder, record what `sudo` access each of the users on the system has.
mkdir ~/research/John
sudo -lU NAME >> ~/research/John/Sudo_Wrestiling

Finally some more automation work!

#Get Home UserNames
ls ~/../ -l | awk -F' ' '{print $4}' > ~/research/John/names

#For all machine users!
awk -F':' '{ print $1}' /etc/passwd > ~/research/John/names

#Script:

#!/bin/bash

Username="$HOME/research/John/names"
declare -a array
array=(`cat "Username"`)

for i in "${array[@]}"; do sudo -lU $i; done

#End Script

./Script.sh > $HOME/research/John/Sudo_Permissions

4. There is one user who has `sudo` access for the `less` command. Find that user and complete the following:

grep -i less John/Sudo_Permissions 

Max welcome

    - Switch to that user by using the password found in the previous activity.
	su max
	
    - Verify the vulnerability by dropping from `less` into a root shell.
	sudo less ./etc/shadow
	
	type !bin/bash and press enter
	
    - Exit back to the command line.
    type exit
	
	- Exit that user.
    type exit
	
**Bonus**    

5. From the sysadmin user, switch to the root user.
sudo su root

6. Check the `sudoers` file to see if there are any users listed there with `sudo` privileges.

visudo
All

7. Edit the `sudoers` file so that only the administrator user has access.
Remove line for max

8. Check that your changes to the `sudoers` file worked.
sudo -lU max

- :warning: **Trouble Shooting:** If the `sudoers` file becomes damaged, it could stop you from using `sudo` at all. To troubleshoot this, follow the thread here: [Ask Ubuntu: How to modify an invalid etc sudoers file](https://askubuntu.com/questions/73864/how-to-modify-an-invalid-etc-sudoers-file)

---

© 2020 Trilogy Education Services, a 2U, Inc. brand. All Rights Reserved.
