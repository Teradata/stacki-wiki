# Configuring Storage on Backend Hosts

## Configure Hardware RAID Controllers
stacki can automatically configure two types of hardware RAID controllers:
1) LSI MegaRAID, and 2) HP Smart Array Controllers.

### Spreadsheet Configuration

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

### Applying the Spreadsheet Configuration to a Frontend

When you are finished editing your spreadsheet, save it as a CSV file, then copy the CSV file to your frontend.
Then, load the CSV file onto the frontend by executing:

`
stack load storage controller file=your-controller.csv
`

You can view your storage controller configuration by executing:

`
stack list storage controller
`

### The _nukecontroller_ Attribute

A host's hardware RAID controller will only be reconfigured if the _nukecontroller_ attribute is set to _true_.
As an example, to set the _nukecontroller_ attribute for host _node221_, execute:

`
stack set host attr node221 attr=nukecontroller value=true
`

Then, the next time _node221_ is installed, it will remove the current hardware RAID controller configuration, then configure it as you specified in your spreadsheet.

While a host is installing, after it configures its controller, it will send a message to the frontend to instruct it to set the  _nukecontroller_ attribute back to _false_.
This ensures that the controller will not be reconfigured on the next installation.


## Configure Partitions on Disks

### Spreadsheet Configuration

The configuration of partitions is driven through a spreadsheet.
Here is a [sample spreadsheet](https://docs.google.com/spreadsheets/d/1Hg-yEVgelArXvCGaHk5hTLKQsvNP3Cv9jvKYdOeRavI/pubhtml).

There are five columns:

1. **Name**. A host name, appliance type or global.

2. **Device**. The Linux disk device name (e.g., _sda_, _sdb_).

3. **Mountpoint**. Where the partition should be mounted on the file system.

4. **Size**. The size of the partition in megabytes.

5. **Type**. How the partition should be formatted (e.g., _xfs_, _swap_).

The _Name_ column can contain a specific host name (e.g., _node221_), an
appliance type (e.g., _backend_) or it can be set to _global_.

In the sample spreadsheet, we see the default configuration (_global_) is to
only configure the partitions for the first disk (_sda_).
The root partition _/_ is an ext4 partition and it is 50 GB.
The _/var_ partition is an ext4 partition and it is 80 GB.
The _swap_ partition is 16 GB.
Lastly, _/scratch_ is an xfs partition and it will be the remainder of _sda_.

The configuration for _node221_ has a similar configuration for _sda_ as the _global_ configuration.
Additionally, _sdb_ and _sdc_ will be configured for _node221_ as single partitions that span the entire disk.

### Applying the Spreadsheet Configuration to a Frontend

When you are finished editing your spreadsheet, save it as a CSV file, then copy the CSV file to your frontend.
Then, load the CSV file onto the frontend by executing:

`
stack load storage partition file=your-controller.csv
`

You can view your storage partition configuration by executing:

`
stack list storage partition
`

### The _nukedisks_ Attribute

A host's disk partitions will only be reconfigured if the _nukedisks_ attribute is set to _true_.
As an example, to set the _nukedisks_ attribute for host _node221_, execute:

`
stack set host attr node221 attr=nukedisks value=true
`

Then, the next time _node221_ is installed, it will remove all partitions for all disks, then repartition the disks as you specified in your spreadsheet.

While a host is installing, after it partitions its disks, it will send a message to the frontend to instruct it to set the  _nukedisks_ attribute back to _false_.
This ensures that the disks will not be reconfigured on the next installation.

### LVM Configuration via Spreadsheets

Currently, there is no support to configure logical volumes via spreadsheets. This feature is in development.

LVM configuration is supported in stacki. Please contact us for assistance.

