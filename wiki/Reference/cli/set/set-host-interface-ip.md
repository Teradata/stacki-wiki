## set host interface ip

### Usage

`stack set host interface ip {host} {ip=string} [interface=string] [mac=string] [network=string]`

### Description


	Sets the IP address for the named interface for one host.

	

### Arguments

* `[host]`

   A single host.


### Parameters
* `[ip=string]`
* `{interface=string}`
* `{mac=string}`
* `{network=string}`

   Network name of the interface.

### Examples

* `stack set host interface ip backend-0-0 interface=eth1 ip=192.168.0.10`

   Sets the IP Address for the eth1 device on host backend-0-0.



