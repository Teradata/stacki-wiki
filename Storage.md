# Configuring Storage on Backend Nodes

## Configure Hardware RAID Controllers
stacki can automatically configure two types of hardware RAID controllers:
1) LSI MegaRAID, and 2) HP Smart Array Controllers.

The configuration of a controller is driven through a spreadsheet. Here is a [sample spreadsheet](https://docs.google.com/spreadsheets/d/1MWSmqj8WWTp5OspQK8MxS8jYqH8PvwdHV-Kzyft2qJY/pubhtml).

There are four columns:

1. **Name**. A host name, appliance type or global.

2. **Slot**. The slot of a specific disk in the array.

3. **Raid Level**. The RAID level for the disks. This can be 0, 1, 5 or 6.

4. **Array Id**. The order in which the RAID groups will be constructed.

The _Name_ column can contain a specific host name (e.g., _node221_), an
appliance type (e.g., _backend_) or it can be set to _global_.

In the sample spreadsheet, we see the default configuration (_global_) is to
configure the disks in slot 0 and 1 as a RAID 1 mirror and make them the
first logical disk (the Linux kernel will see this as 'sda'). 
The remaining disks (the disks in slots 2 and up) will be configured as individual RAID 0 disks (also known as _JBOD mode_). 
We specify this with the wildcard symbol "*" for the _Slot_ and _Array Id_ cells.
Wildcards are useful when your backend hosts have different number of disks drives.

The next configuration is for all _backend_ hosts.
Like the _global_ configuration, the first two drives are configured as RAID 1 and they will be the first logical disk in the system (_sda_).
The disks in slots 2, 3 and 4 are configured as a RAID 5 and the disk in slot 6 will be available as a hot spare for this array and this array will be the second logical disk (_sdb_).

The third configuration is for the host named _node221_.
The first logical disk (_sda_) will be a RAID 1 and it will be constructed with the disk in slot 5 and the disk in slot 15.
The second logical disk (_sdb_) will be a RAID 5 composed of the disks in slots 0 through 4.
The third logical disk (_sdc_) will be a RAID 5 composed of the disks in slots 16 through 21.
The fourth logical disk (_sdd_) will be a RAID 6 composed of the disks in slots 6 through 12 and the disks in slots 13 and 14 will be hot spares associated with only this array.
The disks in slots 22 and 23 are designated as hot spares that can be used as replacements for any failed drive in any array.

nukecontroller attribute

nukecontroller reset to false after install

## Configure Partitions on Disks
Disk partitioning info here.

nukedisks attribute

nukedisks reset to false after install

Talk about LVM

Here is a [sample spreadsheet](https://docs.google.com/spreadsheets/d/1Hg-yEVgelArXvCGaHk5hTLKQsvNP3Cv9jvKYdOeRavI/pubhtml).



