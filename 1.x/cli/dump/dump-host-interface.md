## dump host interface

### Usage

`stack dump host interface [host]...`

### Description

Dump the host interface information as rocks commands.

### Arguments

* `[host]`

   Zero, one or more host names. If no host names are supplied, 
	information for all hosts will be listed.


### Examples

* `stack dump host interface compute-0-0`

   Dump the interfaces for compute-0-0.

* `stack dump host interface compute-0-0 compute-0-1`

   Dump the interfaces for compute-0-0 and compute-0-1.

* `stack dump host interface`

   Dump all interfaces.


### Related
[add host interface](add-host-interface)


