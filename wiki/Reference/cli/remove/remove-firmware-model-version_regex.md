## remove firmware model version_regex

### Usage

`stack remove firmware model version_regex {models} [make=string]`

### Description


	Disassociates firmware version_regexes from one or more models.

	

### Arguments

* `[models]`

   One or more models to disassociate from a version_regex.


### Parameters
* `{make=string}`

   The make of the provided models.

### Examples

* `stack remove firmware model version_regex m7800 m6036 make=mellanox`

   Disassociates the m7800 and m6036 models for the mellanox make from any version_regexes that were set for them.



