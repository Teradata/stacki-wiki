## remove host alias

### Usage

`stack remove host alias [host ...] [alias=string]`

### Description


Remove an alias from a host(s).



### Arguments

* `{host}`

   One hosts.


### Parameters
* `{alias=string}`

   The alias name that should be removed.

### Examples

* `stack remove host alias backend-0-0 alias=c-0-0`

   Removes the alias c-0-0 for host backend-0-0.

* `stack remove host alias backend-0-0`

   Removes all aliases for backend-0-0.



