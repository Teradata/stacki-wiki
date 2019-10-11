## set switch host interface

### Usage

`stack set switch host interface {switch} {host=string} {interface=string} {port=string}`

### Description


	In the switch to host relation that Stacki keeps in its database, this command
	changes the name of a host's interface that is associated with a specific port
	on a switch.

	

### Arguments

* `[switch]`

   One switch name.


### Parameters
* `[host=string]`
* `[interface=string]`
* `[port=string]`

   The port number on the switch.

### Examples

* `stack set switch host interface ethernet-231-1 host=stacki-231-3 interface=eth0 port=12`

   Associates "eth0" on host "stacki-231-3" with port "12" on switch "ethernet-231-1".



