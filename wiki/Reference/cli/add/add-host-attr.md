## add host attr

### Usage

`stack add host attr {host ...} {attr=string} {value=string} [shadow=boolean]`

### Description


	Adds an attribute to a host and sets the associated values

	

### Arguments

* `[host]`

   Host name of machine


### Parameters
* `[attr=string]`
* `[value=string]`
* `{shadow=boolean}`

   If set to true, then set the 'shadow' value (only readable by root
	and apache).

### Examples

* `stack set host attr backend-0-0 attr=cpus value=2`

   Sets the number of cpus of backend-0-0 to 2



