---
layout: page
title: Stacki Enterprise
permalink: /Stacki-Enterprise
---

[Stacki Enterprise](http://stackiq.com/compare-stacki-editions/) installs on top of existing Stacki deployments by adding the Boss Pallet along with the complete CentOS media.  Stacki Enterprise adds a monitoring and management portal allowing administrators to perform routine operations via a GUI rather than operating at the command line.  Stacki Enterprise also adds tight integration with SaltStack for a seamless handoff from the provisioning layer to the devops layer.

## Installation

Stacki Enterprise can be installed on top of Stacki v3.  Once you have a Stacki [Frontend](Frontend-Installation) built you will need do to the following:

### Boss Pallet

[Download](http://www.stackiq.com/compare-stacki-editions/register-stacki-enterprise/) the Boss Pallet and copy the file to your Frontend.  Next add and enable the pallet like so:

        # stack add pallet boss*.iso
        # stack enable pallet boss

### Operating System

Stacki ships with a minimal CentOS distribution, but the Boss Pallet requires the full CenOS operating system.  You will need to download the complete CentOS .iso files and copy them to your Frontend and then add and enable them as well.

        # stack disable pallet os
        # stack add pallet CentOS*.iso
        # stack enable pallet CentOS

At this point you should have both the boss and CentOS pallets ready for use.

        # stack list pallet
        NAME    VERSION RELEASE ARCH   OS     BOXES  
        os:     6.7     6.x     x86_64 redhat default
        stacki: 3.0     6.x     x86_64 redhat default
        boss:   8.0     6.x     x86_64 redhat default
        CentOS: 6.7     ------- x86_64 redhat default

### License

You should have received (via email from Stackiq.com) a license in the form of an RPM for your Boss deployment.  You must install the license now in order to proceed.  Copy your license file to the Frontend and install it:

        # rpm -Uhv stackiq-*.rpm

> WARNING: Do NOT continue without the license installed.

### Frontend

The Frontend is now ready to be updated from Stacki to Stacki Enterprise.  The process will take several minutes but is automated.  Do the following, note the last step will reboot the Frontend.

        # stack run pallet boss | sh
        # /sbin/init 6

### Backend

If you already have Backend nodes installed with Stacki you will need to re-install them.  They will continue to function normally but none of the monitoring or management features of Stacki Enterprise will be functional until all of your Backend nodes are rebuilt.

