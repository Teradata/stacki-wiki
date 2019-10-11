## remove os storage controller

### Usage

`stack remove os storage controller {os ...} {slot=integer} [adapter=integer] [enclosure=integer]`

### Description


	Remove a storage controller configuration for an OS type.

	

### Arguments

* `[os]`

   OS type (e.g., 'redhat', 'sles').


### Parameters
* `[slot=integer]`
* `{adapter=integer}`
* `{enclosure=integer}`

   Enclosure address. If enclosure is '*', adapter/slot address applies
	to all enclosures.


