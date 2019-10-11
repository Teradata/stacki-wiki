## list host interface alias

### Usage

`stack list host interface alias [host ...] [interface=string]`

### Description


	Lists the aliases for a host interface.

	

### Arguments

* `{host}`

   Zero, one or more host names. If no host names are supplied, aliases
	for all the known hosts is listed.


### Parameters
* `{interface=string}`

   Interface of host.

### Examples

* `stack list host interface alias backend-0-0 interface=eth0`

   List the aliases for backend-0-0 on interface "eth0".



