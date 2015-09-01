## remove host interface

### Usage

`stack remove host interface {host} {iface} [iface=string]`

### Description

Remove a network interface definition for a host.

### Arguments

* `{host}`

   One or more named hosts.

* `{iface}`

   Interface that should be removed. This may be a logical interface or 
 	the mac address of the interface.


### Parameters
* `[iface=string]`

   Can be used in place of the iface argument.

### Examples

* `stack remove host interface compute-0-0 eth1`

   Removes the interface eth1 on host compute-0-0.

* `stack remove host interface compute-0-0 compute-0-1 iface=eth1`

   Removes the interface eth1 on hosts compute-0-0 and compute-0-1.



