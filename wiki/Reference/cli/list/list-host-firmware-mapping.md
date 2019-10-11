## list host firmware mapping

### Usage

`stack list host firmware mapping {host ...} [make=string] [model=string] [sort=string] [versions=string]`

### Description


	Lists the firmware mappings that exist in the stacki database.

	

### Arguments

* `[host]`

   Zero or more hostnames to filter the results by.


### Parameters
* `{make=string}`
* `{model=string}`
* `{sort=string}`
* `{versions=string}`

   Zero or more firmware versions to filter by. Multiple versions should be specified as a comma separated list.
	If one or more versions are specified, the make and model parameters are required.

### Examples

* `stack stack list host firmware mapping`

   Lists all of the firmware mappings for all hosts.

* `stack stack list host firmware mapping switch-13-11`

   Lists all of the firmware mappings for the host named switch-13-11.

* `stack stack list host firmware mapping switch-13-11 switch-13-12 versions=3.6.5002,3.6.8010 make=mellanox model=m7800`

   Lists all of the firmware mappings for firmware versions 3.6.5002 and 3.6.8010 for make mellanox and model m7800 that are
	mapped to the hosts named switch-13-11 and switch-13-12.

* `stack stack list host firmware mapping versions=3.6.5002,3.6.8010 make=mellanox model=m7800`

   Lists all of the firmware mappings for firmware versions 3.6.5002 and 3.6.8010 for make mellanox and model m7800 for all hosts.

* `stack stack list host firmware mapping a:switch make=mellanox model=m7800`

   Lists all of the firmware mappings for make mellanox and model m7800 for all hosts that are switch appliances.

* `stack stack list host firmware mapping make=mellanox model=m7800`

   Lists all of the firmware mappings for make mellanox and model m7800 for all hosts.

* `stack stack list host firmware mapping switch-13-11 make=mellanox`

   Lists all of the firmware mappings for make mellanox for the host with the name switch-13-11.

* `stack stack list host firmware mapping make=mellanox`

   Lists all of the firmware mappings for make mellanox for all hosts.



