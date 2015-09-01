## set host rack

### Usage

`stack set host rack {host}... {rack} [rack=string]`

### Description

Set the rack number for a list of hosts.

### Arguments

* `{host}`

   One or more host names.

* `{rack}`

   The rack number to assign to each host.


### Parameters
* `[rack=string]`

   Can be used in place of rack argument.

### Examples

* `stack set host rack compute-2-0 2`

   Set the rack number to 2 for compute-2-0.

* `stack set host rack compute-0-0 compute-0-1 0`

   Set the rack number to 0 for compute-0-0 and compute-0-1.

* `stack set host rack compute-0-0 compute-0-1 rack=0`

   Same as above.



