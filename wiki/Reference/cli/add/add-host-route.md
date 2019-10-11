## add host route

### Usage

`stack add host route {host ...} {address=string} {gateway=string} [interface=string] [netmask=string] [syncnow=string]`

### Description


	Add a route for a host

	

### Arguments

* `[host]`

   Host name of machine


### Parameters
* `[address=string]`
* `[gateway=string]`
* `{interface=string}`
* `{netmask=string}`
* `{syncnow=string}`

   Add route to the routing table immediately

### Examples

* `stack add host route localhost address=10.0.0.2 gateway=10.0.0.1 interface=eth1.2 syncnow=true`

   Add a host based route on the frontend to address 10.0.0.2 with the gateway 10.0.0.1
	through interface eth1.2. This will tag the packet with the vlan ID of 2.
	The syncnow flag being set to true will also add it to the live routing table so no network restart
	is needed.



