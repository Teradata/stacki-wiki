## remove host partition

### Usage

`stack remove host partition {host ...} [device=string] [partition=string] [uuid=string]`

### Description

Remove a partition definitions from a host.

### Examples

* `stack remove host partition compute-0-0`

   Remove all partitions from compute-0-0.

* `stack remove host partition compute-0-0 partition=/export`

   Remove only the /export partition from compute-0-0.

* `stack remove host partition compute-0-0 device=sdb1`

   Remove only the partition information for /dev/sdb1 on compute-0-0



