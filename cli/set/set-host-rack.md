## set host rack

### Usage

`stack set host rack {host ...} {rack=string}`

### Description

Set the rack number for a list of hosts.

### Arguments

* `[host]`

   One or more host names.


### Parameters
* `[rack=string]`

   The rack name (usually a number) to assign to each host.

### Examples

* `stack set host rack compute-2-0 rack=2`

   Set the rack number to 2 for compute-2-0.



