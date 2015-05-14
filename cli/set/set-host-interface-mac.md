## set host interface mac

### Usage

`stack set host interface mac {host} {iface} {mac} [iface=string] [mac=string]`

### Description

Sets the mac address for named interface on host.

### Arguments

* `{host}`

   Host name.

* `{iface}`

   Interface that should be updated. This may be a logical interface or 
 	the mac address of the interface.

* `{mac}`

   The mac address of the interface. Usually of the form dd:dd:dd:dd:dd:dd
	where d is a hex digit. This format is not enforced. Use mac=NULL to
	clear the mac address.


### Parameters
* `[iface=string]`

   Can be used in place of the iface argument.
* `[mac=string]`

   Can be used in place of the mac argument.

### Examples

* `stack set host interface mac compute-0-0 eth1 00:0e:0c:a7:5d:ff`

   Sets the MAC Address for the eth1 device on host compute-0-0.

* `stack set host interface mac compute-0-0 iface=eth1 mac=00:0e:0c:a7:5d:ff`

   Same as above.

* `stack set host interface mac compute-0-0 iface=eth1 mac=NULL`

   clears the mac address from the database


### Related
[add host](add-host)


