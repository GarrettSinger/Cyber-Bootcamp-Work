##  Activity File: Distribution Research

- Recently, your organization experienced a number of breaches involving servers running outdated Linux distributions.

- In response, the IT Department has decided to upgrade the affected servers, and chose you as the **system administrator** in charge of deciding which distribution to install on each machine.

- In this exercise, you will research the most common distributions of Linux and answer the following questions. Then you will use what you learn to determine which distribution is most appropriate for each machine on the network.

Be sure to ask your instructors and classmates for help if you get stuck.


### A. Resources and Research
Use the following links to answer the questions below:

- [Debian Linux](https://www.debian.org/intro/about)
- [Ubuntu Linux](https://www.ubuntu.com/download)
- [Kali Linux](https://www.kali.org/about-us/)
- [RedHat](https://www.redhat.com/en/technologies)
- [Fedora](https://getfedora.org/)
- [CentOS](https://www.centos.org/about/)
- [SELinux](https://selinuxproject.org/page/Main_Page)
- [Mint Breach](https://www.techrepublic.com/article/why-the-linux-mint-hack-is-an-indicator-of-a-larger-problem/)

### Questions

1. Which distribution is most flexible and best suited for day-to-day and administrative tasks?
Ubuntu

2. Which distribution is built specifically for penetration testers?
Kali linux

3. Which distributions would you use to set up a web or data server?
Really, you could use any of them, however, Ubuntu Server and Fedora Server both have easy-to-configure web services. If you wanted to do things more manually, you could use Debian or CentOS.

4. What is the most widely used Linux desktop environment?
Ubuntu

### B. Use Cases

Identify which distribution(s) is most appropriate for each situation. There may be more than one correct answer.

**Central Data Server**

- The Central Data Server stores all human resources data, including payroll information. Since its sole purpose is to send data to other machines, it won't have a monitor attached, and doesn't need a GUI.

CentOS

**Public Web Server**

- The Public Web Server must handle a large number of requests every day. It also doesn't need a GUI. Since the Web Server is central to business operations, it needs to run very quickly.

Fedora

**IT Audit Workstation**

- The IT Audit Workstation is used for periodic assessments of the security of the network.
Kali

**User Workstations**

- User Workstations need a GUI, and should include basic productivity software (such as LibreOffice, email clients, etc.)

Mint

### Bonus Questions

1. What is a "headless server"? Does Ubuntu make a headless server variant? What about Fedora? CentOS?

A server without a GUI. CL only
Yes Yes Yes

2. What distribution is Ubuntu based on? What about Kali?
Debian for both

3. Which distribution is CentOS based on? What about Fedora?
RedHat

4. What is SELinux? Which distributions implement SELinux by default?
Security enhanced Linux   
Android since 4.3, Fedora core 2, Debian since v9, Ubuntu since v8.04, openSUSE, CentOS

5. If you were deciding between versions of Ubuntu Server and wanted one that would remain stable over time, which version would you choose?

Long term support (LTS)
Mint has LTS

6. What are some security implications of using free and open source software or forks of popular Linux distributions?

Exploits may be found quicker for good or bad.

-------

© 2020 Trilogy Education Services, a 2U, Inc. brand. All Rights Reserved.

