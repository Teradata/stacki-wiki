## sync firmware

### Usage

`stack sync firmware [version ...] [make=string] [model=string]`

### Description


	Syncs the firmware files on the frontend with what the expected firmware is in the stacki database

	

### Arguments

* `{version}`

   Zero or more firmware versions to sync. If none are specified, all firmware files tracked by stacki will be synced.


### Parameters
* `{make=string}`
* `{model=string}`

   The model of the firmware versions to be synced. This is required if version arguments are specified.

### Examples

* `stack sync firmware 3.6.8010 make=Mellanox model=m7800`

   Makes sure the firmware file with version 3.6.8010 for Mellanox m7800 devices exists on the filesystem
	and has the correct hash. It will be re-fetched from the source if necessary.

* `stack sync firmware`

   Syncs all known firmware files, checking that they exist on the filesystem and have the correct hash.
	They will be re-fetched from the source if necessary.



