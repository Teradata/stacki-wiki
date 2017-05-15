---
layout: page
title: README dell lightsout
permalink: /README-dell-lightsout
---

# Requirements:

 - A RedHat or CentOS version 7 iso
 - The Stacki Pro pallet v3.2+
 - The Stacki IPMI pallet v3.2+
 - The Dell-lightsout pallet v3.2+
 - After two weeks, a Stacki Pro license

> At the end of the installation, you'll be able to test freely all the features available in the Dell-lightsout pallet - across as many nodes as you like. At the end of two weeks if a license file is not installed, your Stacki cluster will continue to run in Stacki Open Source mode, without the Dell-lightsout features.

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
#### Install and run the Dell-lightsout pallet
	# stack add pallet dell-lightsout-1.0-3.2.x86_64.disk1.iso
	# stack enable pallet dell-lightsout
	# stack run pallet dell-lightsout | bash
#### Finally, start running the dell-lightsout commands
	# stack set host vmedia node218 path=/export/stacki-os-3.1-7.x.x86_64.disk1.iso

# Notes:

The Dell pallet supports the below set of features. 
* Virtual remote console
* Mount virtual media
* Update firmware
* List MAC addresses of all interfaces


