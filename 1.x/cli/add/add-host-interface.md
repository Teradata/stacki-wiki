## add host interface

### Usage

`stack add host interface {host} {iface} [iface=string] [ip=string] [mac=string] [module=string] [name=string] [subnet=string] [vlan=string]`

### Description

Adds an interface to a host and sets the associated values

### Arguments

* `{host}`

   Host name of machine

* `{iface}`

   The interface name on the host (e.g., 'eth0', 'eth1')


### Parameters
* `[iface=string]`

   Can be used in place of the iface argument.
* `[ip=string]`

   The IP address to assign to the interface (e.g., '192.168.1.254')
* `[mac=string]`

   The MAC address of the interface (e.g., '00:11:22:33:44:55')
* `[module=string]`

   The device driver name (or module) of the interface (e.g., 'e1000')
* `[name=string]`

   The name to assign to the interface
* `[subnet=string]`

   The name of the subnet to assign to the interface (e.g., 'private')
* `[vlan=string]`

   The VLAN ID to assign the interface

### Examples

* `stack add host interface compute-0-0 eth1 ip=192.168.1.2 subnet=private name=fast-0-0`

   

* `stack add host interface compute-0-0 iface=eth1 ip=192.168.1.2 subnet=private name=fast-0-0`

   same as above


### Related
[set host interface iface](set-host-interface-iface)

[set host interface ip](set-host-interface-ip)

[set host interface mac](set-host-interface-mac)

[set host interface module](set-host-interface-module)

[set host interface name](set-host-interface-name)

[set host interface subnet](set-host-interface-subnet)


