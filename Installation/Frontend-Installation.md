---
layout: page
title: Frontend Installation
permalink: /Frontend-Installation
---

Stacki requires a single server that will host all 
the software and services used to build out other servers. We 
call this server the **frontend**, and the first step to running 
Stacki is to build a frontend. 

The process is fairly simple and looks similar to a standard Linux
build with the addition of a wizard to capture site-specific
networking information.

## Requirements 
 
A frontend has the following hardware requirements

| Resource | Minimum | Recommended |
| -------- | ------- | ----------- |
| System Memory | 8 GB | 16 GB |
| Network Interfaces | 1 | 1 |
| Disk Capacity | 100 GB | 200 GB |
| CD/DVD Device | 1 | 1 |

BIOS _boot order_
 
1. CD/DVD Device
2. Hard Disk

In the simplest configuration, Stacki assumes a single network for all
servers.
Stacki refers to the single network as the _private_ network, 
and often this will be an isolated network.
This default setup in shown below.

![](images/cluster-architecture-network.png)  

The private network cannot have a DHCP server that would answer 
a DHCP request from a backend server. The frontend provides DHCP
services on the private network, and any additional DHCP server
would cause conflicts on the network.

> Stacki 1.x requires a _public_ and _private_ network

## New or Existing

Stacki can build a [new](#new) frontend from bare metal or it can be added on
top of an existing server.
If you wish to install Stacki on top of an existing system, skip to the
section labeled [existing](#existing).

### New

Download the Stacki jumbo ISO file.
   * Stacki 6.x version is available [here](http://stacki.s3.amazonaws.com/public/pallets/4.0/open-source/stackios-4.0-6.x.x86_64.disk1.iso)
   * Stacki 7.x version is available [here](http://stacki.s3.amazonaws.com/public/pallets/4.0/open-source/stackios-4.0_c4aff2a-7.x.x86_64.disk1.iso)

Burn the file to a DVD or mount it on the virtual media for the server to be installed.
Installing a frontend will completely erase and reformat the hard disks in the
server. So use caution when deciding which server to designate as your frontend.

Boot the server with the DVD (or virtual media mounted) and the
following screen will appear after the BIOS is initialized:

![](images/stack-iso-boot.png)

If you don't see the above screen, go back to
the [requirements](#requirements) section and
make sure the DVD is the first entry in the boot order.

You can hit enter or just wait a few seconds and the Stacki
frontend installation will begin, and you will soon see the
[Installation Wizard](#installation-wizard).

### Existing

A Stacki frontend can be installed on top of an existing Red Hat based server.
The server must be running the x86_64 version of CentOS or RHEL version 6.x or
7.x.  **IMPORTANT**: During the Stacki installation it is possible that Stacki will overwrite certain system files.  Please don't install onto an existing production server without prior testing.

To perform this installation, log into the frontend and download two files:

1. **Stacki ISO**. Download the Stacki ISO and put it on your server you want to transform into a Stacki frontend.
    * Stacki 6.x version is available [here](http://stacki.s3.amazonaws.com/public/pallets/4.0/open-source/stacki-4.0_20170427-6.x.x86_64.disk1.iso)
    * Stacki 7.x version is available [here](http://stacki.s3.amazonaws.com/public/pallets/4.0/open-source/stacki-4.0_20170414_c4aff2a-7.x.x86_64.disk1.iso)   
   **IMPORTANT**: It is important that you supply the _stacki_ ISO and not the _stackios_ ISO.

2. **stacki-fab RPM**. Download the [stacki-fab RPM](http://stacki.s3.amazonaws.com/public/pallets/4.0/open-source/stacki-fab-4.x-all.x86_64.rpm) and put it on the server you want to transform into a Stacki frontend.

Install the `stacki-fab` RPM:

    # rpm -i stacki-fab-4.x-all.x86_64.rpm

Execute frontend-install.py:

    # /opt/stack/bin/frontend-install.py --stacki-iso=stacki-4.0_20170414_c4aff2a-7.x.x86_64.disk1.iso

The above step will run several commands and will eventually display
the [Installation Wizard](#installation-wizard).


## Installation Wizard

### Timezone

The first screen will appear and you will be prompted to enter your timezone:

![](images/stacki_config_step_1b.png)

### Network

The network configuration screen allows you to set up the network that will
be used by the frontend to install backend hosts.

1. _Fully Qualified Host Name_ - Input the FQDN for the frontend.
2. Choose from the network _Devices_ to select the frontend's network interface.
3. _IP_ address of the interface.
4. _Netmask_.
5. _Gateway_.
5. _DNS Servers_ - More than one DNS Server can be entered as a comma-separated list (i.e., 8.8.8.8, 4.2.2.2, 8.8.4.4).

Click _Continue_ to configure the network interface. 

![](images/stacki_config_step_2b.png)

### Password

Enter the password for the **root** account on the frontend.  

![](images/stacki_config_step_4.png)

### Choose Partition

If _Automated_ mode is selected, the installer will
repartition and reformat the first discovered hard drive
that is connected to the frontend. All other drives
connected to the frontend will be left untouched.

| Partition Name | Size |
| -------------- | ---- |
|       /        | 16GB |
|       /var     | 16GB |
|       swap     |  1GB | 
| /export (symbolically linked to /state/partition1)|remainder of root disk|

When using automatic partitioning, the installer repartitions
and reformats the first hard drive (e.g. _sda_) that the installer
discovers. All previous data on this drive will be erased.
All other drives will be left untouched. If you are unsure about how
the drives will be discovered in a multi-disk frontend,
select _Manual_ mode.

In _Manual_ mode, the installer brings up a partition setup
screen after the wizard exits. In this mode, specify at least 16 GB
for the root partition and a separate /export partition. You should add
a swap partition, and /var if you have made / only 16GB.

![](images/stacki_config_step_5.png)

### Add Pallets

Choose the _Pallets_ you want to install.
Booting from a DVD, pallets should automatically load onto the list for you to choose.

Select _stacki_ and _os_ pallets to install.

![](images/stacki_config_step_6a_2.png)

### Review

Review the installation parameters and click _Continue_ to proceed.

![](images/stacki_config_step_7_2.png) 

#### New

If this was a [new](#new) installation, the frontend will now format
its filesystems and copy the pallets from the DVD onto its hard disk.
Next, it will install all the packages and then run post configuration
scripts.
When this completes, the frontend will reboot.
Your Stacki frontend is now ready to install backend servers.

#### Existing

If this was an [existing](#existing) installation, after the
_frontend-install.py_ program completes, you must reboot the frontend:

    # reboot

After the server reboots, you need to add an **OS pallet**.
This OS pallet will be used as the base OS to install onto the backend nodes.
This will be either the CentOS installation DVD(s) or the Red Hat installation
DVD.

For example, to add the CentOS 7.3 DVD to the Stacki frontend, first download the
CentOS 7 Everything ISO (CentOS-7-x86_64-Everything-1611.iso) to the frontend then execute:

    # stack add pallet CentOS-7-x86_64-Everything-1611.iso

Then _enable_ the CentOS pallet (this makes the CentOS repository on the Stacki
frontend available for backend installs):

    # stack enable pallet CentOS
    # stack list pallet

Should produce output similar to:

```
NAME    VERSION                 RELEASE ARCH   OS     BOXES
stacki: 4.0_20170414_c4aff2a    7.x     x86_64 redhat default
CentOS: 7                       7.x     x86_64 redhat default
```

