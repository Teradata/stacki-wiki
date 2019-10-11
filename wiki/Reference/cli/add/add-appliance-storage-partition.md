## add appliance storage partition

### Usage

`stack add appliance storage partition {appliance ...} {device=string} {size=integer} [mountpoint=string] [options=string] [partid=integer] [type=string]`

### Description


	Add a storage partition configuration for an appliance type.

	

### Arguments

* `[appliance]`

   Appliance type (e.g., "backend").


### Parameters
* `[device=string]`
* `[size=integer]`
* `{mountpoint=string}`
* `{options=string}`
* `{partid=integer}`
* `{type=string}`

   Type of partition E.g: ext4, ext3, xfs, raid, etc.

### Examples

* `stack add appliance storage partition backend device=sda mountpoint=/var size=50 type=ext4`

   Creates a ext4 partition on device sda with mountpoints /var in the backend appliance scope.



