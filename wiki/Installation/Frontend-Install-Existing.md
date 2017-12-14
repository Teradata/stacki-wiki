### Install an existing frontend

A Stacki frontend can be installed on top of an existing Red Hat based server. The server must be running the x86_64 version of CentOS or RHEL 7.x.

**__REALLY IMPORTANT__**: During the Stacki installation it is possible that Stacki will overwrite certain system files.  Please don't install onto an existing production server without prior testing.

To perform this installation, log into the frontend and download two pallets and one RPM

**_IMPORTANT_**: It is very important that you supply the _stacki_ ISO and not the _stackios_ ISO. Very.

1. **Stacki ISO**. Download the Stacki ISO and put it on your server you want to transform into a Stacki frontend.

  [Stacki 5.0 (built for CentOS 7.x)](http://teradata-stacki.s3.amazonaws.com/release/stacki/5.x/stacki-5.0_20171128_b0ed4e3-redhat7.x86_64.disk1.iso) (md5: f4c021dd6d7febe1b72a2a8cb81c8a81)

2. **OS Pallet** You'll need ONE of the following OS pallets:
 * [The minimal OS (for stacki 5.0 - minimal CentOS 7.4)](http://teradata-stacki.s3.amazonaws.com/release/stacki/5.x/os-7.4_20171128-redhat7.x86_64.disk1.iso)
 * [CentOS 7.4](https://www.centos.org/download/mirrors/) Use the "Everything" or "DVD" ISOs.
 * Oracle Linux 7.4 - You have a subscription right?
 * RedHat 7.4. - You have subscription right?
 * Scientific Linux - It's out there somewhere. Someone used to use it.

3. **stacki-fab RPM**. Download the [stacki-fab RPM](http://stacki.s3.amazonaws.com/public/pallets/4.0/open-source/stacki-fab-4.x_aa3f77e-all.x86_64.rpm) and put it on the server you want to transform into a Stacki frontend.

Install the `stacki-fab` RPM:

    # rpm -i stacki-fab-4.x_*-all.x86_64.rpm

Execute frontend-install.py:

    # /opt/stack/bin/frontend-install.py --stacki-iso=stacki-4.0_20170414_c4aff2a-7.x.x86_64.disk1.iso

The above step will run several commands and will eventually display
the [Installation Wizard](#installation-wizard).


## Installation Wizard

The Installation Wizard is the same for either the New or the Existing installation methods. The installation that happens after going through the wizard is either a typical CentOS/RHEL server install (New) or a set of script that run to create the Stacki software stack (Existing).

The Installation Wizard is now text-based, because, The 90s!

### Timezone

The first screen will appear and you will be prompted to enter your timezone:

![frontend_install_vbox_8](images/frontend/frontend_install_vbox_8.png)

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

![frontend_install_vbox_10](images/frontend/frontend_install_vbox_10.png)

### Password

Enter the password for the **root** account on the frontend.  This is also the root password for the backend nodes. Choose a better one than shown here.

![frontend_install_vbox_11](images/frontend/frontend_install_vbox_11.png)

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

![frontend_install_vbox_12](images/frontend/frontend_install_vbox_12.png)

### Add Pallets

Choose the _Pallets_ you want to install.

Booting from a DVD, pallets should automatically load onto the list for you to choose.

In an Existing installation you will only see the stacki pallet - even if you have supplied the --extra-isos parameter.

In New installation with the stackios pallet you should see two pallets: the the _stacki_ and _os_ pallets to install.

If you want to add pallets from another Stacki frontend or from a webserver hosting pallet ISOs, Choose _Add Pallets_ and supply the correct url. Once you've added all the pallets, choose _Continue_

![frontend_install_vbox_13](images/frontend/frontend_install_vbox_13.png)


### Summary

Review the installation parameters and click _Continue_ to proceed.

![frontend_install_vbox_14](images/frontend/frontend_install_vbox_14.png)

#### New

If this was a [new](#new) installation, the frontend will now format
its filesystems and copy the pallets from the DVD onto its hard disk.
Next, it will install all the packages and then run post configuration
scripts. When this completes, the frontend will reboot.

Check it to make sure you have what you think you have:

You should see one host:

```
# stack list host
HOST        RACK RANK APPLIANCE OS     BOX     ENVIRONMENT OSACTION INSTALLACTION STATUS COMMENT
stacki50    0    0    frontend  redhat default ----------- default  default       up
```

And you should see two pallets:

```
# stack list pallets
NAME   VERSION              RELEASE ARCH   OS     BOXES
os     7.4_20171128         redhat7 x86_64 redhat default
stacki 5.0_20171128_b0ed4e3 redhat7 x86_64 redhat default
```

Your Stacki frontend is now ready to [install backend servers](Backend-Installation).

#### Existing

If this was an [existing](#existing) installation, after the
_frontend-install.py_ program completes, you must reboot the frontend:

    # reboot

After the server reboots, you need to add an **OS pallet**.
This OS pallet will be used as the base OS to install onto the backend nodes.
This will be either the CentOS installation DVD(s) or the Red Hat installation DVD.

If you supplied these with the --extra-isos option, they should already be listed in a:

```
stack list pallet
```

To add an ISO pallet to the Stacki Frontend, using CentOS 7.4, first download the CentOS 7 Everything ISO (CentOS-7-x86_64-Everything-1708.iso) to the frontend then execute:

```
# stack add pallet CentOS-7-x86_64-Everything-1708.iso
```

Then _enable_ the CentOS pallet (this makes the CentOS repository on the Stacki frontend available for backend installs):

```
# stack enable pallet CentOS
# stack list pallet
```

Should produce output similar to:

```
NAME    VERSION                 RELEASE ARCH   OS     BOXES
stacki: 4.0_20170414_c4aff2a    7.x     x86_64 redhat default
CentOS: 7                       7.x     x86_64 redhat default
```

### UEFI and Stack 5.0

Really the issue is UEFI and Redhat. They shipped a bad grub2-efi rpm with the 7.4 release. Which means you need an updates pallet. You can go to [Creating-Simple-Pallets](Creating-Simple-Pallets) to produce your own updates ISO, or download the one we are distributing that has that fix in it.


One caveat with Stacki 5.0
