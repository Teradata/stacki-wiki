## list storage partition

### Usage

`stack list storage partition [host] {globalOnly=bool}`

### Description

List the storage partition configuration for one of the following:
	global, os, appliance or host.

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



