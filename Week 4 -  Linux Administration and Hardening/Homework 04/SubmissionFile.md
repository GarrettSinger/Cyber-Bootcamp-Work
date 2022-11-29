## Week 4 Homework Submission File: Linux Systems Administration

Please edit this file by adding the solution commands on the line below the prompt.

Save and submit the completed file for your homework submission.


### Step 1: Ensure/Double Check Permissions on Sensitive Files

1. Permissions on `/etc/shadow` should allow only `root` read and write access.

    - Command to inspect permissions:
	ls -l /etc/shadow

    - Command to set permissions (if needed):
	sudo chown root:root /etc/shadow
	sudo chmod 600 /etc/shadow
	

2. Permissions on `/etc/gshadow` should allow only `root` read and write access.

    - Command to inspect permissions:
	ls -l /etc/gshadow

    - Command to set permissions (if needed):
	sudo chown root:root /etc/gshadow
	sudo chmod 600 /etc/gshadow
	

3. Permissions on `/etc/group` should allow `root` read and write access, and allow everyone else read access only.

    - Command to inspect permissions:
	ls -l /etc/group

    - Command to set permissions (if needed):
	sudo chown root:root /etc/group
	sudo chmod 644 /etc/group
	

4. Permissions on `/etc/passwd` should allow `root` read and write access, and allow everyone else read access only.

    - Command to inspect permissions:
	ls -l /etc/passwd

    - Command to set permissions (if needed):
	sudo chown root:root /etc/passwd
	sudo chmod 644 /etc/passwd
	

### Step 2: Create User Accounts

1. Add user accounts for `sam`, `joe`, `amy`, `sara`, and `admin`.

    - Command to add each user account (include all five users):
	sudo adduser sam
	sudo adduser joe
	sudo adduser amy
	sudo adduser sara
	sudo adduser admin

2. Ensure that only the `admin` has general sudo access.

    - Command to add `admin` to the `sudo` group:
	sudo usermod -aG sudo admin

### Step 3: Create User Group and Collaborative Folder

1. Add an `engineers` group to the system.

    - Command to add group:
	sudo addgroup engineers

2. Add users `sam`, `joe`, `amy`, and `sara` to the managed group.

    - Command to add users to `engineers` group (include all four users):
	sudo usermod -aG engineers sam
	sudo usermod -aG engineers joe
	sudo usermod -aG engineers amy
	sudo usermod -aG engineers sara

3. Create a shared folder for this group at `/home/engineers`.

    - Command to create the shared folder:
	sudo mkdir /home/engineers

4. Change ownership on the new engineers' shared folder to the `engineers` group.

    - Command to change ownership of engineer's shared folder to engineer group:
	sudo chown :engineers engineers

### Step 4: Lynis Auditing

1. Command to install Lynis:
sudo apt install lynis -y

2. Command to see documentation and instructions:
man lynis

3. Command to run an audit:
sudo lynis audit system

4. Provide a report from the Lynis output on what can be done to harden the system.

    - Screenshot of report output:
sysadmin@UbuntuDesktop:~/Documents/testing/HW4$ cat lynis_audit 

[ Lynis 2.6.2 ]

################################################################################
  Lynis comes with ABSOLUTELY NO WARRANTY. This is free software, and you are
  welcome to redistribute it under the terms of the GNU General Public License.
  See the LICENSE file for details about using this software.

  2007-2018, CISOfy - https://cisofy.com/lynis/
  Enterprise support available (compliance, plugins, interface and tools)
################################################################################


[+] Initializing program
------------------------------------
  - Detecting OS...                                           [ DONE ]
  - Checking profiles...                                      [ DONE ]

  ---------------------------------------------------
  Program version:           2.6.2
  Operating system:          Linux
  Operating system name:     Ubuntu Linux
  Operating system version:  18.04
  Kernel version:            5.0.0
  Hardware platform:         x86_64
  Hostname:                  UbuntuDesktop
  ---------------------------------------------------
  Profiles:                  /etc/lynis/default.prf
  Log file:                  /var/log/lynis.log
  Report file:               /var/log/lynis-report.dat
  Report version:            1.0
  Plugin directory:          /etc/lynis/plugins
  ---------------------------------------------------
  Auditor:                   [Not Specified]
  Language:                  en
  Test category:             all
  Test group:                all
  ---------------------------------------------------
  - Program update status...                                  [ WARNING ]

      ===============================================================================
        Lynis update available
      ===============================================================================

        Current version is more than 4 months old

        Current version : 262   Latest version : 307

        Please update to the latest version.
        New releases include additional features, bug fixes, tests, and baselines.

        Download the latest version:

        Packages (DEB/RPM) -  https://packages.cisofy.com
        Website (TAR)      -  https://cisofy.com/downloads/
        GitHub (source)    -  https://github.com/CISOfy/lynis

      ===============================================================================


[+] System Tools
------------------------------------
  - Scanning available tools...
  - Checking system binaries...

[+] Plugins (phase 1)
------------------------------------
 Note: plugins have more extensive tests and may take several minutes to complete
  
  - Plugin: debian
    [
[+] Debian Tests
------------------------------------
  - Checking for system binaries that are required by Debian Tests...
    - Checking /bin...                                        [ FOUND ]
    - Checking /sbin...                                       [ FOUND ]
    - Checking /usr/bin...                                    [ FOUND ]
    - Checking /usr/sbin...                                   [ FOUND ]
    - Checking /usr/local/bin...                              [ FOUND ]
    - Checking /usr/local/sbin...                             [ FOUND ]
  - Authentication:
    - PAM (Pluggable Authentication Modules):
      - libpam-tmpdir                                         [ Not Installed ]
      - libpam-usb                                            [ Not Installed ]
  - File System Checks:
    - DM-Crypt, Cryptsetup & Cryptmount:
  - Software:
    - apt-listbugs                                            [ Not Installed ]
    - apt-listchanges                                         [ Not Installed ]
    - checkrestart                                            [ Not Installed ]
    - needrestart                                             [ Not Installed ]
    - debsecan                                                [ Not Installed ]
    - debsums                                                 [ Not Installed ]
    - fail2ban                                                [ Not Installed ]
]

