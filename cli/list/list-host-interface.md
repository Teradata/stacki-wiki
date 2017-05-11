## list host interface

### Usage

`stack list host interface [host ...]`

### Description


Lists the interface definitions for hosts. For each host supplied on
the command line, this command prints the hostname and interface
definitions for that host.



### Arguments

* `{host}`

   Zero, one or more host names. If no host names are supplied, info about
	all the known hosts is listed.


### Examples

* `stack list host interface compute-0-0`

   List network interface info for compute-0-0.

* `stack list host interface`

   List network interface info for all known hosts.



