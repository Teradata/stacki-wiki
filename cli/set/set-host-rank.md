## set host rank

### Usage

`stack set host rank {host}... {rank} [rank=string]`

### Description

Set the rank number for a list of hosts.

### Arguments

* `{host}`

   One or more host names.

* `{rank}`

   The rank number to assign to each host.


### Parameters
* `[rank=string]`

   Can be used in place of rank argument.

### Examples

* `stack set host rank compute-0-2 2`

   Set the rank number to 2 for compute-0-2.

* `stack set host rank compute-0-0 compute-1-0 0`

   Set the rank number to 0 for compute-0-0 and compute-1-0.

* `stack set host rank compute-0-0 compute-1-0 rank=0`

   Same as above.



