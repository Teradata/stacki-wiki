## remove host interface alias

### Usage

`stack remove host interface alias {host} [alias=string] [interface=string]`

### Description


	Remove an alias from a host interface.

	

### Arguments

* `[host]`

   One host.


### Parameters
* `{alias=string}`
* `{interface=string}`

   Interface to remove aliases for.

### Examples

* `stack remove host interface alias backend-0-0 alias=c-0-0`

   Removes the alias "c-0-0" for host "backend-0-0".

* `stack remove host interface alias backend-0-0 interface=eth0`

   Removes all aliases for "backend-0-0" assigned to "eth0"

* `stack remove host interface alias backend-0-0`

   Removes all aliases for "backend-0-0".



