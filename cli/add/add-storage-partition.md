## add storage partition

### Usage

`stack add storage partition {scope} [device=string] [mountpoint=string] [size=int] [type=string]`

### Description

Add a partition configuration to the database.

### Arguments

* `{scope}`

   Zero or one argument. The argument is the scope: a valid os (e.g.,
	'redhat'), a valid appliance (e.g., 'compute') or a valid host
	(e.g., 'compute-0-0). No argument means the scope is 'global'.


### Parameters
* `[device=string]`

   Disk device on which we are creating partitions
* `[mountpoint=string]`

   Comma separated list of mountpoints
* `[size=int]`

   Size of the partition
* `[type=string]`

   Type of partition E.g: ext4, ext3 etc.

### Examples

* `stack add storage partition compute-0-0 device=sda mountpoint=/,/var   size=50,80 type=ext4,nfs`

   Creates 2 partitions on device sda with mountpoints /, /var.



