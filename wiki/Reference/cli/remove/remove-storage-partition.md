## remove storage partition

### Usage

`stack remove storage partition {scope} [device=string] [mountpoint=string]`

### Description


	Remove a storage partition configuration from the database.

	

### Arguments

* `[scope]`

   Zero or one argument. The argument is the scope: a valid os (e.g.,
	'redhat'), a valid appliance (e.g., 'backend') or a valid host
	(e.g., 'backend-0-0). No argument means the scope is 'global'.


### Parameters
* `{device=string}`
* `{mountpoint=string}`

   Mountpoint for the partition that needs to be removed from
	the database.

### Examples

* `stack remove storage partition backend-0-0 device=sda`

   Remove the disk partition configuration for sda on backend-0-0.

* `stack remove storage partition backend-0-0 device=sda mountpoint=/var`

   Remove the disk partition configuration for partition /var on sda on backend-0-0.

* `stack remove storage partition backend`

   Remove the disk array configuration for backend
	appliance.



