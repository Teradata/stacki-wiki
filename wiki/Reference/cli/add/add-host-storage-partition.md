## add host storage partition

### Usage

`stack add host storage partition {host ...} {device=string} {size=integer} [mountpoint=string] [options=string] [partid=integer] [type=string]`

### Description


	Add a storage partition configuration for the specified hosts.

	

### Arguments

* `[host]`

   Host name of machine


### Parameters
* `[device=string]`
* `[size=integer]`
* `{mountpoint=string}`
* `{options=string}`
* `{partid=integer}`
* `{type=string}`

   Type of partition E.g: ext4, ext3, xfs, raid, etc.

### Examples

* `stack add host storage partition backend-0-0 device=sda mountpoint=/var size=50 type=ext4`

   Creates a ext4 partition on device sda with mountpoints /var.



