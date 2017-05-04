## remove os attr

### Usage

`stack remove os attr [os ...] {attr=string}`

### Description

Remove an attribute for an OS.

### Arguments

* `{os}`

   One or more OS specifications (e.g., 'linux').


### Parameters
* `[attr=string]`

   The attribute name that should be removed.

### Examples

* `stack remove os attr linux attr=sge`

   Removes the attribute sge for linux OS machines.



