## remove host interface

### Usage

`stack remove host interface [host ...] [all=bool] [interface=string] [mac=string]`

### Description


Remove a network interface definition for a host.



### Arguments

* `{host}`

   One or more named hosts.


### Parameters
* `{all=bool}`
* `{interface=string}`
* `{mac=string}`

   MAC address of the interface that should be removed.

### Examples

* `stack remove host interface backend-0-0 interface=eth1`

   Removes the interface eth1 on host backend-0-0.

* `stack remove host interface backend-0-0 backend-0-1 interface=eth1`

   Removes the interface eth1 on hosts backend-0-0 and backend-0-1.



