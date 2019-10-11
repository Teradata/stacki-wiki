## add host firmware mapping

### Usage

`stack add host firmware mapping {host ...} [make=string] [model=string] [version=string]`

### Description


	Maps firmware files to hosts so 'stack sync host firmware' can find them.

	

### Arguments

* `[host]`

   One or more hostnames to associate with a firmware version.


### Parameters
* `{make=string}`
* `{model=string}`
* `{version=string}`

   The firmware version to map to the provided hosts.

### Examples

* `stack add host firmware mapping switch-11-13 version=3.6.2010 make=mellanox model=m7800`

   Maps firmware version 3.6.2010 for make mellanox and model m7800 to the host with the name switch-11-3.

* `stack add host firmware mapping switch-11-13 switch-10-15 version=3.6.2010 make=mellanox model=m7800`

   This is the same as the previous example except the firmware will be mapped to both switch-11-3 and switch-10-15.

* `stack add host firmware mapping a:switch version=3.6.2010 make=mellanox model=m7800`

   This is the same as the previous example except the firmware will be mapped to all hosts that are switch appliances.



