## remove storage partition

### Usage

`stack remove storage partition {scope} [device=string] [mountpoint=string]`

### Description

Remove a storage partition configuration from the database.

### Examples

* `stack remove storage partition compute-0-0 device=sda`

   Remove the disk partition configuration for sda on compute-0-0.

* `stack remove storage partition compute-0-0 device=sda mountpoint=/var`

   Remove the disk partition configuration for partition /var on sda on compute-0-0.

* `stack remove storage partition compute`

   Remove the disk array configuration for compute
	appliance.



