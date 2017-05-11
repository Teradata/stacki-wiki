## set host interface vlan

### Usage

`stack set host interface vlan [host ...] {vlan=string} [interface=string] [mac=string]`

### Description


Sets the VLAN ID for an interface on one of more hosts.



### Arguments

* `{host}`

   One or more named hosts.


### Parameters
* `[vlan=string]`
* `{interface=string}`
* `{mac=string}`

   MAC address of the interface.

### Examples

* `stack set host interface vlan backend-0-0-0 interface=eth0 vlan=3`

   Sets backend-0-0-0's private interface to VLAN ID 3.



