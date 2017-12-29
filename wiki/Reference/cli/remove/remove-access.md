## remove access

### Usage

`stack remove access {command=string} {group=string}`

### Description


	Remove Access control pattern.
	
	

### Parameters
* `[command=string]`
* `[group=string]`

   Group name / ID for access.

### Examples

* `stack remove access command="*" group=apache`

   Remove "apache" group access to all "rocks" commands

* `stack remove access command="list*" group=wheel`

   Remove "wheel" group access to all "rocks list" commands



