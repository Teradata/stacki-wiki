## set firmware model version_regex

### Usage

`stack set firmware model version_regex {models} [make=string] [version_regex=string]`

### Description


	Associates a firmware version_regex with one or more models

	

### Arguments

* `[models]`

   One or more models to associate the version_regex with.


### Parameters
* `{make=string}`
* `{version_regex=string}`

   The name of the version_regex to associate with the provided models.

### Examples

* `stack set firmware make version_regex m7800 m6036 make=mellanox version_regex=mellanox_version`

   Sets the firmware models m7800 and m6036 for make mellanox to use the mellanox_version regex when parsing version numbers.



