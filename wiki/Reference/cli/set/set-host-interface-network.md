## set host interface network

### Usage

`stack set host interface network {host ...} {network=string} [interface=string] [mac=string]`

### Description


	Sets the network for named interface on one of more hosts.

	

### Arguments

* `[host]`

   One or more hosts.


### Parameters
* `[network=string]`
* `{interface=string}`
* `{mac=string}`

   MAC address of the interface.

### Examples

* `stack set host interface network backend-0-0 interface=eth1 network=public`

   Sets eth1 to be on the public network.



