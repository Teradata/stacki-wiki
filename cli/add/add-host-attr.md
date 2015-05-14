## add host attr

### Usage

`stack add host attr {host} {attr} {value} [attr=string] [value=string]`

### Description

Adds an attribute to a host and sets the associated values

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
* `[value=string]`

   same as value argument

### Examples

* `stack add host attr compute-0-0 cpus 2`

   Sets the number of cpus of compute-0-0 to 2

* `stack add host attr compute-0-0 attr=cpus value=2`

   same as above


### Related
[list host attr](list-host-attr)

[remove host attr](remove-host-attr)


