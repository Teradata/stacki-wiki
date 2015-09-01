## set host interface ip

### Usage

`stack set host interface ip {host} {iface} {ip} [iface=string] [ip=string]`

### Description

Sets the IP address for the named interface for one host.

### Arguments

* `{host}`

   Host name.

* `{iface}`

   Interface that should be updated. This may be a logical interface or 
 	the mac address of the interface.

* `{ip}`

   The IP address of the interface. Usually of the form nnn.nnn.nnn.nnn
	where n is a decimal digit. This format is not enforced. Use IP=NULL
	to clear.


### Parameters
* `[iface=string]`

   Can be used in place of the iface argument.
* `[ip=string]`

   Can be used in place of the ip argument.

### Examples

* `stack set host interface ip compute-0-0 eth1 192.168.0.10`

   Sets the IP Address for the eth1 device on host compute-0-0.

* `stack set host interface ip compute-0-0 iface=eth1 ip=192.168.0.10`

   Same as above.


### Related
[add host](add-host)

[set host interface iface](set-host-interface-iface)

[set host interface ip](set-host-interface-ip)

[set host interface module](set-host-interface-module)


