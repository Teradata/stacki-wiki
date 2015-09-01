## add host partition

### Usage

`stack add host partition {host}... [device=string] [formatflags=string] [fs=string] [mountpoint=string] [partid=string] [partitionflags=string] [sectorstart=string] [size=string] [uuid=string]`

### Description

Add Partitioning information to the database.

### Arguments

* `{host}`

   Hostname


### Parameters
* `[device=string]`

   Device to be added. For example, sdb, sdb1, etc.
* `[formatflags=string]`

   Flags used for formatting the partition
* `[fs=string]`

   File system type of partition. For example, "ext4", "xfs"
* `[mountpoint=string]`

   Mount point for the device. For example, "/state/partition1", "/hadoop01".
* `[partid=string]`

   ID of partition
* `[partitionflags=string]`

   Flags used for partitioning
* `[sectorstart=string]`

   Starting sector of partition
* `[size=string]`

   Size of partition
* `[uuid=string]`

   UUID for the partition


