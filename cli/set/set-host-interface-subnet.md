## set host interface subnet

### Usage

`stack set host interface subnet {host}... {iface} {subnet} [iface=string] [subnet=string]`

### Description

Sets the subnet for named interface on one of more hosts.

### Arguments

* `{host}`

   One or more named hosts.

* `{iface}`

   Interface that should be updated. This may be a logical interface or 
 	the MAC address of the interface.

* `{subnet}`

   The subnet address of the interface. This is a named subnet and must be
	listable by the command 'rocks list network'.


### Parameters
* `[iface=string]`

   Can be used in place of the iface argument.
* `[subnet=string]`

   Can be used in place of the subnet argument.

### Examples

* `stack set host interface subnet compute-0-0 eth1 public`

   Sets eth1 to be on the public subnet.

* `stack set host interface mac compute-0-0 iface=eth1 subnet=public`

   Same as above.


### Related
[add host](add-host)


