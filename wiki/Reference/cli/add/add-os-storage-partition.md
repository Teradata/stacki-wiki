## add os storage partition

### Usage

`stack add os storage partition {os ...} {device=string} {size=integer} [mountpoint=string] [options=string] [partid=integer] [type=string]`

### Description


	Add a storage partition configuration for an OS type.

	

### Arguments

* `[os]`

   OS type (e.g., 'redhat', 'sles').


### Parameters
* `[device=string]`
* `[size=integer]`
* `{mountpoint=string}`
* `{options=string}`
* `{partid=integer}`
* `{type=string}`

   Type of partition E.g: ext4, ext3, xfs, raid, etc.

### Examples

* `stack add os storage partition sles device=sda mountpoint=/var size=50 type=ext4`

   Creates a ext4 partition on device sda with mountpoints /var.