[+] Boot and services
------------------------------------
  - Service Manager                                           [ systemd ]
  - Checking UEFI boot                                        [ DISABLED ]
  - Checking presence GRUB2                                   [ FOUND ]
    - Checking for password protection                        [ WARNING ]
  - Check running services (systemctl)                        [ DONE ]
        Result: found 47 running services
  - Check enabled services at boot (systemctl)                [ DONE ]
        Result: found 71 enabled services
  - Check startup files (permissions)                         [ OK ]

[+] Kernel
------------------------------------
  - Checking default run level                                [ RUNLEVEL 5 ]
  - Checking CPU support (NX/PAE)
    CPU support: PAE and/or NoeXecute supported               [ FOUND ]
  - Checking kernel version and release                       [ DONE ]
  - Checking kernel type                                      [ DONE ]
  - Checking loaded kernel modules                            [ DONE ]
      Found 117 active modules
  - Checking Linux kernel configuration file                  [ FOUND ]
  - Checking default I/O kernel scheduler                     [ NOT FOUND ]
  - Checking for available kernel update                      [ OK ]
  - Checking core dumps configuration                         [ DISABLED ]
    - Checking setuid core dumps configuration                [ PROTECTED ]
  - Check if reboot is needed                                 [ YES ]

[+] Memory and Processes
------------------------------------
  - Checking /proc/meminfo                                    [ FOUND ]
  - Searching for dead/zombie processes                       [ OK ]
  - Searching for IO waiting processes                        [ OK ]

[+] Users, Groups and Authentication
------------------------------------
  - Administrator accounts                                    [ OK ]
  - Unique UIDs                                               [ OK ]
  - Consistency of group files (grpck)                        [ OK ]
  - Unique group IDs                                          [ OK ]
  - Unique group names                                        [ OK ]
  - Password file consistency                                 [ SUGGESTION ]
  - Query system users (non daemons)                          [ DONE ]
  - NIS+ authentication support                               [ NOT ENABLED ]
  - NIS authentication support                                [ NOT ENABLED ]
  - sudoers file                                              [ FOUND ]
    - Check sudoers file permissions                          [ OK ]
  - PAM password strength tools                               [ SUGGESTION ]
  - PAM configuration files (pam.conf)                        [ FOUND ]
  - PAM configuration files (pam.d)                           [ FOUND ]
  - PAM modules                                               [ FOUND ]
  - LDAP module in PAM                                        [ NOT FOUND ]
  - Accounts without expire date                              [ OK ]
  - Accounts without password                                 [ OK ]
  - Checking user password aging (minimum)                    [ DISABLED ]
  - User password aging (maximum)                             [ DISABLED ]
  - Checking expired passwords                                [ OK ]
  - Checking Linux single user mode authentication            [ WARNING ]
  - Determining default umask
    - umask (/etc/profile)                                    [ NOT FOUND ]
    - umask (/etc/login.defs)                                 [ SUGGESTION ]
  - LDAP authentication support                               [ NOT ENABLED ]
  - Logging failed login attempts                             [ ENABLED ]

[+] Shells
------------------------------------
  - Checking shells from /etc/shells
    Result: found 4 shells (valid shells: 4).
    - Session timeout settings/tools                          [ NONE ]
  - Checking default umask values
    - Checking default umask in /etc/bash.bashrc              [ NONE ]
    - Checking default umask in /etc/profile                  [ NONE ]

[+] File systems
------------------------------------
  - Checking mount points
    - Checking /home mount point                              [ SUGGESTION ]
    - Checking /tmp mount point                               [ SUGGESTION ]
    - Checking /var mount point                               [ SUGGESTION ]
  - Query swap partitions (fstab)                             [ OK ]
  - Testing swap partitions                                   [ OK ]
  - Checking for old files in /tmp                            [ OK ]
  - Checking /tmp sticky bit                                  [ OK ]
  - Checking /var/tmp sticky bit                              [ OK ]
  - ACL support root file system                              [ ENABLED ]
  - Mount options of /                                        [ NON DEFAULT ]
  - Checking Locate database                                  [ FOUND ]
  - Disable kernel support of some filesystems
    - Discovered kernel modules: cramfs freevxfs jffs2 udf 

[+] USB Devices
------------------------------------
  - Checking usb-storage driver (modprobe config)             [ NOT DISABLED ]
  - Checking USB devices authorization                        [ ENABLED ]
  - Checking USBGuard                                         [ NOT FOUND ]

[+] Storage
------------------------------------
  - Checking firewire ohci driver (modprobe config)           [ DISABLED ]

[+] NFS
------------------------------------
  - Check running NFS daemon                                  [ NOT FOUND ]

[+] Name services
------------------------------------
  - Checking search domains                                   [ FOUND ]
  - Searching DNS domain name                                 [ UNKNOWN ]
  - Checking /etc/hosts
    - Checking /etc/hosts (duplicates)                        [ OK ]
    - Checking /etc/hosts (hostname)                          [ OK ]
    - Checking /etc/hosts (localhost)                         [ OK ]
    - Checking /etc/hosts (localhost to IP)                   [ OK ]

[+] Ports and packages
------------------------------------
  - Searching package managers
    - Searching dpkg package manager                          [ FOUND ]
      - Querying package manager
    - Query unpurged packages                                 [ FOUND ]
  - Checking security repository in sources.list file         [ OK ]
  - Checking APT package database                             [ OK ]
  - Checking vulnerable packages                              [ WARNING ]
  - Checking upgradeable packages                             [ SKIPPED ]
  - Checking package audit tool                               [ INSTALLED ]
    Found: apt-check

[+] Networking
------------------------------------
  - Checking IPv6 configuration                               [ ENABLED ]
      Configuration method                                    [ AUTO ]
      IPv6 only                                               [ NO ]
  - Checking configured nameservers
    - Testing nameservers
        Nameserver: 8.8.8.8                                   [ OK ]
        Nameserver: 127.0.0.53                                [ OK ]
    - Minimal of 2 responsive nameservers                     [ OK ]
  - Checking default gateway                                  [ DONE ]
  - Getting listening ports (TCP/UDP)                         [ DONE ]
      * Found 40 ports
  - Checking promiscuous interfaces                           [ OK ]
  - Checking waiting connections                              [ OK ]
  - Checking status DHCP client                               [ RUNNING ]
  - Checking for ARP monitoring software                      [ NOT FOUND ]

