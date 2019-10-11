## add host interface alias

### Usage

`stack add host interface alias {host} {alias=string} {interface=string}`

### Description


	Adds an alias to a host interface.

	

### Arguments

* `[host]`

   Host name of machine


### Parameters
* `[alias=string]`
* `[interface=string]`

   Interface of host.

### Examples

* `stack add host interface alias backend-0-0 interface=eth0 alias=b00`

   Add a host alias "b00" to host "backend-0-0" on interface "eth0".



