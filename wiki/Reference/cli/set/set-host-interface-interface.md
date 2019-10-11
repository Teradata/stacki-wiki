## set host interface interface

### Usage

`stack set host interface interface {host ...} {interface=string} [mac=string] [network=string]`

### Description


	Sets the logical interface of a mac address for particular hosts.

	

### Arguments

* `[host]`

   One or more hosts.


### Parameters
* `[interface=string]`
* `{mac=string}`
* `{network=string}`

   Network name of the interface.

### Examples

* `stack set host interface interface backend-0-0 00:0e:0c:a7:5d:ff eth1`

   Sets the logical interface of MAC address 00:0e:0c:a7:5d:ff to be eth1

* `stack set host interface interface backend-0-0 interface=eth1 mac=00:0e:0c:a7:5d:ff`

   Same as above.



