## add host bonded

### Usage

`stack add host bonded {host} [channel=string] [interfaces=string] [ip=string] [name=string] [network=string] [options=string]`

### Description


Add a channel bonded interface for a host



### Arguments

* `[host]`

   Host name of machine


### Parameters
* `{channel=string}`
* `{interfaces=string}`
* `{ip=string}`
* `{name=string}`
* `{network=string}`
* `{options=string}`

   Bonding Options. These are applied to the bonding device
	as BONDING_OPTS in the ifcfg-bond* files.

### Examples

* `stack add host bonded backend-0-0 channel=bond0   interfaces=eth0,eth1 ip=10.1.255.254 network=private`

   Adds a bonded interface named "bond0" to backend-0-0 by bonding
	the physical interfaces eth0 and eth1, it assigns the IP address
	10.1.255.254 to bond0 and it associates this interface to the private
	network.



