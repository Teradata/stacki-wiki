## set host distribution

### Usage

`stack set host distribution {host}... {distribution} [distribution=string]`

### Description

Sets the distribution for a list of hosts.

### Arguments

* `{host}`

   One or more host names.

* `{distribution}`

   The name of the distribution (e.g. default)


### Parameters
* `[distribution=string]`

   Can be used in place of the distribution argument.

### Examples

* `stack set host distribution compute default`

   Set the distribution for all current compute nodes to default.



