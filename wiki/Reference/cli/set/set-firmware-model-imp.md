## set firmware model imp

### Usage

`stack set firmware model imp {models} [imp=string] [make=string]`

### Description


	Associates a firmware implementation with one or more models.

	

### Arguments

* `[models]`

   One or more models to associate the implementation with.


### Parameters
* `{imp=string}`
* `{make=string}`

   The make of the models.

### Examples

* `stack set firmware model imp m7800 m6036 imp=mellanox_6xxx_7xxx make=mellanox`

   Sets the mellanox_6xxx_7xxx implementation as the one to run for the models m7800 and m6036 for make mellanox.



