## list host group

### Usage

`stack list host group [host ...] [group=string]`

### Description


Lists the groups for a host.



### Arguments

* `{host}`

   Zero, one or more host names. If no host names are supplied, groups
	for all the known hosts is listed.


### Parameters
* `{group=string}`

   Restricts the output to only members of a group. This can be a single
        group name or a comma separated list of group names.

### Examples

* `stack list host group backend-0-0`

   List the groups for backend-0-0.



