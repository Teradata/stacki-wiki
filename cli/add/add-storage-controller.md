## add storage controller

### Usage

`stack add storage controller {scope} [adapter=int] [arrayid=string] [enclosure=int] [hotspare=int] [raidlevel=int] [slot=int]`

### Description

Add a storage controller configuration to the database.

### Examples

* `stack add storage controller backend-0-0 slot=1 raidlevel=0 arrayid=1`

   The disk in slot 1 on backend-0-0 should be a RAID 0 disk.

* `stack add storage controller backend-0-0 slot=2,3,4,5,6 raidlevel=6 hotspare=7,8 arrayid=2`

   The disks in slots 2-6 on backend-0-0 should be a RAID 6 with two
	hotspares associated with the array in slots 7 and 8.



