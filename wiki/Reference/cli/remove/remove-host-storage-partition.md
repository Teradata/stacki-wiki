## remove host storage partition

### Usage

`stack remove host storage partition {host ...} [device=string] [mountpoint=string]`

### Description


	Remove storage partition configuration for a host.

	

### Arguments

* `[host]`

   Hostname of the machine


### Parameters
* `{device=string}`
* `{mountpoint=string}`

   Mountpoint for the partition that needs to be removed from
	the database.

### Examples

* `stack remove host storage partition backend-0-1`

   Removes the partition information for backend-0-1



