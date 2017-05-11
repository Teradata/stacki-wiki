## remove host partition

### Usage

`stack remove host partition {host ...} [device=string] [partition=string] [uuid=string]`

### Description


Remove a partition definitions from a host.



### Arguments

* `[host]`

   A list of one or more host names.


### Parameters
* `{device=string}`
* `{partition=string}`
* `{uuid=string}`

   UUID of the mountpoint to be removed.

### Examples

* `stack remove host partition compute-0-0`

   Remove all partitions from compute-0-0.

* `stack remove host partition compute-0-0 partition=/export`

   Remove only the /export partition from compute-0-0.

* `stack remove host partition compute-0-0 device=sdb1`

   Remove only the partition information for /dev/sdb1 on compute-0-0



