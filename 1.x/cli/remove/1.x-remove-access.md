## remove access

### Usage

`stack remove access [command=None] [group=None]`

### Description

Remove Access control pattern.

### Parameters
* `[command=None]`

   Command Pattern.
* `[group=None]`

   Group name / ID for access.

### Examples

* `stack remove access '*' apache`

   Remove "apache" group access to all "rocks" commands

* `stack remove access command="list*" group="wheel"`

   Remove "wheel" group access to all "rocks list" commands