[+] Printers and Spools
------------------------------------
  - Checking cups daemon                                      [ RUNNING ]
  - Checking CUPS configuration file                          [ OK ]
    - File permissions                                        [ WARNING ]
  - Checking CUPS addresses/sockets                           [ FOUND ]
  - Checking lp daemon                                        [ NOT RUNNING ]

[+] Software: e-mail and messaging
------------------------------------
  - Postfix status                                            [ RUNNING ]
    - Postfix configuration                                   [ FOUND ]
      - Postfix banner                                        [ WARNING ]
  - Dovecot status                                            [ RUNNING ]

[+] Software: firewalls
------------------------------------
  - Checking iptables kernel module                           [ FOUND ]
    - Checking iptables policies of chains                    [ FOUND ]
      - Checking chain INPUT (table: filter, policy )         [ other ]
    - Checking for empty ruleset                              [ OK ]
    - Checking for unused rules                               [ FOUND ]
  - Checking host based firewall                              [ ACTIVE ]

[+] Software: webserver
------------------------------------
  - Checking Apache (binary /usr/sbin/apache2)                [ FOUND ]
      Info: Configuration file found (/etc/apache2/apache2.conf)
      Info: No virtual hosts found
    * Loadable modules                                        [ FOUND (114) ]
        - Found 114 loadable modules
          mod_evasive: anti-DoS/brute force                   [ NOT FOUND ]
          mod_reqtimeout/mod_qos                              [ FOUND ]
          ModSecurity: web application firewall               [ NOT FOUND ]
  - Checking nginx                                            [ FOUND ]
    - Searching nginx configuration file                      [ FOUND ]
      - Found nginx includes                                  [ 7 FOUND ]
    - Parsing configuration options
        - /etc/nginx/nginx.conf
        - /etc/nginx/modules-enabled/50-mod-http-geoip.conf
        - /etc/nginx/modules-enabled/50-mod-http-image-filter.conf
        - /etc/nginx/modules-enabled/50-mod-http-xslt-filter.conf
        - /etc/nginx/modules-enabled/50-mod-mail.conf
        - /etc/nginx/modules-enabled/50-mod-stream.conf
        - /etc/nginx/sites-enabled/default
      - SSL configured                                        [ NO ]
      - Checking log file configuration
        - Missing log files (access_log)                      [ NO ]
        - Disabled access logging                             [ NO ]
        - Missing log files (error_log)                       [ NO ]
        - Debugging mode on error_log                         [ NO ]

[+] SSH Support
------------------------------------
  - Checking running SSH daemon                               [ FOUND ]
    - Searching SSH configuration                             [ FOUND ]
    - SSH option: AllowTcpForwarding                          [ SUGGESTION ]
    - SSH option: ClientAliveCountMax                         [ SUGGESTION ]
    - SSH option: ClientAliveInterval                         [ OK ]
    - SSH option: Compression                                 [ SUGGESTION ]
    - SSH option: FingerprintHash                             [ OK ]
    - SSH option: GatewayPorts                                [ OK ]
    - SSH option: IgnoreRhosts                                [ OK ]
    - SSH option: LoginGraceTime                              [ OK ]
    - SSH option: LogLevel                                    [ SUGGESTION ]
    - SSH option: MaxAuthTries                                [ SUGGESTION ]
    - SSH option: MaxSessions                                 [ SUGGESTION ]
    - SSH option: PermitRootLogin                             [ SUGGESTION ]
    - SSH option: PermitUserEnvironment                       [ OK ]
    - SSH option: PermitTunnel                                [ OK ]
    - SSH option: Port                                        [ SUGGESTION ]
    - SSH option: PrintLastLog                                [ OK ]
    - SSH option: Protocol                                    [ NOT FOUND ]
    - SSH option: StrictModes                                 [ OK ]
    - SSH option: TCPKeepAlive                                [ SUGGESTION ]
    - SSH option: UseDNS                                      [ OK ]
    - SSH option: UsePrivilegeSeparation                      [ NOT FOUND ]
    - SSH option: VerifyReverseMapping                        [ NOT FOUND ]
    - SSH option: X11Forwarding                               [ SUGGESTION ]
    - SSH option: AllowAgentForwarding                        [ SUGGESTION ]
    - SSH option: AllowUsers                                  [ NOT FOUND ]
    - SSH option: AllowGroups                                 [ NOT FOUND ]

[+] SNMP Support
------------------------------------
  - Checking running SNMP daemon                              [ NOT FOUND ]

[+] Databases
------------------------------------
    No database engines found

[+] LDAP Services
------------------------------------
  - Checking OpenLDAP instance                                [ NOT FOUND ]

[+] PHP
------------------------------------
  - Checking PHP                                              [ NOT FOUND ]

[+] Squid Support
------------------------------------
  - Checking running Squid daemon                             [ NOT FOUND ]

[+] Logging and files
------------------------------------
  - Checking for a running log daemon                         [ OK ]
    - Checking Syslog-NG status                               [ NOT FOUND ]
    - Checking systemd journal status                         [ FOUND ]
    - Checking Metalog status                                 [ NOT FOUND ]
    - Checking RSyslog status                                 [ FOUND ]
    - Checking RFC 3195 daemon status                         [ NOT FOUND ]
    - Checking minilogd instances                             [ NOT FOUND ]
  - Checking logrotate presence                               [ OK ]
  - Checking log directories (static list)                    [ DONE ]
  - Checking open log files                                   [ DONE ]
  - Checking deleted files in use                             [ FILES FOUND ]

[+] Insecure services
------------------------------------
  - Checking inetd status                                     [ NOT ACTIVE ]

[+] Banners and identification
------------------------------------
  - /etc/issue                                                [ FOUND ]
    - /etc/issue contents                                     [ WEAK ]
  - /etc/issue.net                                            [ FOUND ]
    - /etc/issue.net contents                                 [ WEAK ]

[+] Scheduled tasks
------------------------------------
  - Checking crontab/cronjob                                  [ DONE ]

[+] Accounting
------------------------------------
  - Checking accounting information                           [ NOT FOUND ]
  - Checking sysstat accounting data                          [ NOT FOUND ]
  - Checking auditd                                           [ NOT FOUND ]

[+] Time and Synchronization
------------------------------------

