## remove environment storage partition

### Usage

`stack remove environment storage partition {environment ...} [device=string] [mountpoint=string]`

### Description


	Remove storage partition information for an environment.

	

### Arguments

* `[environment]`

   An environment name.


### Parameters
* `{device=string}`
* `{mountpoint=string}`

   Mountpoint for the partition that needs to be removed from
	the database.

### Examples

* `stack remove environment storage partition test`

   Removes the partition information for test environment scope.



