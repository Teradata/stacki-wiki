## set host interface module

### Usage

`stack set host interface module [host ...] {module=string} [interface=string] [mac=string]`

### Description

Sets the device module for a named interface. On Linux this will get
	translated to an entry in /etc/modprobe.conf.

### Arguments

* `{host}`

   One or more hosts.


### Parameters
* `[module=string]`
* `{interface=string}`
* `{mac=string}`

   MAC address of the interface.

### Examples

* `stack set host interface module backend-0-0 interface=eth1 module=e1000`

   Sets the device module for eth1 to be e1000 on host backend-0-0.



