## set access

### Usage

`stack set access {command=string} {group=string}`

### Description


Sets an Access control pattern.



### Parameters
* `[command=string]`
* `[group=string]`

   Group name / ID for access.

### Examples

* `stack set access command="*" group=apache`

   Give "apache" group access to all "stack" commands

* `stack set access command="list*" group=wheel`

   Give "wheel" group access to all "stack list" commands



