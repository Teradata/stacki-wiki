## report host interface

### Usage

`stack report host interface {host} [iface=string]`

### Description

Output the network configuration file for a host's interface.

### Arguments

* `{host}`

   One host name.


### Parameters
* `[iface=string]`

   Output a configuration file for this host's interface (e.g. 'eth0').
	If no 'iface' parameter is supplied, then configuration files
	for every interface defined for the host will be output (and each
	file will be delineated by <file> and </file> tags).

### Examples

* `stack report host interface compute-0-0 iface=eth0`

   Output a network configuration file for compute-0-0's eth0 interface.



