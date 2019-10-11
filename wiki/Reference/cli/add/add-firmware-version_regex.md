## add firmware version_regex

### Usage

`stack add firmware version_regex {regex} [description=string] [make=string] [models=string] [name=string]`

### Description


	Adds a firmware version regex to the stacki database for use in parsing and validating firmware version numbers.

	

### Arguments

* `[regex]`

   A valid Python regex to use to use against the version number returned from the target hardware.


### Parameters
* `{description=string}`
* `{make=string}`
* `{models=string}`
* `{name=string}`

   The human readable name for this regex.

### Examples

* `stack add firmware version_regex '(?:\d+\.){2}\d+' name=mellanox_version make=mellanox model='m7800, m6036' description='This turns X86_64 3.6.5009 2018-01-02 07:42:21 x86_64 into 3.6.5009.'`

   Adds a regex with the name mellanox_version and the description provided that looks for three number groups separated by dots to the Stacki database.
	It also associates the regex with the m7800 and m6036 models for the mellanox make.



