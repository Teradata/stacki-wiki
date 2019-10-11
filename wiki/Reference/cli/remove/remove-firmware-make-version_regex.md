## remove firmware make version_regex

### Usage

`stack remove firmware make version_regex {makes}`

### Description


	Disassociates firmware version_regexes from one or more makes.

	

### Arguments

* `[makes]`

   One or more makes to disassociate from a version_regex.


### Examples

* `stack remove firmware make version_regex mellanox intel`

   Disassociates the mellanox and intel makes from any version_regexes that were set for them.



