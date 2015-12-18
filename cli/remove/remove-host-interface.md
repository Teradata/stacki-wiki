## remove host interface

### Usage

`stack remove host interface [host ...] [interface=string] [mac=string]`

### Description

Remove a network interface definition for a host.

### Examples

* `stack remove host interface backend-0-0 interface=eth1`

   Removes the interface eth1 on host backend-0-0.

* `stack remove host interface backend-0-0 backend-0-1 interface=eth1`

   Removes the interface eth1 on hosts backend-0-0 and backend-0-1.



