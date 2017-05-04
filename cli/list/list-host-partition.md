## list host partition

### Usage

`stack list host partition [host ...]`

### Description

Lists the partitions for hosts. For each host supplied on the command
	line, this command prints the hostname and partitions for that host.

### Arguments

* `{host}`

   Zero, one or more host names. If no host names are supplied, info about
	all the known hosts is listed.


### Examples

* `stack list host partition compute-0-0`

   List partition info for compute-0-0.

* `stack list host partition`

   List partition info for known hosts.



