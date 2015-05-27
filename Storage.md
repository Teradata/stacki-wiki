# Configuring Storage on Backend Nodes

## Configure Hardware RAID Controllers
stacki can automatically configure two types of hardware RAID controllers:
1) LSI MegaRAID, and 2) HP Smart Array Controllers.

The configuration of a controller is driven through a spreadsheet. Here is a [sample spreadsheet](https://docs.google.com/spreadsheets/d/1MWSmqj8WWTp5OspQK8MxS8jYqH8PvwdHV-Kzyft2qJY/pubhtml).

There are four columns:

1. Name. A host name, appliance type or global.

2. Slot. The slot of a specific disk in the array.

3. Raid Level. The RAID level for the disks. This can be 0, 1, 5 or 6.

4. Array Id. The order in which the RAID groups will be constructed.

The _Name_ column can contain a specific host name (e.g., _node221_), an appliance type (e.g., _backend_) or it can be set to _global_. In the sample spreadsheet, we see the default configuration (_global_) is to 



nukecontroller attribute

nukecontroller reset to false after install

## Configure Partitions on Disks
Disk partitioning info here.

nukedisks attribute

nukedisks reset to false after install

Talk about LVM

Here is a [sample spreadsheet](https://docs.google.com/spreadsheets/d/1Hg-yEVgelArXvCGaHk5hTLKQsvNP3Cv9jvKYdOeRavI/pubhtml).



