## remove host attr

### Usage

`stack remove host attr {host} {attr} [attr=string]`

### Description

Remove an attribute for a host.

### Arguments

* `{host}`

   One or more hosts

* `{attr}`

   The attribute name that should be removed.


### Parameters
* `[attr=string]`

   Can be used in place of the attr argument.

### Examples

* `stack remove host attr compute-0-0 cpus`

   Removes the attribute cpus for host compute-0-0.

* `stack remove host attr compute-0-0 attr=cpus`

   Same as above.



