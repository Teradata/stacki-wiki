## add environment storage partition

### Usage

`stack add environment storage partition {environment ...} {device=string} {size=integer} [mountpoint=string] [options=string] [partid=integer] [type=string]`

### Description


	Add a storage partition configuration for an environment.

	

### Arguments

* `[environment]`

   An environment name.


### Parameters
* `[device=string]`
* `[size=integer]`
* `{mountpoint=string}`
* `{options=string}`
* `{partid=integer}`
* `{type=string}`

   Type of partition E.g: ext4, ext3, xfs, raid, etc.

### Examples

* `stack add environment storage partition test device=sda mountpoint=/var size=50 type=ext4`

   Creates a ext4 partition on device sda with mountpoints /var in the test environment scope.



