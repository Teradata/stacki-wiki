## add appliance attr

### Usage

`stack add appliance attr {appliance} {attr} {value} [attr=string] [value=string]`

### Description

Adds an attribute to an appliance and sets the associated values

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
* `[value=string]`

   same as value argument

### Examples

* `stack add appliance attr compute sge False`

   Sets the sge attribution to False for compute appliances

* `stack add appliance attr compute sge attr=cpus value=2`

   same as above


### Related
[list appliance attr](list-appliance-attr)

[list host attr](list-host-attr)

[remove appliance attr](remove-appliance-attr)

[remove host attr](remove-host-attr)

[set host attr](set-host-attr)


