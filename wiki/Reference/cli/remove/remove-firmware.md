## remove firmware

### Usage

`stack remove firmware {version ...} [make=string] [model=string]`

### Description


	Removes firmware images from stacki.

	

### Arguments

* `[version]`

   Zero or more firmware versions to be removed. If no versions are specified, all will be removed.
	If one or more versions are specified, the make and model parameters are required.


### Parameters
* `{make=string}`
* `{model=string}`

   The optional model of the firmware to remove.
	If this is specified, make is required.
	If no versions are specified but make and model are specified, all firmware versions for that make and model will be removed.

### Examples

* `stack remove firmware`

   Removes all firmware.

* `stack remove firmware 3.6.5002 make=mellanox model=m7800`

   Removes the firmware with version 3.6.5002 for the mellanox m7800 make and model.

* `stack remove firmware make=mellanox`

   Removes all firmware for the mellanox make.

* `stack remove firmware make=mellanox model=m7800`

   Removes all firmware for the mellanox make and m7800 model.



