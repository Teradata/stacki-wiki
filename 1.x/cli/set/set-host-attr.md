## set host attr

### Usage

`stack set host attr {host} {attr} {value} [attr=string] [shadow=boolean] [value=string]`

### Description

Sets an attribute to a host and sets the associated values

### Arguments

* `{host}`

   Host name of machine

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

* `stack set host attr compute-0-0 cpus 2`

   Sets the number of cpus of compute-0-0 to 2

* `stack set host attr compute-0-0 attr=cpus value=2`

   same as above


### Related
[list host attr](list-host-attr)

[remove host attr](remove-host-attr)


