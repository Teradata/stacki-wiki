## set os attr

### Usage

`stack set os attr {os} {attr} {value} [attr=string] [shadow=boolean] [value=string]`

### Description

Sets an attribute to an os and sets the associated values

### Arguments

* `{os}`

   Name of os

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

* `stack set os attr linux sge False`

   Sets the sge attribution to False for linux nodes



