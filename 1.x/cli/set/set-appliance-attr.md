## set appliance attr

### Usage

`stack set appliance attr {appliance} {attr} {value} [attr=string] [shadow=boolean] [value=string]`

### Description

Sets an attribute to an appliance and sets the associated values

### Arguments

* `{appliance}`

   Name of appliance

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

* `stack set appliance attr compute sge False`

   Sets the sge attribution to False for compute appliances

* `stack set appliance attr compute sge attr=cpus value=2`

   same as above


### Related
[list appliance attr](list-appliance-attr)

[list host attr](list-host-attr)

[remove appliance attr](remove-appliance-attr)

[remove host attr](remove-host-attr)

[set host attr](set-host-attr)


