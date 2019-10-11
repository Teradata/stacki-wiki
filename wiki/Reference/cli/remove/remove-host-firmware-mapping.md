## remove host firmware mapping

### Usage

`stack remove host firmware mapping {host ...} [make=string] [model=string] [versions=string]`

### Description


	Removes firmware mappings.

	

### Arguments

* `[host]`

   Zero or more hosts to have their mapped firmware versions removed.
	If no hosts are specified, all mappings for all hosts are removed.


### Parameters
* `{make=string}`
* `{model=string}`
* `{versions=string}`

   Zero or more firmware versions to be unmapped. Multiple versions should be specified as a comma separated list.
	If no versions are specified, all will be removed.
	If one or more versions are specified, the make and model parameters are required.

### Examples

* `stack remove host firmware mapping`

   Removes all firmware mappings for all hosts.

* `stack remove host firmware mapping switch-13-11 switch-13-12 versions=3.6.5002,3.6.8010 make=mellanox model=m7800`

   Unmaps the firmware versions 3.6.5002 and 3.6.8010 for the mellanox m7800 make and model from the hosts named switch-13-11 and switch-13-12.

* `stack remove host firmware mapping make=mellanox model=m7800`

   Unmaps all firmware for the mellanox make and m7800 model from all hosts.

* `stack remove host firmware mapping switch-13-11 make=mellanox`

   Unmaps all of the firmware for the mellanox make from the host named switch-13-11.

* `stack remove host firmware mapping make=mellanox`

   Unmaps all of the firmware for the mellanox make from all hosts.



