## set host interface vlan

### Usage

`stack set host interface vlan {host}... {iface} {vlan} [iface=string] [vlan=string]`

### Description

Sets the VLAN ID for an interface on one of more hosts.

### Arguments

* `{host}`

   One or more named hosts.

* `{iface}`

   Interface that should be updated. This may be a logical interface or 
 	the mac address of the interface.

* `{vlan}`

   The VLAN ID that should be updated. This must be an integer and the
	pair 'subnet/vlan' must be defined in the VLANs table.


### Parameters
* `[iface=string]`

   Can be used in place of the iface argument.
* `[vlan=string]`

   Can be used in place of the vlan argument.

### Examples

* `stack set host interface vlan compute-0-0-0 eth0 3`

   Sets compute-0-0-0's private interface to VLAN ID 3.

* `stack set host interface vlan compute-0-0-0 subnet=eth0 vlan=3`

   Same as above.


### Related
[add host](add-host)


