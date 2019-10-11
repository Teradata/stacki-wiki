## set host interface vlan

### Usage

`stack set host interface vlan {host ...} {vlan=integer} [interface=string] [mac=string] [network=string]`

### Description


	Sets the VLAN ID for an interface on one of more hosts.

	

### Arguments

* `[host]`

   One or more hosts.


### Parameters
* `[vlan=integer]`
* `{interface=string}`
* `{mac=string}`
* `{network=string}`

   Network name of the interface.

### Examples

* `stack set host interface vlan backend-0-0-0 interface=eth0 vlan=3`

   Sets backend-0-0-0's private interface to VLAN ID 3.



