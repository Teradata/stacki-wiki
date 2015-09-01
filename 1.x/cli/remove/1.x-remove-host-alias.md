## remove host alias

### Usage

`stack remove host alias {host} {name} [name=string]`

### Description

Remove an alias for a host.

### Arguments

* `{host}`

   One hosts.

* `{name}`

   The alias name that should be removed.


### Parameters
* `[name=string]`

   Can be used in place of the name argument.

### Examples

* `stack remove host alias compute-0-0 c-0-0`

   Removes the alias c-0-0 for host compute-0-0.

* `stack remove host alias compute-0-0 name=c-0-0`

   Same as above.



