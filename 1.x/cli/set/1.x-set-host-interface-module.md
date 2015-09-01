## set host interface module

### Usage

`stack set host interface module {host}... {iface} {module} [iface=string] [module=string]`

### Description

Sets the device module for a named interface. On Linux this will get
	translated to an entry in /etc/modprobe.conf.

### Arguments

* `{host}`

   One or more hosts.

* `{iface}`

   Interface that should be updated. This may be a logical interface or 
 	the MAC address of the interface.

* `{module}`

   The software device module of interface. Use module=NULL to clear.


### Parameters
* `[iface=string]`

   Can be used in place of the iface argument.
* `[module=string]`

   Can be used in place of the module argument.

### Examples

* `stack set host interface module compute-0-0 eth1 e1000`

   Sets the device module for eth1 to be e1000 on host compute-0-0.

* `stack set host interface module compute-0-0 iface=eth1 module=e1000`

   Same as above.

* `stack set host interface module compute-0-0 iface=eth1 module=NULL`

   Clear the module entry.


### Related
[add host](add-host)


