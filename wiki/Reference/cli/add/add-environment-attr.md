## add environment attr

### Usage

`stack add environment attr {environment ...} {attr=string} {value=string} [shadow=boolean]`

### Description


	Sets an attribute to an environment and sets the associated values

	

### Arguments

* `[environment]`

   Name of environment


### Parameters
* `[attr=string]`
* `[value=string]`
* `{shadow=boolean}`

   If set to true, then set the 'shadow' value (only readable by root
	and apache).

### Examples

* `stack set environment attr test sge False`

   Sets the sge attribution to False for test nodes



