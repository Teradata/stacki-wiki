## remove storage controller

### Usage

`stack remove storage controller {scope} [adapter=int] [enclosure=int] [slot=int]`

### Description

Remove a storage controller configuration from the database.

### Examples

* `stack remove storage controller compute-0-0 slot=1`

   Remove the disk array configuration for slot 1 on compute-0-0.

* `stack remove storage controller compute slot=1,2,3,4`

   Remove the disk array configuration for slots 1-4 for the compute
	appliance.



