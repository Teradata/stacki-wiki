# Requirements:

 - A RedHat or CentOS version 7 iso
 - The Stacki Pro pallet v3.2+
 - The Stacki IPMI pallet v3.2+
 - After two weeks, a Stacki Pro license

# Setup:

#### Install stacki-pro pallet
	# stack add pallet stacki-pro-3.2-7.x.x86_64.disk1.iso
	# stack enable pallet stacki-pro
	# stack run pallet stacki-pro | bash
#### Reboot the frontend
	# reboot
#### Add the CentOS ISOs and enable them
	# stack add pallet CentOS-7-x86_64-Everything-1511.iso
	# stack add pallet CentOS-Updates-7.2-0.x86_64.disk1.iso 
	# stack enable pallet CentOS
	# stack enable pallet CentOS-Updates
#### Disable the stacki os pallet
	# stack disable pallet os
#### Install and run the IPMI pallet
	# stack add pallet ipmi-3.2-7.x.x86_64.disk1.iso
	# stack enable pallet ipmi
	# stack run pallet ipmi | bash
#### Add network for ipmi interfaces. Network name should be ipmi.
	# stack add network ipmi address=192.167.20.0 mask=255.255.240.0 gateway=192.168.19.1
#### Add ipmi username and password attributes. These can be added globally or on per host basis
	# stack add attr attr=ipmi_uname value=root
	# stack add attr attr=ipmi_pwd value=calvin
	# stack add host attr attr=ipmi_uname value=root
	# stack add host attr attr=ipmi_pwd value=calvin
#### Finally, start running the ipmi commands
	# stack set host power node221 action=hard_reset

# Notes:

The ipmi pallet supports a basic set of generic commands that can be run via ipmitool. 
* Power on/off
* Set boot order

For functionality such as mounting virtual media, please install vendor specific pallet like Dell-lightouts or Hp-lightsout.

#### Setting up serial console access
Serial console access involves setting up console redirection via the BIOS Sytem setup setting and enabling IPMI over LAN in the iDRAC or iLO settings. Below are the steps showing how this can be setup on a Dell iDRAC 7 server.

The System Setup screen is shown below.
![](ipmi/images/system-setup.png)

Let's look at the BIOS setup first. Choose the "Serial Communication" option as shown below.

![](ipmi/images/system-bios-settings-menu.png)

Make sure you are choosing the right NIC and setting "Redirection After Boot" to Enabled. Sometimes this step will require testing against different "Serial Communication" options until you find the combination that works for your machine.

![](ipmi/images/bios-serial-comm-settings.png)

Now lets tweak the iDRAC settings. Enable "Communication Pass Through" as below.

![](ipmi/images/idrac-enable-comm-pass-through)

Enable the NIC. Select the LOM for you NIC. Make sure it’s the "Active NIC Interface".

![](ipmi/images/enable-lom2.png)

Lastly make sure IPMI over LAN is enabled.

![](ipmi/images/enable-ipmi-over-lan.png)

##### Watching Installs over serial console
Machines need to be notified that they are going to pipe output to serial console. We do that by adding a "console=tty0 console=ttyS0,115200n8" to the bootaction line.


	# stack add bootaction action=”install serial” kernel=vmlinuz-3.1-x86_64 ramdisk=initrd.img-3.1-x86_64 args=”ip=bootif:dhcp inst.ks=https://10.1.1.1/install/sbin/kickstart.cgi inst.geoloc=0 inst.noverifyssl inst.ks.sendmac console=tty0 console=ttyS0,115200n8 ramdisk_size=150000”

You can also just create “install” to have those parameters then you don’t have worry about re-assigning the installaction. Otherwise, set the installaction for the backend nodes:

	# stack set host installaction backend action="install serial"



