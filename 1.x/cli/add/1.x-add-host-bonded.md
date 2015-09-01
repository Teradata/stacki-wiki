## add host bonded

### Usage

`stack add host bonded {host} [channel=string] [interfaces=string] [ip=string] [name=string] [network=string] [options=string]`

### Description

Add a channel bonded interface for a host

### Arguments

* `{host}`

   Host name of machine


### Parameters
* `[channel=string]`

   The channel name (e.g., "bond0").
* `[interfaces=string]`

   The physical interfaces that will be bonded. The interfaces
	can be a comma-separated list (e.g., "eth0,eth1") or a space-separated
	list (e.g., "eth0 eth1").
* `[ip=string]`

   The IP address to assign to the bonded interface.
* `[name=string]`

   The host name associated with the bonded interface. If name is not
	specified, then the interface get the internal host name
	(e.g., compute-0-0).
* `[network=string]`

   The network to be assigned to this interface. This is a named network
	(e.g., 'private') and must be listable by the command
	'rocks list network'.
* `[options=string]`

   Bonding Options. These are applied to the bonding device
	as BONDING_OPTS in the ifcfg-bond* files.

### Examples

* `stack add host bonded compute-0-0 channel=bond0   interfaces=eth0,eth1 ip=10.1.255.254 network=private`

   Adds a bonded interface named "bond0" to compute-0-0 by bonding
	the physical interfaces eth0 and eth1, it assigns the IP address
	10.1.255.254 to bond0 and it associates this interface to the private
	network.



