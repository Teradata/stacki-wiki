## remove storage partition

### Usage

`stack remove storage partition [device=string] [mountpoint=string]`

### Description


	Remove a storage partition configuration from the database.

	

### Parameters
* `{device=string}`
* `{mountpoint=string}`

   Mountpoint for the partition that needs to be removed from
	the database.

### Examples

* `stack remove storage partition device=sda`

   Remove the global storage partition configuration for sda.

* `stack remove storage partition device=sda mountpoint=/var`

   Remove the global storage partition configuration for /var on sda.



