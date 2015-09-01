## set attr

### Usage

`stack set attr {attr} {value} [attr=string] [shadow=boolean] [value=string]`

### Description

Sets a global attribute for all nodes

### Arguments

* `{attr}`

   Name of the attribute

* `{value}`

   Value of the attribute


### Parameters
* `[attr=string]`

   same as attr argument
* `[shadow=boolean]`

   If set to true, then set the 'shadow' value (only readable by root
	and apache).
* `[value=string]`

   same as value argument

### Examples

* `stack set attr sge False`

   Sets the sge attribution to False


### Related
[list attr](list-attr)

[remove attr](remove-attr)


