
## Partitioning



### Spreadsheet

The configuration of disk partitions can be specified in a
spreadsheet with the following columns:

1. **Name**. A host name, appliance type or 'global'.
1. **Device**. The Linux disk device name (e.g., ``sda``, ``sdb``).
1. **Mountpoint**. Where the partition should be mounted on the file system.
1. **Size**. The size of the partition in megabytes. '0' will instruct the installer to use the remaining available space of the device.
1. **Type**. How the partition should be formatted (e.g., xfs, swap).
1. **Options**. Free form string of options that can be used to create a partition.

A
[sample spreadsheet](https://docs.google.com/spreadsheets/d/1nukh3bwcgwhxXn1czhDawog_-srlXgCy7arh2m71-so/edit?usp=sharing)
is shown below.

| <sub>Name</sub>        | <sub>Device</sub>   | <sub>Mountpoint</sub> | <sub>Size</sub>  | <sub>Type</sub>     | <sub>Options</sub>                       |
|:-----------------------|:--------------------|:----------------------|:-----------------|:--------------------|:-----------------------------------------|
| <sub>global</sub>      | <sub>sda</sub>      | <sub>/</sub>          | <sub>50000</sub> | <sub>ext4</sub>     |                                          |
|                        | <sub>sda</sub>      | <sub>/var</sub>       | <sub>80000</sub> | <sub>ext4</sub>     |                                          |
|                        | <sub>sda</sub>      | <sub>swap</sub>       | <sub>16000</sub> | <sub>swap</sub>     |                                          |
|                        | <sub>sda</sub>      | <sub>/scratch</sub>   | <sub>0</sub>     | <sub>xfs</sub>      |                                          |
| <sub>backend-0-0</sub> | <sub>sda</sub>      | <sub>/</sub>          | <sub>50000</sub> | <sub>ext4</sub>     |                                          |
|                        | <sub>sda</sub>      | <sub>/var</sub>       | <sub>10000</sub> | <sub>ext4</sub>     |                                          |
|                        | <sub>sda</sub>      | <sub>swap</sub>       | <sub>16000</sub> | <sub>swap</sub>     |                                          |
|                        | <sub>sda</sub>      | <sub>/scratch</sub>   | <sub>1</sub>     | <sub>xfs</sub>      | <sub>--grow --maxsize=4000</sub>         |
|                        | <sub>sdb</sub>      | <sub>/hadoop01</sub>  | <sub>0</sub>     | <sub>xfs</sub>      |                                          |
|                        | <sub>sdc</sub>      | <sub>/hadoop02</sub>  | <sub>0</sub>     | <sub>xfs</sub>      |                                          |
| <sub>backend-0-1</sub> | <sub>sda</sub>      | <sub>biosboot</sub>   | <sub>1</sub>     | <sub>biosboot</sub> |                                          |
|                        | <sub>sda</sub>      | <sub>/</sub>          | <sub>10000</sub> | <sub>ext4</sub>     |                                          |
|                        | <sub>sda</sub>      | <sub>swap</sub>       | <sub>1000</sub>  | <sub>swap</sub>     |                                          |
|                        | <sub>sdb</sub>      | <sub>pv.01</sub>      | <sub>8000</sub>  | <sub>lvm</sub>      |                                          |
|                        | <sub>pv.01</sub>    | <sub>volgrp01</sub>   | <sub>6000</sub>  | <sub>volgroup</sub> |                                          |
|                        | <sub>volgrp01</sub> | <sub>/extra</sub>     | <sub>4000</sub>  | <sub>ext4</sub>     | <sub>--name=extra</sub>                  |
| <sub>backend-0-2</sub> | <sub>md0</sub>      | <sub>/</sub>          | <sub>0</sub>     | <sub>ext4</sub>     | <sub>--level=RAID1 raid.01 raid.02</sub> |
|                        | <sub>md1</sub>      | <sub>/var</sub>       | <sub>0</sub>     | <sub>xfs</sub>      | <sub>--level=RAID0 raid.03 raid.04</sub> |
|                        | <sub>md2</sub>      | <sub>/export</sub>    | <sub>0</sub>     | <sub>xfs</sub>      | <sub>--level=RAID1 raid.05 raid.06</sub> |
|                        | <sub>sda</sub>      | <sub>raid.01</sub>    | <sub>16000</sub> | <sub>raid</sub>     |                                          |
|                        | <sub>sdb</sub>      | <sub>raid.02</sub>    | <sub>16000</sub> | <sub>raid</sub>     |                                          |
|                        | <sub>sda</sub>      | <sub>raid.03</sub>    | <sub>16000</sub> | <sub>raid</sub>     |                                          |
|                        | <sub>sdb</sub>      | <sub>raid.04</sub>    | <sub>16000</sub> | <sub>raid</sub>     |                                          |
|                        | <sub>sda</sub>      | <sub>raid.05</sub>    | <sub>0</sub>     | <sub>raid</sub>     |                                          |
|                        | <sub>sdb</sub>      | <sub>raid.06</sub>    | <sub>0</sub>     | <sub>raid</sub>     |                                          |

The _Name_ column can contain a specific host name (e.g., _backend-0-0_), an
Appliance type (e.g., _backend_) or it can be set to _global_.  

In the sample spreadsheet, we see the default configuration (_global_) is to
only configure the partitions for the first disk (``sda``).
The root partition ``/`` is an ext4 partition and it is 50 GB.
The ``/var`` partition is an ext4 partition and it is 80 GB.
The ``swap`` partition is 16 GB.
Lastly, ``/scratch`` is an xfs partition and it will be the remainder of ``sda``.

The configuration for _backend-0-0_ has a similar configuration for ``sda`` as the _global_ configuration except for the ``/scratch`` partition. The maximum size of ``/scratch`` partition is set to 1 GB via the Options column.
Additionally, ``sdb`` and ``sdc`` will be configured for _backend-0-0_ as single partitions that span the entire disk.

### LVM

Stacki supports specifying LVM configuration via a spreadsheet. **lvm**, **volgroup** are keywords that indicate that the partition needs to be setup via LVM. In the configuration for ``backend-0-1``,
``pv.01`` is configured as a physical volume on ``sdb`` with size as 8GB.
``volgrp01`` is a volgroup comprising of ``pv.01``. ``/extra`` is mounted as an lvm partition on volgroup ``volgrp01``.

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

Then, the next time _backend-0-0_ is installed, it will remove all partitions for all disks, then repartition the disks as you specified in your spreadsheet.

While a host is installing, after it partitions its disks, it will send a message to the frontend to instruct it to set the  _nukedisks_ attribute back to _false_.
This ensures that the disks will not be reconfigured on the next installation.
