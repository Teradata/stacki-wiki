## set access

### Usage

`stack set access [command=None] [group=None]`

### Description

Sets an Access control pattern.

### Parameters
* `[command=None]`

   Command Pattern.
* `[group=None]`

   Group name / ID for access.

### Examples

* `stack set access "*" apache`

   Give "apache" group access to all "rocks" commands

* `stack set access command="list*" group="wheel"`

   Give "wheel" group access to all "rocks list" commands



