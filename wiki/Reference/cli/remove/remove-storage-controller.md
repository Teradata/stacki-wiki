## remove storage controller

### Usage

`stack remove storage controller {slot=integer} [adapter=integer] [enclosure=integer]`

### Description


	Remove a storage controller configuration from the database.

	

### Parameters
* `[slot=integer]`
* `{adapter=integer}`
* `{enclosure=integer}`

   Enclosure address. If enclosure is '*', adapter/slot address applies
	to all enclosures.

### Examples

* `stack remove storage controller slot=1`

   Remove the global disk array configuration for slot 1.

* `stack remove storage controller slot=1,2,3,4`

   Remove the global disk array configuration for slots 1-4.



