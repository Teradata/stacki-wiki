## set switch host port

### Usage

`stack set switch host port {switch} {host=string} {interface=string} {port=string}`

### Description


	In the switch to host relation that Stacki keeps in its database, this command
	changes the port association on the switch that this host's interface maps to.

	

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

   Associates port "12" on switch "ethernet-231-1" with interface "eth0" for host "stacki-231-3".



