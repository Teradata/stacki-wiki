## set firmware make version_regex

### Usage

`stack set firmware make version_regex {makes} [version_regex=string]`

### Description


	Associates a firmware version_regex with one or more makes.

	

### Arguments

* `[makes]`

   One or more makes to associate the version_regex with.


### Parameters
* `{version_regex=string}`

   The name of the version_regex to associate with the provided makes.

### Examples

* `stack set firmware make version_regex mellanox version_regex=mellanox_version`

   Sets the firmware make mellanox to use the mellanox_version regex when parsing version numbers.



