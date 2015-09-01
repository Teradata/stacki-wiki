## set host interface options

### Usage

`stack set host interface options {host}... {iface} [iface=string] [options=string]`

### Description

Sets the options for a device module for a named interface. On Linux,
	this will get translated to an entry in /etc/modprobe.conf.

### Arguments

* `{host}`

   One or more hosts.

* `{iface}`

   Interface that should be updated. This may be a logical interface or 
 	the MAC address of the interface.


### Parameters
* `[iface=string]`

   Can be used in place of the iface argument.
* `[options=string]`

   The options for an interface. Use options=NULL to clear.
	options="dhcp", and options="noreport" have
	special meaning. options="bonding-opts=\"\"" sets up bonding
	options for bonded interfaces

### Examples

* `stack set host interface options compute-0-0 iface=eth1 options="Speed=10"`

   Sets the option "Speed=10" for eth1 on e1000 on host compute-0-0.

* `stack set host interface options compute-0-0 iface=eth1 options=NULL`

   Clear the options entry.

* `stack set host interface options compute-0-0 iface=eth0 options="dhcp"`

   Linux only: Configure eth0 interface for DHCP instead of static.

* `stack set host interface options compute-0-0 iface=eth0 options="noreport"`

   Linux only:  Tell rocks report host interface to ignore this interface
	when writing configuration files



