## set host interface name

### Usage

`stack set host interface name {host} {name=string} [interface=string] [mac=string] [network=string]`

### Description


	Sets the logical name of a network interface on a particular host.

	

### Arguments

* `[host]`

   A single host.


### Parameters
* `[name=string]`
* `{interface=string}`
* `{mac=string}`
* `{network=string}`

   Network name of the interface.

### Examples

* `stack set host interface name backend-0-0 interface=eth1 name=cluster-0-0`

   Sets the name for the eth1 device on host backend-0-0 to
	cluster-0-0.zonename. The zone is decided by the subnet that the
	interface is attached to.



