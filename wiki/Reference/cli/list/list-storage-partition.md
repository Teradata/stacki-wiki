## list storage partition

### Usage

`stack list storage partition [host] {globalOnly=bool}`

### Description

List the storage partition configuration for one of the following:
	global, os, appliance or host.

### Arguments

* `{host}`

   This argument can be nothing, a valid 'os' (e.g., 'redhat'), a valid
	appliance (e.g., 'compute') or a host.
	If nothing is supplied, then the global storage partition
	configuration will be output.


### Parameters
* `[globalOnly=bool]`

   Flag that specifies if only the 'global' partition entries should
	be displayed.

### Examples

* `stack list storage partition compute-0-0`

   List host-specific storage partition configuration for compute-0-0.

* `stack list storage partition compute`

   List appliance-specific storage partition configuration for all
	compute appliances.

* `stack list storage partition`

   List all storage partition configurations in the database.

* `stack list storage partition globalOnly=y`

   Lists only global storage partition configuration i.e. configuration
	not associated with a specific host or appliance type.



