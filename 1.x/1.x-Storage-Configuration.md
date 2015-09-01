Stacki manages storage at both the [Partition](#partition) level and the hardware
[RAID Controller](#raid-controller) level.

## Partition

### Spreadsheet
 
The configuration of disk partitions can be specified in a
spreadsheet with the following columns:
  
1. **Name**. A host name, appliance type or global. 
1. **Device**. The Linux disk device name (e.g., ``sda``, ``sdb``). 
1. **Mountpoint**. Where the partition should be mounted on the file system. 
1. **Size**. The size of the partition in megabytes. 
1. **Type**. How the partition should be formatted (e.g., xfs, swap). 
 
A 
[sample spreadsheet](https://docs.google.com/spreadsheets/d/1C9XA1lNt15Ylnmq86bLoQ8Su_axByHH4IqCig30LVf4/pubhtml?gid=16332552&single=true) 
is shown below. 

![](images/sample-partition-configuration-csv.png) 
 
The _Name_ column can contain a specific host name (e.g., _backend-0-0_), an
Appliance type (e.g., _backend_) or it can be set to _global_.  
 
In the sample spreadsheet, we see the default configuration (_global_) is to
only configure the partitions for the first disk (``sda``).
The root partition ``/`` is an ext4 partition and it is 50 GB.
The ``/var`` partition is an ext4 partition and it is 80 GB.
The ``swap`` partition is 16 GB.
Lastly, ``/scratch`` is an xfs partition and it will be the remainder of ``sda``.
 
The configuration for _backend-0-0_ has a similar configuration for ``sda`` as the _global_ configuration.
Additionally, ``sdb`` and ``sdc`` will be configured for _backend-0-0_ as single partitions that span the entire disk.

When you are finished editing your spreadsheet, save it as a CSV file, then copy the CSV file to your frontend.
Then, load the CSV file into the database on the frontend by executing:

``` 
# stack load storage partition file=your-controller.csv
```
 
You can view your storage partition configuration by executing:

```
# stack list storage partition
```

### The _nukedisks_ Attribute
 
A host's disk partitions will only be reconfigured if the _nukedisks_ attribute is set to _true_. On first install, all installing backend disks automatically have _nukedisks_ set to _true_. If you've added backend nodes via spreadsheet, you must set _nukedisks_ to _true_ as in the example below, before installing.

As an example, to set the _nukedisks_ attribute for host _backend-0-0_, execute:

``` 
# stack set host attr backend-0-0 attr=nukedisks value=true
```
 
Then, the next time _backend-0-0_ is installed, it will remove all partitions for all disks, then repartition the disks as you specified in your spreadsheet.
 
While a host is installing, after it partitions its disks, it will send a message to the frontend to instruct it to set the  _nukedisks_ attribute back to _false_.
This ensures that the disks will not be reconfigured on the next installation.

### LVM
 
Currently, there is no support to configure logical volumes via spreadsheets. This feature is in development.
 
LVM configuration is supported in Stacki. Please contact us for assistance.



## RAID Controller

Stacki can automatically configure two types of hardware RAID controllers:

1. LSI MegaRAID
2. HP Smart Array

### Spreadsheet

The configuration of disk controllers can be specified in a
spreadsheet with the following columns:
  
1. **Name**. A host name, appliance type or global.  
1. **Slot**. The slot of a specific disk in the array.  
1. **Raid Level**. The RAID level for the disks. This can be 0, 1, 5 or 6.  
1. **Array Id**. The order in which the RAID groups will be constructed.  
 
A
[sample spreadsheet](https://docs.google.com/spreadsheets/d/1C9XA1lNt15Ylnmq86bLoQ8Su_axByHH4IqCig30LVf4/pubhtml?gid=1529833735&single=true)
is shown below.

![](images/sample-controller-configuration-csv.png) 

The _Name_ column can contain a specific host name (e.g., _backend-0-0_), an
appliance type (e.g., _backend_) or it can be set to _global_.

In the sample spreadsheet, we see the default configuration (_global_) is to
configure the disks in slot 0 and 1 as a RAID 1 mirror and make them the
first logical disk (the Linux kernel will see this as ```sda```). 
The remaining disks (the disks in slots 2 and up) will be configured as individual RAID 0 disks (also known as _JBOD mode_). 
We specify this with the wildcard symbol "*" for the _Slot_ and _Array Id_ cells.
Wildcards are useful when your backend hosts have different number of disks drives.

The next configuration is for all _backend_ hosts.
Like the _global_ configuration, the first two drives are configured as RAID 1 and they will be the first logical disk in the system (```sda```).
The disks in slots 2, 3 and 4 are configured as a RAID 5 and the disk in slot 6 will be available as a hot spare for this array and this array will be the second logical disk (```sdb```).

The third configuration is for the host named _backend-0-0_.
The first logical disk (```sda```) will be a RAID 1 and it will be constructed with the disk in slot 5 and the disk in slot 15.
The second logical disk (```sdb```) will be a RAID 5 composed of the disks in slots 0 through 4.
The third logical disk (```sdc```) will be a RAID 5 composed of the disks in slots 16 through 21.
The fourth logical disk (```sdd```) will be a RAID 6 composed of the disks in slots 6 through 12 and the disks in slots 13 and 14 will be hot spares associated with only this array.
The disks in slots 22 and 23 are designated as hot spares that can be used as replacements for any failed drive in any array.

When you are finished editing your spreadsheet, save it as a CSV file, then copy the CSV file to your frontend.
Then, load the CSV file into the database on the frontend by executing:

```
# stack load storage controller file=your-controller.csv
```

You can view your storage controller configuration by executing:

```
# stack list storage controller
```

### The _nukecontroller_ attribute

A host's hardware RAID controller will only be reconfigured if the _nukecontroller_ attribute is set to _true_.
As an example, to set the _nukecontroller_ attribute for host _backend-0-0_, execute:

```
# stack set host attr backend-0-0 attr=nukecontroller value=true
```

Then, the next time _backend-0-0_ is installed, it will remove the current hardware RAID controller configuration, then configure it as you specified in your spreadsheet.

Unlike the _nukedisks_ attribute, _nukecontroller_ is not set to _true_ on the initial installation of a backend node. If you or someone you've paid, has configured the RAID controller with a keyboard and monitor, that work won't be wiped out unless you specifically request it with _nukecontroller_.

While a host is installing, after it configures its controller, it will send a message to the frontend to instruct it to set the  _nukecontroller_ attribute back to _false_.
This ensures that the controller will not be reconfigured on the next installation.


