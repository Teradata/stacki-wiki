## set host interface network

### Usage

`stack set host interface network {host ...} [interface=string] [mac=string] [network=string]`

### Description

Sets the network for named interface on one of more hosts.

### Arguments

* `[host]`

   One or more named hosts.


### Parameters
* `{interface=string}`
* `{mac=string}`
* `{network=string}`

   The network address of the interface. This is a named network and must be
	listable by the command 'rocks list network'.

### Examples

* `stack set host interface mac backend-0-0 interface=eth1 network=public`

   Sets eth1 to be on the public network.



