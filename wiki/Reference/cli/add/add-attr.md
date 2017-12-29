## add attr

### Usage

`stack add attr {attr=string} {value=string} [shadow=boolean]`

### Description


	Adds a global attribute for all nodes

	

### Parameters
* `[attr=string]`
* `[value=string]`
* `{shadow=boolean}`

   If set to true, then set the 'shadow' value (only readable by root
	and apache).

### Examples

* `stack add attr attr=sge value=False`

   Sets the sge attribute to False


### Related
[list attr](list-attr)

[remove attr](remove-attr)


