# Table of Contents  
* [Introduction](#intro)
* [Install Stages](#installstages)
* [Design Architechture](#designarch)
* [Adding New Installation Stages](#addnewinstallstages)

<a name="intro"/>

# Introduction
checklist.py is written as a systemd service that runs on the frontend all the time and reports the status of backend installations as it progresses through the various states. Typically a backend installation will include the below stages and the backend is expected to progress linearly through these stages except for the 'Install Wait' or 'Install Stalled' stages.

**Usage - Redhat 7 or SLES 12:** /usr/bin/systemctl start|stop|restart checklist

**Usage - SLES 11:** service start|stop|restart checklist

**Usage - Debug Mode:** export STACKDEBUG=y;/opt/stack/bin/checklist.py

The installation messages will be written to /var/log/checklist.log

![](https://github.com/Teradata/stacki-wiki/blob/master/images/Stacki-Checklist-Install-Stages.png)

<a name="installstages"/>

# Installation Stages
Checklist code generates the below messages based on the OS type. Once the 'Reboot_Okay' stage is reached, the message list will be cleared to indicate the end of an install.

| Install Stage | Description | Supported in Redhat | Supported in SLES |
| :---          |     :---:      |          ---: |          ---: |
| DHCPDISCOVER  | DHCP Handshake message     | Yes    | Yes |
| DHCPOFFER     | DHCP Handshake message     | Yes    | Yes |
| DHCPREQUEST   | DHCP Handshake message     | Yes    | Yes |
| DHCPACK       | DHCP Handshake message     | Yes    | Yes |
| DHCPNACK       | DHCP Error message     | Yes    | Yes |
| DHCPDECLINE      | DHCP Error message    | Yes    | Yes |
| TFTP_RRQ | TFTP read request for pxelinux.cfg file received for the installing backend | Yes    | Yes |
| VMLinuz_RRQ_Install | TFTP read request for VMLinuz file received for the installing backend | Yes    | Yes |
| Initrd_RRQ | TFTP read request for InitRD file received for the installing backend | Yes    | Yes |
| Config_Sent | File sent to backend as part of installation | | Yes |
| Common_Sent | File sent to backend as part of installation | | Yes |
| Root_Sent | File sent to backend as part of installation | | Yes |
| Cracklib_Dict_Sent | File sent to backend as part of installation | | Yes |
| Bind_Sent | File sent to backend as part of installation | | Yes |
| SLES_Img_Sent | File sent to backend as part of installation | | Yes |
| Profile_XML_Sent | Installation profile file parsed and sent successfully to the backend | Yes    | Yes |
| SSH_Open| SSH Port 2200 open on the installing backend | | Yes |
| AUTOINST_Present| /tmp/profile/autoinst.xml is present on the installing backend with install profile information | | Yes |
| Partition_XML_Present | /tmp/stack_site/__init__.py is present on the installing backend with partition | | Yes|
| Ludicrous_Started | Ludicrous client has started on the installing backend | | Yes |
| Ludicrous_Populated | Ludicrous client has started downloading packages | | Yes |
| Set_DB_Partitions | Database partitions from the backend get written to the frontend | Yes    | Yes |
| Set_Bootaction_OS | bootaction is set to 'os' on the frontend for the installing backend | Yes    | Yes |
| Rebooting_HDD | Installing backend reboots from Hard disk on 1st boot after installation | Yes    | Yes |
| Reboot_Okay | 'ssh':'online' heartbeat message received for the installed backend on the 'health' channel | Yes    | Yes |
|Install_Wait | Install halted due to manually inserted /tmp/wait file for debugging purposes | | Yes |
|Install_Stalled | Install halted due to errors like missing packages etc| | Yes |

<a name="designarch"/>

# Design Architecture
## Daemon Design Architecture
Ways to monitor installation progress:

* Log Files - /var/log/messages, Http log files
* Message Queue
* Files on Installing Node - Parsing log files, other system files on the installing node.

checklist.py uses python threaded daemons to monitor the installation progress through all the above mediums.

**LogParser** - Tail's log files and monitors messages relevant to installation. Below is a list of log files that are read and parsed on the frontend.

| Message Type | SLES | Redhat |
| :--- | :---: | ---: |
| DHCP, TFTP messages | /var/log/messages | /var/log/messages |
| Get Install Profiles, Set Bootaction | /var/log/httpd/ssl_access_log , /var/log/httpd/access_log | /var/log/apache2/ssl_access_log, /var/log/apache2/access_log |

**MQProcessor** - Listens on the Stack Message Queue 'health' channel for messages relevant to backend installations.
**CheckTimeouts** - Triggers a timeout message if backend installation does not progress to the next state within a certain time span.

![](https://github.com/Teradata/stacki-wiki/blob/master/images/Stacki-Checklist-Daemons.png)

## Message Sharing - Design Architecture
Python Synchronized Queue's are used to share messages between the different threaded daemons. GlobalQueueAdder removes messages from localQ and adds it to the Shared Q. This is done to minimize Shared Q contention and to have the threaded daemons not spend time waiting to add messages to the Shared Q, especially during multiple backend installations.

![](https://github.com/Teradata/stacki-wiki/blob/master/images/Stacki-Checklist-Messages.png)

<a name="addnewinstallstages"/>

# Adding new install states
* Create an enum for the install state in class State(Enum) class.
* Add the enum in the 'class StateSequence' under the relevant OS dictionaries along with the time in seconds by which installation needs to progress to the next state. Make sure it is inserted into the correct place within the dictionary.
* Determine whether this state needs to be monitored in the frontend or installing backend.
   1. Frontend - If the state can be monitored through the log files mentioned above, then the existing code can be modified to accommodate this. If its a completely different functionality, a new daemon may need to be written similar to LogParser, MQProcessor etc. 
   2. Installing Backend - For example if a new state 'DISKS_NUKED' needs to be added, the smq-publish command can be called in the installation code in the below format:

>   
    state  = DISKS_NUKED
    isErr  = False
    msg    = ""
    cmd = ['/opt/stack/bin/smq-publish', 
        '-chealth', 
        '-t300',
        '{"systest":"%s","flag":"%s","msg":"%s"}' % (state, str(flag), msg)]

    pyenv = os.environ.copy()
    pyenv["LD_LIBRARY_PATH"] = "/opt/stack/lib/"

    if 'PYTHONPATH' in pyenv:
        del pyenv['PYTHONPATH']

    subprocess.run(cmd, env=pyenv)