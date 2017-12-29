## remove host attr

### Usage

`stack remove host attr [host ...] {attr=string}`

### Description


	Remove an attribute for a host.

	

### Arguments

* `{host}`

   One or more hosts


### Parameters
* `[attr=string]`

   The attribute name that should be removed.

### Examples

* `stack remove host attr backend-0-0 attr=cpus`

   Removes the attribute cpus for host backend-0-0.



