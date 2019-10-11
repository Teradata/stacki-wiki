## add os storage controller

### Usage

`stack add os storage controller {os ...} {arrayid=string} [adapter=integer] [enclosure=integer] [hotspare=integer] [raidlevel=integer] [slot=integer]`

### Description


	Add a storage controller configuration for an OS type.

	

### Arguments

* `[os]`

   OS type (e.g., 'redhat', 'sles').


### Parameters
* `[arrayid=string]`
* `{adapter=integer}`
* `{enclosure=integer}`
* `{hotspare=integer}`
* `{raidlevel=integer}`
* `{slot=integer}`

   Slot address(es). This can be a comma-separated list meaning all disks
	in the specified slots will be associated with the same array

### Examples

* `stack add os storage controller sles slot=1 raidlevel=0 arrayid=1`

   The disk in slot 1 should be a RAID 0 disk for the sles OS.

* `stack add os storage controller sles slot=2,3,4,5,6 raidlevel=6 hotspare=7,8 arrayid=2`

   The disks in slots 2-6 on sles OS should be a RAID 6 with two
	hotspares associated with the array in slots 7 and 8.