[+] Cryptography
------------------------------------
  - Checking for expired SSL certificates [0/4]               [ NONE ]

[+] Virtualization
------------------------------------

[+] Containers
------------------------------------
    - Docker
      - Docker daemon                                         [ RUNNING ]
        - Docker info output (warnings)                       [ 1 ]
      - Containers
        - Total containers                                    [ 0 ]
    - File permissions                                        [ OK ]

[+] Security frameworks
------------------------------------
  - Checking presence AppArmor                                [ FOUND ]
    - Checking AppArmor status                                [ ENABLED ]
  - Checking presence SELinux                                 [ NOT FOUND ]
  - Checking presence grsecurity                              [ NOT FOUND ]
  - Checking for implemented MAC framework                    [ OK ]

[+] Software: file integrity
------------------------------------
  - Checking file integrity tools
    - Tripwire                                                [ FOUND ]
  - Checking presence integrity tool                          [ FOUND ]

[+] Software: System tooling
------------------------------------
  - Checking automation tooling
    - Ansible artifact                                        [ FOUND ]
  - Automation tooling                                        [ FOUND ]
  - Checking for IDS/IPS tooling                              [ NONE ]

[+] Software: Malware
------------------------------------
  - Checking chkrootkit                                       [ FOUND ]

[+] File Permissions
------------------------------------
  - Starting file permissions check

[+] Home directories
------------------------------------
  - Checking shell history files                              [ OK ]

[+] Kernel Hardening
------------------------------------
  - Comparing sysctl key pairs with scan profile
    - fs.protected_hardlinks (exp: 1)                         [ OK ]
    - fs.protected_symlinks (exp: 1)                          [ OK ]
    - fs.suid_dumpable (exp: 0)                               [ DIFFERENT ]
    - kernel.core_uses_pid (exp: 1)                           [ DIFFERENT ]
    - kernel.ctrl-alt-del (exp: 0)                            [ OK ]
    - kernel.dmesg_restrict (exp: 1)                          [ DIFFERENT ]
    - kernel.kptr_restrict (exp: 2)                           [ DIFFERENT ]
    - kernel.randomize_va_space (exp: 2)                      [ OK ]
    - kernel.sysrq (exp: 0)                                   [ DIFFERENT ]
    - kernel.yama.ptrace_scope (exp: 1 2 3)                   [ OK ]
    - net.ipv4.conf.all.accept_redirects (exp: 0)             [ OK ]
    - net.ipv4.conf.all.accept_source_route (exp: 0)          [ OK ]
    - net.ipv4.conf.all.bootp_relay (exp: 0)                  [ OK ]
    - net.ipv4.conf.all.forwarding (exp: 0)                   [ DIFFERENT ]
    - net.ipv4.conf.all.log_martians (exp: 1)                 [ DIFFERENT ]
    - net.ipv4.conf.all.mc_forwarding (exp: 0)                [ OK ]
    - net.ipv4.conf.all.proxy_arp (exp: 0)                    [ OK ]
    - net.ipv4.conf.all.rp_filter (exp: 1)                    [ OK ]
    - net.ipv4.conf.all.send_redirects (exp: 0)               [ DIFFERENT ]
    - net.ipv4.conf.default.accept_redirects (exp: 0)         [ DIFFERENT ]
    - net.ipv4.conf.default.accept_source_route (exp: 0)      [ DIFFERENT ]
    - net.ipv4.conf.default.log_martians (exp: 1)             [ DIFFERENT ]
    - net.ipv4.icmp_echo_ignore_broadcasts (exp: 1)           [ OK ]
    - net.ipv4.icmp_ignore_bogus_error_responses (exp: 1)     [ OK ]
    - net.ipv4.tcp_syncookies (exp: 1)                        [ OK ]
    - net.ipv4.tcp_timestamps (exp: 0 1)                      [ OK ]
    - net.ipv6.conf.all.accept_redirects (exp: 0)             [ DIFFERENT ]
    - net.ipv6.conf.all.accept_source_route (exp: 0)          [ OK ]
    - net.ipv6.conf.default.accept_redirects (exp: 0)         [ DIFFERENT ]
    - net.ipv6.conf.default.accept_source_route (exp: 0)      [ OK ]

[+] Hardening
------------------------------------
    - Installed compiler(s)                                   [ FOUND ]
    - Installed malware scanner                               [ FOUND ]

[+] Custom Tests
------------------------------------
  - Running custom tests...                                   [ NONE ]

[+] Plugins (phase 2)
------------------------------------

