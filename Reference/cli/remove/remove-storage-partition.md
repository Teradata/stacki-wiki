## remove storage partition

### Usage

`stack remove storage partition {scope} [device=string] [mountpoint=string]`

### Description


Remove a storage partition configuration from the database.



### Arguments

* `[scope]`

   Zero or one argument. The argument is the scope: a valid os (e.g.,
	'redhat'), a valid appliance (e.g., 'compute') or a valid host
	(e.g., 'compute-0-0). No argument means the scope is 'global'.


### Parameters
* `{device=string}`
* `{mountpoint=string}`

   Mountpoint for the partition that needs to be removed from
	the database.

### Examples

* `stack remove storage partition compute-0-0 device=sda`

   Remove the disk partition configuration for sda on compute-0-0.

* `stack remove storage partition compute-0-0 device=sda mountpoint=/var`

   Remove the disk partition configuration for partition /var on sda on compute-0-0.

* `stack remove storage partition compute`

   Remove the disk array configuration for compute
	appliance.



