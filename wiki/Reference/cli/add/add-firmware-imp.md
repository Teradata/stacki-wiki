## add firmware imp

### Usage

`stack add firmware imp {name} [make=string] [models=string]`

### Description


	Adds a firmware implementation to the stacki database.

	

### Arguments

* `[name]`

   The name of the implementation file to run, without the "imp_" prepended or the extension appended.


### Parameters
* `{make=string}`
* `{models=string}`

   Zero or more models that this implementation applies to. Multiple models should be specified as a comma separated list.
	If this is specified, make is also required.

### Examples

* `stack add firmware imp mellanox_6xxx_7xxx make=mellanox model='m7800, m6036'`

   Adds the firmware implementation named mellanox_6xxx_7xxx and sets it to be the one run for make mellanox and models m7800 and m6036.

* `stack add firmware imp mellanox_6xxx_7xxx`

   This simply adds the implementation named mellanox_6xxx_7xxx to be tracked by stacki.



