---
layout: page
title: add storage partition
permalink: /add-storage-partition
sidebarloc: /Reference/cli/add
---

## add storage partition

### Usage

`stack add storage partition {scope} {options=string} [device=string] [mountpoint=string] [partid=string] [size=int] [type=string]`

### Description

Add a partition configuration to the database.

### Arguments

* `[scope]`

   Zero or one argument. The argument is the scope: a valid os (e.g.,
	'redhat'), a valid appliance (e.g., 'compute') or a valid host
	(e.g., 'compute-0-0). No argument means the scope is 'global'.


### Parameters
* `[options=string]`
* `{device=string}`
* `{mountpoint=string}`
* `{partid=string}`
* `{size=int}`
* `{type=string}`

   Type of partition E.g: ext4, ext3, xfs, raid, etc.

### Examples

* `stack add storage partition compute-0-0 device=sda mountpoint=/var   size=50 type=ext4`

   Creates a ext4 partition on device sda with mountpoints /var.

* `stack add storage partition compute-0-2 device=sdc mountpoint=pv.01    size=0 type=lvm`

   Creates a physical volume named pv.01 for lvm.

* `stack add storage partition compute-0-2 mountpoint=volgrp01 device=pv.01 pv.02 pv.03   size=32768 type=volgroup`

   Creates a volume group from 3 physical volumes i.e. pv.01, pv.02, pv.03. All these 3
	physical volumes need to be created with the previous example. PV's need to be space
	separated.

* `stack add storage partition compute-0-2 device=volgrp01 mountpoint=/banktools   size=8192 type=xfs options=--name=banktools`

   Created an xfs lvm partition of size 8192 on volgrp01. volgrp01 needs to be created
	with the previous example.



