## set host interface options

### Usage

`stack set host interface options {host ...} {options=string} [interface=string] [mac=string] [network=string]`

### Description


	Sets the options for a device module for a named interface. On Linux,
	this will get translated to an entry in /etc/modprobe.conf.

	

### Arguments

* `[host]`

   One or more hosts.


### Parameters
* `[options=string]`
* `{interface=string}`
* `{mac=string}`
* `{network=string}`

   Network name of the interface.

### Examples

* `stack set host interface options backend-0-0 interface=eth1 options="Speed=10"`

   Sets the option "Speed=10" for eth1 on e1000 on host backend-0-0.

* `stack set host interface options backend-0-0 interface=eth1 options=NULL`

   Clear the options entry.

* `stack set host interface options backend-0-0 interface=eth0 options="dhcp"`

   Linux only: Configure eth0 interface for DHCP instead of static.

* `stack set host interface options backend-0-0 interface=eth0 options="noreport"`

   Linux only:  Tell stack report host interface to ignore this interface
	when writing configuration files



