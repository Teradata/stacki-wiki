## set host cpus

### Usage

`stack set host cpus {host ...} {cpus=string}`

### Description

Set the number of CPUs for a list of hosts.

### Arguments

* `[host]`

   One or more host names.


### Parameters
* `[cpus=string]`

   The number of CPUs to assign to each host.

### Examples

* `stack set host cpus backend-0-0 cpus=2`

   Sets the CPU value to 2 for backend-0-0.



