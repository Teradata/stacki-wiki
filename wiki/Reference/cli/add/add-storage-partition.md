## add storage partition

### Usage

`stack add storage partition {device=string} {size=integer} [mountpoint=string] [options=string] [partid=integer] [type=string]`

### Description


	Add a global storage partition configuration for the all hosts in the cluster.

	

### Parameters
* `[device=string]`
* `[size=integer]`
* `{mountpoint=string}`
* `{options=string}`
* `{partid=integer}`
* `{type=string}`

   Type of partition E.g: ext4, ext3, xfs, raid, etc.

### Examples

* `stack add storage partition device=sda mountpoint=/var size=50 type=ext4`

   Creates a ext4 partition on device sda with mountpoints /var.

* `stack add storage partition device=sdc mountpoint=pv.01 size=0 type=lvm`

   Creates a physical volume named pv.01 for lvm.

* `stack add storage partition device=volgrp01 mountpoint=/banktools size=8192 type=xfs options=--name=banktools`

   Created an xfs lvm partition of size 8192 on volgrp01. volgrp01 needs to be created
	with the previous example.



