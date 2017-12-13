## Getting Started

Stacki is an extremely fast and scalable data center bare metal installer and is part of the Teradata family of open source projects - developed and supported by the Shared Services team at Teradata (formerly the wacky bunch of engineers from StackIQ).

So yeah, there's that.

On Stacki 5.0 we currently DO NOT support installing CentOS/RHEL 6.x systems.

If any of the terms below are unfamiliar to you, read the [Definitions](Definitions)

## Installation

You need one frontend and at least one backend.

You can't install a backend without a frontend.

You can't install a frontend without an OS pallet AND the stacki pallet.

Which means the [stackios](http://teradata-stacki.s3.amazonaws.com/release/stacki/5.x/stackios-5.0_20171128_b0ed4e3-redhat7.x86_64.disk1.iso)
pallet is ideal for the majority of you.

If you're an experiential learner and don't need/want explanations follow the [Quickstart](Quickstart).

If you have already installed a CentOS/RHEL/some variant and don't want to rebuild that server, follow: [Frontend Installation on Preinstalled System](Frontend-Installation-On-Preinstalled-Systemd).

If you don't have an installed frontend and need painfully detailed instructions, potentially HR-violating side commentary, and general ranting and railing, start with the full stackios iso and use: [Frontend Installation From ISO](Frontend-Installation-From-Iso).

If you don't actually have an internal or external DVD, use  [Frontend Installation From USB](Frontend-Installation-From-USB).

Then install backends. Either continue using the [Quickstart](Quickstart) or:

* If you control your installing network and you're lazy follow: [Backend Installation Via Discovery](Backend-Installation-Via-Discovery)
* If you have enterprise-y needs, i.e. you have neurotic, paranoid, and/or obstreperous security or network teams who require you to map hostname/ip/mac address to limit the DHCP queries to a subnet, use: [Backend Installation Via Spreadsheet](Backend-Installation-Via-Spreadsheet)

### Customization

If you give a mouse a cluster.....

Once you've done all that and have a default frontend and a default backend up, you'll want to start [Customization](Customization).

The general work flow is:

* Create a Cart
* Add packages and kickstart config
* Reinstall backend(s)
* Check/test.
* Fix or do more configuration.
* Rinse, repeat. Stop when happy.

### Downloads
Get them all right here:

** This pallet is THE recommended pallet **

[stackios-5.0_20171128_b0ed4e3-redhat7.x86_64.disk1.iso](http://teradata-stacki.s3.amazonaws.com/release/stacki/5.x/stackios-5.0_20171128_b0ed4e3-redhat7.x86_64.disk1.iso) (md5: 06a32c320cf8ed546c01d6f5cbe9d31c)

** Individual Pallets **

For building on an already installed server.

[stacki-5.0_20171128_b0ed4e3-redhat7.x86_64.disk1.iso](http://teradata-stacki.s3.amazonaws.com/release/stacki/5.x/stacki-5.0_20171128_b0ed4e3-redhat7.x86_64.disk1.iso) (md5: f4c021dd6d7febe1b72a2a8cb81c8a81)

**This is a minimal CentOS 7.4 1708 release.**

[os-7.4_20171128-redhat7.x86_64.disk1.iso](http://teradata-stacki.s3.amazonaws.com/release/stacki/5.x/os-7.4_20171128-redhat7.x86_64.disk1.iso) (md5: bc331bb2589fb2921b9b470e238824fa)

If you don't use the minimal os pallet above you need [CentOS 7.4](https://www.centos.org/download/mirrors/) DVD iso. I use Everything but you can use DVD.

AND

You need CentOS-Updates pallet if you're going to use UEFI. Don't come crying to us if you don't have the minimal os or the CentOS-Updates pallet. It's the first thing we're going to ask you. The second thing will be to check you md5 sums so do that too.

[CentOS-Updates-7.4_20171128-redhat7.x86_64.disk1.iso](http://teradata-stacki.s3.amazonaws.com/release/stacki/5.x/CentOS-Updates-7.4_20171128-redhat7.x86_64.disk1.iso) (md5: b69f015c30f004a1ff27aed49931144e)

If you're installing on a pre-installed CentOS/RHEL machine you'll need the frontend-install.py script as well:

[frontend-install.py](http://teradata-stacki.s3.amazonaws.com/release/stacki/5.x/frontend-install.py)(md5: f64fc40d45eee0c8f2538b4aeb769011)

Easier to read md5 sums:

stackios-5.0_20171128_b0ed4e3-redhat7.x86_64.disk1.iso = 06a32c320cf8ed546c01d6f5cbe9d31c

stacki-5.0_20171128_b0ed4e3-redhat7.x86_64.disk1.iso = f4c021dd6d7febe1b72a2a8cb81c8a81

os-7.4_20171128-redhat7.x86_64.disk1.iso = bc331bb2589fb2921b9b470e238824fa

CentOS-Updates-7.4_20171128-redhat7.x86_64.disk1.iso = b69f015c30f004a1ff27aed49931144e
