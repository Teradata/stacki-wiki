Stacki requires a single dedicated server that will host all 
the software and services used to build out other servers. We 
call this server the **Frontend**, and the first step to running 
stacki is to build a Frontend. 

The process is fairly simple and looks similar to a standard Linux
build with the addition of a wizard to capture site-specific
networking information.

## Requirements 

A Frontend has the following hardware requirements.

**Resource** | Minimum | Recommended
--- | --- | ---
**System Memory** | 2 GB | 16 GB
**Network Interfaces** | 2 | 2
**Disk Capacity** | 64 GB | 200GB
**CD/DVD Device** | 1 | 1

BIOS _boot order_

1. CD/DVD Device
2. Hard Disk

Stacki allows you to place only the Frontend on your public network
and to then deploy all Backend servers on an isolated private network.
This recommended setup is shown below.

![](images/cluster-architecture-two-networks.png)

You may also place all Backend nodes on the public network and use
only a single network interface from the stacki Frontend, as shown
below.
If you choose to run in the configuration there are two additional
requirements.
First, the public network cannot have a DHCP server that would answer
a DHCP request from a Backend server (this is the Frontend's job).
Second, when in the Installation Wizard you will still need to
configure both interfaces.
But in this case simple configure the _Public_ and _Private_ with the
same network information but only cable the _Private_ one (yes this is
odd, but this is correct).

![](images/cluster-architecture-one-network.png) 



## New or Existing

Stacki can build you a Frontend from bare metal or it can be added on
top of an existing server.
If you wish to install stacki on top of an existing system skip to the
[Existing](#existing) section.

## New

Down the stacki jumbo dvd [here](?) and burn the file to a DVD or
mount it on the virtual media for the server to be installed.
This is going to completely erase and reformat the hard disks in the
machine, so be careful on your selection of hosts.

Boot the server with the DVD (or virtual media) mounted and the
following screen will apear after the BIOS is initialized.
If you don't see this go back to the [requirements](#requirements) and
make sure the DVD is the first in the boot order.

![](images/stack-iso-boot.png)

You can hit enter or just wait a few seconds and the stacki
Frontent installation will begin and you will soon see the
[Installation Wizard](#installation-wizard)

## Existing

In addition to the [requirements](#requirements) for Frontends,
installing stacki on top of a previous build host requires that host
must be running the x86_64 version of CentOS 6.x or RHEL 6.x.

Log into the Gnome (or generic X11) environment on the servers console
as root.
You must be root and X11 is required.

To start the installation download two ISOs and put them on your server:

1. **stacki**. The stacki ISO can be found [here](http://stacki.s3.amazonaws.com/1.0/stacki-1.0-I.x86_64.disk1.iso).

2. **CentOS** or **RHEL** installation ISO. A CentOS installation ISO can be found [here](http://isoredirect.centos.org/centos/6/isos/x86_64/).

Mount the stacki ISO:

    mount -o loop stacki*iso /media

Copy frontend-install.py from the ISO to your local disk:


    cp /media/frontend-install.py /tmp


Execute frontend-install.py:


    /tmp/frontend-install.py /path/to/stacki*iso stacki 1.0 /path/to/CentOS*iso CentOS 6.6


The above step will take several minutes to complete,
when it completes you can continue to the [Installation Wizard](#installation-wizard).


## Installation Wizard

### Cluster Information

The first screen will appear where you enter

1. _Name_ of the Cluster - for example "Demo"
2. _Fully Qualified Domain Name_ of the frontend (i.e., name.yourdomain.com)
3. _Email_ - Administrator Email
4. _Timezone_ of the cluster.

![](images/stacki_config_step_1b.png)

### Public Network
The public cluster network configuration screen allows you to set up the
networking parameters for the ethernet network that connects the frontend to the
outside network (e.g., the internet).

1. Select _Network Interface_ connected to the **Public network**.
2. _IP Address_ of Public interface
3. _Netmask_
4. _IP Address of the Public Gateway / Router_.
5. _DNS Servers_ - More than one DNS Server can be
   entered as a comma-separated list (i.e., 8.8.8.8, 4.2.2.2, 8.8.4.4).

On clicking "Next", the wizard configures the network interface
to the provided information.

![](images/stacki_config_step_2b.png)

### Private Network
The private network configuration screen configures the
networking parameters for the ethernet network that
connects the frontend to the backend nodes.

1. Select _Network Interface_ connected to the **Private(Management) Network**.
2. _IP Address_ of the Private Interface
3. _Netmask_

On clicking "Next", the wizard configures the network interface
to the provided information.

![](images/stacki_config_step_3b.png)

### Password
Enter the password for the **root** account on the frontend.

![](images/stacki_config_step_4.png)

### Choose Partition

If _Automatic_ mode is selected, the installer will
repartition and reformat the first discovered hard drive
that is connected to the frontend. All other drives
connected to the frontend will be left untouched.

| Partition Name | Size |
| --------------- | ---- |
|       /        | 16GB |
|       /var     | 16GB |
|       swap     |  1GB | 
| /export (symbolically linked to /state/partition1)|remainder of root disk|

When using automatic partitioning, the installer repartitions
and reformats the first hard drive (e.g. _sda_) that the installer
discovers. All previous data on this drive will be erased.
All other drives will be left untouched. If you are unsure about how
the drives will be discovered in a multi-disk frontend,
select *Manual Partitioning*.

In _Manual_ mode, the installer brings up a partition setup
screen after the wizard exits. In this mode, specify at least 16 GB
for the root partition and a separate **/export** partition.

![](images/stacki_config_step_5.png)

### Add Pallets

Choose the _Pallets_ you want to install.
Booting from a DVD, pallets should automatically load onto the list for you to choose.

![](images/stacki_config_step_6a_2.png)

The "Id" column denotes pallets loaded from a DVD and the "Network" column denotes pallets from a network (not being used).

Select "stacki" and "os" pallets to install.

![](images/stacki_config_step_6b_2.png)

### Review

Review the installation parameters and click "Install" to proceed.

If this was a [New](#new) installation the Frontend will now format
its filesystems and copy the Pallets from the onto its hard disk.
Next it will install all the packages and configuration.
When this is complete the Frontend will reboot.

If this was an [Existing](#existing) the installer will finalize the
Frontent configuration, after this complete you must reboot the
Frontend.

    /sbin/init 6

![](images/stacki_config_step_7_2.png)


For either method your stacki Frontend is now ready.
