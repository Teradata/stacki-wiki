## Release Notes-ish

### I sum up:

* Moved stacki code base to Python 3.6. You still don't have to learn it but you should.
* XML syntax has changed to Stacki Universal XML. Write carts once, deploy on multiple OSs.
* Partition NVME devices.
* Accept both upper and lower case attribute names.
* Rewrite of parallel installer.
* Pallet install from the network.
* Allows for duplicate IPs when IPs are on different VLANs.
* Set bootaction parameters.
* Health check in "stack list host"
* Parse per file xml rather than per directory.
* Pack/unpack carts you've created in the past.
* Create tftp boot files for multiple interfaces in RHEL/CentOS.
* Create bootfiles for networks with VLAN - dhcp over a VLAN.
* Install Facebook tftpd for greater resiliency. Not on by default.
* insert-ethers/discover-hosts now will take a --bootaction argument. (Do you like serial console? I like serial console. Now you can discover machines and watch them install the first time over serial.)

Moved some functionality from stacki-pro into stacki.
* UEFI (requires grub2-efi-x64 >= 1:2.02-0.65 because RedHat)
* Redis message queue for health status message. Get jiggy with it! Create your own!
* A rest api to the stack command line. (I know - right!)
* Network tests.
* Removed Salt.

And lots of bug fixes.