================================================================================

  -[ Lynis 2.6.2 Results ]-

  Warnings (5):
  ----------------------------
  ! Version of Lynis is very old and should be updated [LYNIS] 
      https://cisofy.com/controls/LYNIS/

  ! Reboot of system is most likely needed [KRNL-5830] 
    - Solution : reboot
      https://cisofy.com/controls/KRNL-5830/

  ! No password set for single mode [AUTH-9308] 
      https://cisofy.com/controls/AUTH-9308/

  ! Found one or more vulnerable packages. [PKGS-7392] 
      https://cisofy.com/controls/PKGS-7392/

  ! Found some information disclosure in SMTP banner (OS or software name) [MAIL-8818] 
      https://cisofy.com/controls/MAIL-8818/

  Suggestions (53):
  ----------------------------
  * Install libpam-tmpdir to set $TMP and $TMPDIR for PAM sessions [CUST-0280] 
      https://your-domain.example.org/controls/CUST-0280/

  * Install libpam-usb to enable multi-factor authentication for PAM sessions [CUST-0285] 
      https://your-domain.example.org/controls/CUST-0285/

  * Install apt-listbugs to display a list of critical bugs prior to each APT installation. [CUST-0810] 
      https://your-domain.example.org/controls/CUST-0810/

  * Install apt-listchanges to display any significant changes prior to any upgrade via APT. [CUST-0811] 
      https://your-domain.example.org/controls/CUST-0811/

  * Install debian-goodies so that you can run checkrestart after upgrades to determine which services are using old versions of libraries and need restarting. [CUST-0830] 
      https://your-domain.example.org/controls/CUST-0830/

  * Install needrestart, alternatively to debian-goodies, so that you can run needrestart after upgrades to determine which daemons are using old versions of libraries and need restarting. [CUST-0831] 
      https://your-domain.example.org/controls/CUST-0831/

  * Install debsecan to generate lists of vulnerabilities which affect this installation. [CUST-0870] 
      https://your-domain.example.org/controls/CUST-0870/

  * Install debsums for the verification of installed package files against MD5 checksums. [CUST-0875] 
      https://your-domain.example.org/controls/CUST-0875/

  * Install fail2ban to automatically ban hosts that commit multiple authentication errors. [DEB-0880] 
      https://cisofy.com/controls/DEB-0880/

  * Set a password on GRUB bootloader to prevent altering boot configuration (e.g. boot in single user mode without password) [BOOT-5122] 
      https://cisofy.com/controls/BOOT-5122/

  * Run pwck manually and correct any errors in the password file [AUTH-9228] 
      https://cisofy.com/controls/AUTH-9228/

  * Install a PAM module for password strength testing like pam_cracklib or pam_passwdqc [AUTH-9262] 
      https://cisofy.com/controls/AUTH-9262/

  * Configure minimum password age in /etc/login.defs [AUTH-9286] 
      https://cisofy.com/controls/AUTH-9286/

  * Configure maximum password age in /etc/login.defs [AUTH-9286] 
      https://cisofy.com/controls/AUTH-9286/

  * Set password for single user mode to minimize physical access attack surface [AUTH-9308] 
      https://cisofy.com/controls/AUTH-9308/

  * Default umask in /etc/login.defs could be more strict like 027 [AUTH-9328] 
      https://cisofy.com/controls/AUTH-9328/

  * To decrease the impact of a full /home file system, place /home on a separated partition [FILE-6310] 
      https://cisofy.com/controls/FILE-6310/

  * To decrease the impact of a full /tmp file system, place /tmp on a separated partition [FILE-6310] 
      https://cisofy.com/controls/FILE-6310/

  * To decrease the impact of a full /var file system, place /var on a separated partition [FILE-6310] 
      https://cisofy.com/controls/FILE-6310/

  * Disable drivers like USB storage when not used, to prevent unauthorized storage or data theft [STRG-1840] 
      https://cisofy.com/controls/STRG-1840/

  * Check DNS configuration for the dns domain name [NAME-4028] 
      https://cisofy.com/controls/NAME-4028/

  * Purge old/removed packages (1 found) with aptitude purge or dpkg --purge command. This will cleanup old configuration files, cron jobs and startup scripts. [PKGS-7346] 
      https://cisofy.com/controls/PKGS-7346/

  * Install debsums utility for the verification of packages with known good database. [PKGS-7370] 
      https://cisofy.com/controls/PKGS-7370/

  * Update your system with apt-get update, apt-get upgrade, apt-get dist-upgrade and/or unattended-upgrades [PKGS-7392] 
      https://cisofy.com/controls/PKGS-7392/

  * Install package apt-show-versions for patch management purposes [PKGS-7394] 
      https://cisofy.com/controls/PKGS-7394/

  * Consider running ARP monitoring software (arpwatch,arpon) [NETW-3032] 
      https://cisofy.com/controls/NETW-3032/

  * Access to CUPS configuration could be more strict. [PRNT-2307] 
      https://cisofy.com/controls/PRNT-2307/

  * You are advised to hide the mail_name (option: smtpd_banner) from your postfix configuration. Use postconf -e or change your main.cf file (/etc/postfix/main.cf) [MAIL-8818] 
      https://cisofy.com/controls/MAIL-8818/

  * Disable the 'VRFY' command [MAIL-8820:disable_vrfy_command] 
    - Details  : disable_vrfy_command=no
    - Solution : run postconf -e disable_vrfy_command=yes to change the value
      https://cisofy.com/controls/MAIL-8820/

  * Check iptables rules to see which rules are currently not used [FIRE-4513] 
      https://cisofy.com/controls/FIRE-4513/

  * Install Apache mod_evasive to guard webserver against DoS/brute force attempts [HTTP-6640] 
      https://cisofy.com/controls/HTTP-6640/

  * Install Apache modsecurity to guard webserver against web application attacks [HTTP-6643] 
      https://cisofy.com/controls/HTTP-6643/

  * Add HTTPS to nginx virtual hosts for enhanced protection of sensitive data and privacy [HTTP-6710] 
      https://cisofy.com/controls/HTTP-6710/

  * Consider hardening SSH configuration [SSH-7408] 
    - Details  : AllowTcpForwarding (YES --> NO)
      https://cisofy.com/controls/SSH-7408/

  * Consider hardening SSH configuration [SSH-7408] 
    - Details  : ClientAliveCountMax (3 --> 2)
      https://cisofy.com/controls/SSH-7408/

  * Consider hardening SSH configuration [SSH-7408] 
    - Details  : Compression (YES --> (DELAYED|NO))
      https://cisofy.com/controls/SSH-7408/

  * Consider hardening SSH configuration [SSH-7408] 
    - Details  : LogLevel (INFO --> VERBOSE)
      https://cisofy.com/controls/SSH-7408/

  * Consider hardening SSH configuration [SSH-7408] 
    - Details  : MaxAuthTries (6 --> 2)
      https://cisofy.com/controls/SSH-7408/

  * Consider hardening SSH configuration [SSH-7408] 
    - Details  : MaxSessions (10 --> 2)
      https://cisofy.com/controls/SSH-7408/

  * Consider hardening SSH configuration [SSH-7408] 
    - Details  : PermitRootLogin (WITHOUT-PASSWORD --> NO)
      https://cisofy.com/controls/SSH-7408/

  * Consider hardening SSH configuration [SSH-7408] 
    - Details  : Port (22 --> )
      https://cisofy.com/controls/SSH-7408/

  * Consider hardening SSH configuration [SSH-7408] 
    - Details  : TCPKeepAlive (YES --> NO)
      https://cisofy.com/controls/SSH-7408/

  * Consider hardening SSH configuration [SSH-7408] 
    - Details  : X11Forwarding (YES --> NO)
      https://cisofy.com/controls/SSH-7408/

  * Consider hardening SSH configuration [SSH-7408] 
    - Details  : AllowAgentForwarding (YES --> NO)
      https://cisofy.com/controls/SSH-7408/

  * Check what deleted files are still in use and why. [LOGG-2190] 
      https://cisofy.com/controls/LOGG-2190/

  * Add a legal banner to /etc/issue, to warn unauthorized users [BANN-7126] 
      https://cisofy.com/controls/BANN-7126/

  * Add legal banner to /etc/issue.net, to warn unauthorized users [BANN-7130] 
      https://cisofy.com/controls/BANN-7130/

  * Enable process accounting [ACCT-9622] 
      https://cisofy.com/controls/ACCT-9622/

  * Enable sysstat to collect accounting (no results) [ACCT-9626] 
      https://cisofy.com/controls/ACCT-9626/

  * Enable auditd to collect audit information [ACCT-9628] 
      https://cisofy.com/controls/ACCT-9628/

  * Run 'docker info' to see warnings applicable to Docker daemon [CONT-8104] 
      https://cisofy.com/controls/CONT-8104/

  * One or more sysctl values differ from the scan profile and could be tweaked [KRNL-6000] 
    - Solution : Change sysctl value or disable test (skip-test=KRNL-6000:<sysctl-key>)
      https://cisofy.com/controls/KRNL-6000/

  * Harden compilers like restricting access to root user only [HRDN-7222] 
      https://cisofy.com/controls/HRDN-7222/

  Follow-up:
  ----------------------------
  - Show details of a test (lynis show details TEST-ID)
  - Check the logfile for all details (less /var/log/lynis.log)
  - Read security controls texts (https://cisofy.com)
  - Use --upload to upload data to central system (Lynis Enterprise users)

================================================================================

  Lynis security scan details:

  Hardening index : 55 [###########         ]
  Tests performed : 240
  Plugins enabled : 1

  Components:
  - Firewall               [V]
  - Malware scanner        [V]

  Lynis Modules:
  - Compliance Status      [?]
  - Security Audit         [V]
  - Vulnerability Scan     [V]

  Files:
  - Test and debug information      : /var/log/lynis.log
  - Report data                     : /var/log/lynis-report.dat

================================================================================
  Notice: Lynis update available
  Current version : 262    Latest version : 307
================================================================================

  Lynis 2.6.2

  Auditing, system hardening, and compliance for UNIX-based systems
  (Linux, macOS, BSD, and others)

  2007-2018, CISOfy - https://cisofy.com/lynis/
  Enterprise support available (compliance, plugins, interface and tools)

================================================================================

  [TIP]: Enhance Lynis audits by adding your settings to custom.prf (see /etc/lynis/default.prf for all settings)

sysadmin@UbuntuDesktop:~/Documents/testing/HW4$ 

### Bonus
1. Command to install chkrootkit:
sudo apt install chkrootkit

2. Command to see documentation and instructions:
man chkrootkit

3. Command to run expert mode:
sudo chkrootkit -x

4. Provide a report from the chrootkit output on what can be done to harden the system.
    - Screenshot of end of sample output:
sysadmin@UbuntuDesktop:~/Documents/testing/HW4$ cat chkrootkit_audit 
ROOTDIR is `/'
Checking `amd'...                                           not found
Checking `basename'...                                      not infected
Checking `biff'...                                          not found
Checking `chfn'...                                          not infected
Checking `chsh'...                                          not infected
Checking `cron'...                                          not infected
Checking `crontab'...                                       not infected
Checking `date'...                                          not infected
Checking `du'...                                            not infected
Checking `dirname'...                                       not infected
Checking `echo'...                                          not infected
Checking `egrep'...                                         not infected
Checking `env'...                                           not infected
Checking `find'...                                          not infected
Checking `fingerd'...                                       not found
Checking `gpm'...                                           not found
Checking `grep'...                                          not infected
Checking `hdparm'...                                        not infected
Checking `su'...                                            not infected
Checking `ifconfig'...                                      not infected
Checking `inetd'...                                         not infected
Checking `inetdconf'...                                     not found
Checking `identd'...                                        not found
Checking `init'...                                          not infected
Checking `killall'...                                       not infected
Checking `ldsopreload'...                                   not infected
Checking `login'...                                         not infected
Checking `ls'...                                            not infected
Checking `lsof'...                                          not infected
Checking `mail'...                                          not found
Checking `mingetty'...                                      not found
Checking `netstat'...                                       not infected
Checking `named'...                                         not found
Checking `passwd'...                                        not infected
Checking `pidof'...                                         not infected
Checking `pop2'...                                          not found
Checking `pop3'...                                          not found
Checking `ps'...                                            not infected
Checking `pstree'...                                        not infected
Checking `rpcinfo'...                                       not found
Checking `rlogind'...                                       not found
Checking `rshd'...                                          not found
Checking `slogin'...                                        not infected
Checking `sendmail'...                                      not infected
Checking `sshd'...                                          not infected
Checking `syslogd'...                                       not tested
Checking `tar'...                                           not infected
Checking `tcpd'...                                          not found
Checking `tcpdump'...                                       not infected
Checking `top'...                                           not infected
Checking `telnetd'...                                       not found
Checking `timed'...                                         not found
Checking `traceroute'...                                    not infected
Checking `vdir'...                                          not infected
Checking `w'...                                             not infected
Checking `write'...                                         not infected
Checking `aliens'...                                        no suspect files
Searching for sniffer's logs, it may take a while...        nothing found
Searching for rootkit HiDrootkit's default files...         nothing found
Searching for rootkit t0rn's default files...               nothing found
Searching for t0rn's v8 defaults...                         nothing found
Searching for rootkit Lion's default files...               nothing found
Searching for rootkit RSHA's default files...               nothing found
Searching for rootkit RH-Sharpe's default files...          nothing found
Searching for Ambient's rootkit (ark) default files and dirs... nothing found
Searching for suspicious files and dirs, it may take a while... The following suspicious files and directories were found:  
/usr/lib/debug/.build-id /usr/lib/python2.7/dist-packages/ansible/galaxy/data/container/files/.git_keep /usr/lib/python2.7/dist-packages/ansible/galaxy/data/container/.travis.yml /usr/lib/python2.7/dist-packages/ansible/galaxy/data/container/templates/.git_keep /usr/lib/python2.7/dist-packages/ansible/galaxy/data/default/collection/roles/.git_keep /usr/lib/python2.7/dist-packages/ansible/galaxy/data/default/collection/docs/.git_keep /usr/lib/python2.7/dist-packages/ansible/galaxy/data/default/role/files/.git_keep /usr/lib/python2.7/dist-packages/ansible/galaxy/data/default/role/.travis.yml /usr/lib/python2.7/dist-packages/ansible/galaxy/data/default/role/templates/.git_keep /usr/lib/python2.7/dist-packages/ansible/galaxy/data/apb/files/.git_keep /usr/lib/python2.7/dist-packages/ansible/galaxy/data/apb/.travis.yml /usr/lib/python2.7/dist-packages/ansible/galaxy/data/apb/templates/.git_keep /usr/lib/python2.7/dist-packages/ansible/galaxy/data/network/files/.git_keep /usr/lib/python2.7/dist-packages/ansible/galaxy/data/network/.travis.yml /usr/lib/python2.7/dist-packages/ansible/galaxy/data/network/templates/.git_keep /lib/modules/5.0.0-23-generic/vdso/.build-id
/usr/lib/debug/.build-id /lib/modules/5.0.0-23-generic/vdso/.build-id
Searching for LPD Worm files and dirs...                    nothing found
Searching for Ramen Worm files and dirs...                  nothing found
Searching for Maniac files and dirs...                      nothing found
Searching for RK17 files and dirs...                        nothing found
Searching for Ducoci rootkit...                             nothing found
Searching for Adore Worm...                                 nothing found
Searching for ShitC Worm...                                 nothing found
Searching for Omega Worm...                                 nothing found
Searching for Sadmind/IIS Worm...                           nothing found
Searching for MonKit...                                     nothing found
Searching for Showtee...                                    nothing found
Searching for OpticKit...                                   nothing found
Searching for T.R.K...                                      nothing found
Searching for Mithra...                                     nothing found
Searching for LOC rootkit...                                nothing found
Searching for Romanian rootkit...                           nothing found
Searching for Suckit rootkit...                             nothing found
Searching for Volc rootkit...                               nothing found
Searching for Gold2 rootkit...                              nothing found
Searching for TC2 Worm default files and dirs...            nothing found
Searching for Anonoying rootkit default files and dirs...   nothing found
Searching for ZK rootkit default files and dirs...          nothing found
Searching for ShKit rootkit default files and dirs...       nothing found
Searching for AjaKit rootkit default files and dirs...      nothing found
Searching for zaRwT rootkit default files and dirs...       nothing found
Searching for Madalin rootkit default files...              nothing found
Searching for Fu rootkit default files...                   nothing found
Searching for ESRK rootkit default files...                 nothing found
Searching for rootedoor...                                  nothing found
Searching for ENYELKM rootkit default files...              nothing found
Searching for common ssh-scanners default files...          nothing found
Searching for Linux/Ebury - Operation Windigo ssh...        not tested
Searching for 64-bit Linux Rootkit ...                      nothing found
Searching for 64-bit Linux Rootkit modules...               nothing found
Searching for Mumblehard Linux ...                          nothing found
Searching for Backdoor.Linux.Mokes.a ...                    nothing found
Searching for Malicious TinyDNS ...                         nothing found
Searching for Linux.Xor.DDoS ...                            INFECTED: Possible Malicious Linux.Xor.DDoS installed
/tmp/burpsuite_community_linux_v2020_11_3.sh
/tmp/vagrant-shell
/tmp/response.varfile
/tmp/str.sh
Searching for Linux.Proxy.1.0 ...                           nothing found
Searching for suspect PHP files...                          nothing found
Searching for anomalies in shell history files...           nothing found
Checking `asp'...                                           not infected
Checking `bindshell'...                                     not infected
Checking `lkm'...                                           chkproc: nothing detected
chkdirs: nothing detected
Checking `rexedcs'...                                       not found
Checking `sniffer'...                                       lo: not promisc and no packet sniffer sockets
enp0s3: PACKET SNIFFER(/sbin/dhclient[17713])
docker0: not promisc and no packet sniffer sockets
Checking `w55808'...                                        not infected
Checking `wted'...                                          chkwtmp: nothing deleted
Checking `scalper'...                                       not infected
Checking `slapper'...                                       not infected
Checking `z2'...                                            chklastlog: nothing deleted
Checking `chkutmp'...                                        The tty of the following user process(es) were not found
 in /var/run/utmp !
! RUID          PID TTY    CMD
! gdm          2053 tty1   /usr/bin/Xwayland :1024 -rootless -terminate -accessx -core -listen 4 -listen 5 -displayfd 6
! gdm          2007 tty1   /usr/lib/gdm3/gdm-wayland-session gnome-session --autostart /usr/share/gdm/greeter/autostart
! gdm          2012 tty1   /usr/lib/gnome-session/gnome-session-binary --autostart /usr/share/gdm/greeter/autostart
! gdm          2019 tty1   /usr/bin/gnome-shell
! gdm          2154 tty1   /usr/lib/gnome-settings-daemon/gsd-a11y-settings
! gdm          2159 tty1   /usr/lib/gnome-settings-daemon/gsd-clipboard
! gdm          2161 tty1   /usr/lib/gnome-settings-daemon/gsd-color
! gdm          2163 tty1   /usr/lib/gnome-settings-daemon/gsd-datetime
! gdm          2172 tty1   /usr/lib/gnome-settings-daemon/gsd-housekeeping
! gdm          2173 tty1   /usr/lib/gnome-settings-daemon/gsd-keyboard
! gdm          2174 tty1   /usr/lib/gnome-settings-daemon/gsd-media-keys
! gdm          2178 tty1   /usr/lib/gnome-settings-daemon/gsd-mouse
! gdm          2182 tty1   /usr/lib/gnome-settings-daemon/gsd-power
! gdm          2190 tty1   /usr/lib/gnome-settings-daemon/gsd-print-notifications
! gdm          2191 tty1   /usr/lib/gnome-settings-daemon/gsd-rfkill
! gdm          2196 tty1   /usr/lib/gnome-settings-daemon/gsd-screensaver-proxy
! gdm          2202 tty1   /usr/lib/gnome-settings-daemon/gsd-sharing
! gdm          2206 tty1   /usr/lib/gnome-settings-daemon/gsd-smartcard
! gdm          2210 tty1   /usr/lib/gnome-settings-daemon/gsd-sound
! gdm          2213 tty1   /usr/lib/gnome-settings-daemon/gsd-wacom
! gdm          2153 tty1   /usr/lib/gnome-settings-daemon/gsd-xsettings
! gdm          2110 tty1   ibus-daemon --xim --panel disable
! gdm          2113 tty1   /usr/lib/ibus/ibus-dconf
! gdm          2276 tty1   /usr/lib/ibus/ibus-engine-simple
! gdm          2115 tty1   /usr/lib/ibus/ibus-x11 --kill-daemon
! sysadmin     6650 tty2   /usr/lib/firefox/firefox -contentproc -childID 3 -isForBrowser -prefsLen 945 -prefMapSize 240392 -jsInitLen 277748 -parentBuildID 20220330194208 -appDir /usr/lib/firefox/browser 6510 true tab
! sysadmin     6736 tty2   /usr/lib/firefox/firefox -contentproc -childID 4 -isForBrowser -prefsLen 8885 -prefMapSize 240392 -jsInitLen 277748 -parentBuildID 20220330194208 -appDir /usr/lib/firefox/browser 6510 true tab
! sysadmin     6606 tty2   /usr/lib/firefox/firefox -contentproc -childID 1 -isForBrowser -prefsLen 1 -prefMapSize 240392 -jsInitLen 277748 -parentBuildID 20220330194208 -appDir /usr/lib/firefox/browser 6510 true tab
! sysadmin     6737 tty2   /usr/lib/firefox/firefox -contentproc -childID 5 -isForBrowser -prefsLen 8885 -prefMapSize 240392 -jsInitLen 277748 -parentBuildID 20220330194208 -appDir /usr/lib/firefox/browser 6510 true tab
! sysadmin     6767 tty2   /usr/lib/firefox/firefox -contentproc -childID 6 -isForBrowser -prefsLen 9161 -prefMapSize 240392 -jsInitLen 277748 -parentBuildID 20220330194208 -appDir /usr/lib/firefox/browser 6510 true tab
! sysadmin     6799 tty2   /usr/lib/firefox/firefox -contentproc -childID 7 -isForBrowser -prefsLen 9309 -prefMapSize 240392 -jsInitLen 277748 -parentBuildID 20220330194208 -appDir /usr/lib/firefox/browser 6510 true tab
! sysadmin     6626 tty2   /usr/lib/firefox/firefox -contentproc -childID 2 -isForBrowser -prefsLen 85 -prefMapSize 240392 -jsInitLen 277748 -parentBuildID 20220330194208 -appDir /usr/lib/firefox/browser 6510 true tab
! sysadmin     2910 tty2   /usr/lib/xorg/Xorg vt2 -displayfd 3 -auth /run/user/1000/gdm/Xauthority -background none -noreset -keeptty -verbose 3
! sysadmin     6510 tty2   /usr/lib/firefox/firefox -new-window
! sysadmin     2908 tty2   /usr/lib/gdm3/gdm-x-session --run-script env GNOME_SHELL_SESSION_MODE=ubuntu gnome-session --session=ubuntu
! sysadmin     2932 tty2   /usr/lib/gnome-session/gnome-session-binary --session=ubuntu
! sysadmin     3101 tty2   /usr/bin/gnome-shell
! sysadmin     3564 tty2   /usr/bin/gnome-software --gapplication-service
! sysadmin     3266 tty2   /usr/lib/gnome-settings-daemon/gsd-a11y-settings
! sysadmin     3267 tty2   /usr/lib/gnome-settings-daemon/gsd-clipboard
! sysadmin     3262 tty2   /usr/lib/gnome-settings-daemon/gsd-color
! sysadmin     3277 tty2   /usr/lib/gnome-settings-daemon/gsd-datetime
! sysadmin     3371 tty2   /usr/lib/gnome-disk-utility/gsd-disk-utility-notify
! sysadmin     3278 tty2   /usr/lib/gnome-settings-daemon/gsd-housekeeping
! sysadmin     3279 tty2   /usr/lib/gnome-settings-daemon/gsd-keyboard
! sysadmin     3284 tty2   /usr/lib/gnome-settings-daemon/gsd-media-keys
! sysadmin     3227 tty2   /usr/lib/gnome-settings-daemon/gsd-mouse
! sysadmin     3228 tty2   /usr/lib/gnome-settings-daemon/gsd-power
! sysadmin     3234 tty2   /usr/lib/gnome-settings-daemon/gsd-print-notifications
! sysadmin     3316 tty2   /usr/lib/gnome-settings-daemon/gsd-printer
! sysadmin     3235 tty2   /usr/lib/gnome-settings-daemon/gsd-rfkill
! sysadmin     3236 tty2   /usr/lib/gnome-settings-daemon/gsd-screensaver-proxy
! sysadmin     3240 tty2   /usr/lib/gnome-settings-daemon/gsd-sharing
! sysadmin     3245 tty2   /usr/lib/gnome-settings-daemon/gsd-smartcard
! sysadmin     3246 tty2   /usr/lib/gnome-settings-daemon/gsd-sound
! sysadmin     3248 tty2   /usr/lib/gnome-settings-daemon/gsd-wacom
! sysadmin     3256 tty2   /usr/lib/gnome-settings-daemon/gsd-xsettings
! sysadmin     3136 tty2   ibus-daemon --xim --panel disable
! sysadmin     3140 tty2   /usr/lib/ibus/ibus-dconf
! sysadmin     3441 tty2   /usr/lib/ibus/ibus-engine-simple
! sysadmin     3144 tty2   /usr/lib/ibus/ibus-x11 --kill-daemon
! sysadmin     3362 tty2   nautilus-desktop
! root         7792 pts/0  /bin/sh /usr/sbin/chkrootkit
! root         8485 pts/0  ./chkutmp
! root         8487 pts/0  ps axk tty,ruser,args -o tty,pid,ruser,args
! root         8486 pts/0  sh -c ps axk "tty,ruser,args" -o "tty,pid,ruser,args"
! root         7791 pts/0  sudo chkrootkit
! sysadmin     6847 pts/0  bash
chkutmp: nothing deleted
Checking `OSX_RSPLUG'...                                    not tested


---
© 2020 Trilogy Education Services, a 2U, Inc. brand. All Rights Reserved.
