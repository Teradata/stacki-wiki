
## Partitioning

Use a spreadsheet. Don't make me come over there.

[Why Stacki Uses Spreadsheets](Using-Spreadsheets)


Like a storage controller config, partitioning config done in a spreadsheet is a best practice. You can see it, play with it, and validate your partition config when it's loaded.


### Spreadsheet

The configuration of disk partitions can be specified in a
spreadsheet with the following columns:

1. **Name**. A host name, appliance type or 'global'.
1. **Device**. The Linux disk device name (e.g., ``sda``, ``sdb``).
1. **Mountpoint**. Where the partition should be mounted on the file system.
1. **Size**. The size of the partition in megabytes. '0' will instruct the installer to use the remaining available space of the device.
1. **Type**. How the partition should be formatted (e.g., xfs, swap).
1. **Options**. Free form string of options that can be used to create a partition.

An example spreadsheet is shown below.

> **Note**:  Example spreadsheets for partitioning configuration are also available on your frontend in `/opt/stack/share/examples/spreadsheets`. Look for files with 'partition' in the name.

| Name        | Device   | Mountpoint | Size  | Type     | Options               |
|:------------|:---------|:-----------|:------|:---------|:----------------------|
| global      | sda      | biosboot   | 1     | biosboot |                       |
|             | sda      | /          | 50000 | ext4     |                       |
|             | sda      | /var       | 80000 | ext4     |                       |
|             | sda      | swap       | 16000 | swap     |                       |
|             | sda      | /scratch   | 0     | xfs      |                       |
| backend     | sda      | biosboot   | 1     | biosboot |                       |
|             | sda      | /          | 50000 | ext4     |                       |
|             | sda      | /var       | 10000 | ext4     |                       |
|             | sda      | swap       | 16000 | swap     |                       |
|             | sda      | /scratch   | 1     | xfs      | --grow --maxsize=4000 |
|             | sdb      | /hadoop01  | 0     | xfs      |                       |
|             | sdc      | /hadoop02  | 0     | xfs      |                       |
| backend-0-1 | sda      | biosboot   | 1     | biosboot |                       |
|             | sda      | /          | 10000 | ext4     |                       |
|             | sda      | swap       | 1000  | swap     |                       |
|             | sdb      | pv.01      | 8000  | lvm      |                       |
|             | pv.01    | volgrp01   | 6000  | volgroup |                       |
|             | volgrp01 | /extra     | 4000  | ext4     | --name=extra          |


The _Name_ column can contain a specific host name (e.g., _backend-0-0_), an
Appliance type (e.g., _backend_) or it can be set to _global_.  

In the sample spreadsheet, we see the default configuration (_global_) is to
only configure the partitions for the first disk (``sda``).
The root partition ``/`` is an ext4 partition and it is 50 GB.
The ``/var`` partition is an ext4 partition and it is 80 GB.
The ``swap`` partition is 16 GB.
Lastly, ``/scratch`` is an xfs partition and it will be the remainder of ``sda``.

The default configuration for all backends, _backend_, has a similar configuration for ``sda`` as the _global_ configuration except for the ``/scratch`` partition. The maximum size of ``/scratch`` partition is set to 1 GB via the Options column.
Additionally, ``sdb`` and ``sdc`` will be configured for all _backends_ as single partitions that span the entire disk.

> **Note:** a "biosboot" partition must exist for any system disk on a CentOS/RHEL 7.x system. Make sure you define this.


### LVM

Stacki supports specifying LVM configuration via a spreadsheet. **lvm**, **volgroup** are keywords that indicate that the partition needs to be setup via LVM. In the configuration for ``backend-0-1``,
``pv.01`` is configured as a physical volume on ``sdb`` with size as 8GB.
``volgrp01`` is a volgroup comprising of ``pv.01``. ``/extra`` is mounted as an lvm partition on volgroup ``volgrp01``.

### Raid

Software raid can also be defined easily in a partition file. Do this instead of the dumb software RAID defined in the hardware BIOS your equally cheap and dumb Supermicro box came with.

| NAME    | DEVICE | MOUNTPOINT     | SIZE  | TYPE     | OPTIONS                       |
|:--------|:-------|:---------------|:------|:---------|:------------------------------|
| backend | md0    | /              | 0     | ext4     | --level=RAID1 raid.01 raid.02 |
|         | md1    | /boot          | 200   | ext4     | --level=RAID1 raid.03 raid.04 |
|         | md2    | /tmp           | 3192  | ext4     | --level=RAID1 raid.05 raid.06 |
|         | md3    | /var           | 20480 | ext4     | --level=RAID1 raid.07 raid.08 |
|         | md4    | /var/log       | 1024  | ext4     | --level=RAID1 raid.09 raid.10 |
|         | md5    | /var/log/audit | 20480 | ext4     | --level=RAID1 raid.11 raid.12 |
|         | sda    | biosboot       | 1     | biosboot |                               |
|         | sdb    | biosboot       | 1     | biosboot |                               |
|         | sda    | swap           | 8192  | swap     |                               |
|         | sdb    | swap           | 8192  | swap     |                               |
|         | sda    | raid.01        | 0     | raid     |                               |
|         | sdb    | raid.02        | 0     | raid     |                               |
|         | sda    | raid.03        | 200   | raid     |                               |
|         | sdb    | raid.04        | 200   | raid     |                               |
|         | sda    | raid.05        | 3192  | raid     |                               |
|         | sdb    | raid.06        | 3192  | raid     |                               |
|         | sda    | raid.07        | 20480 | raid     |                               |
|         | sdb    | raid.08        | 20480 | raid     |                               |
|         | sda    | raid.09        | 1024  | raid     |                               |
|         | sdb    | raid.10        | 1024  | raid     |                               |
|         | sda    | raid.11        | 20480 | raid     |                               |
|         | sdb    | raid.12        | 20480 | raid     |                               |


> **Note:** The 'biosboot' partition on both of the physical drives.


When you are finished editing your spreadsheet, save it as a CSV file, then copy the CSV file to your frontend.

Then, load the CSV file into the database on the frontend by executing:

```
# stack load storage partition file=partition.csv
```

You can view your storage partition configuration by executing:

```
# stack list storage partition
```

### The _nukedisks_ Attribute

A host's disk partitions will only be reconfigured if the _nukedisks_ attribute is set to _true_. On first install, all installing backend disks automatically have _nukedisks_ set to _false_. If you've added backend nodes via spreadsheet, you must set _nukedisks_ to _true_ as in the example below, before installing.

As an example, to set the _nukedisks_ attribute for host _backend-0-0_, execute:

```
# stack set host attr backend-0-0 attr=nukedisks value=true
```
For all hosts:

```
# stack set host attr a:backend attr=nukedisks value=true
```

Then, the next time _backend-0-0_ is installed, it will remove all partitions for all disks, then repartition the disks as you specified in your spreadsheet.

While a host is installing, after it partitions its disks, it will send a message to the frontend to instruct it to set the  _nukedisks_ attribute back to _false_.

This ensures that the disks will not be reconfigured on the next installation.
