## list storage controller

### Usage

`stack list storage controller [host]`

### Description


	List the storage controller configuration for one of the following:
	global, os, appliance or host.

	

### Arguments

* `{host}`

   This argument can be nothing, a valid 'os' (e.g., 'redhat'), a valid
	appliance (e.g., 'backend') or a host.
	If nothing is supplied, then the global storage controller
	configuration will be output.


### Examples

* `stack list storage controller backend-0-0`

   List host-specific storage controller configuration for backend-0-0.

* `stack list storage controller backend`

   List appliance-specific storage controller configuration for all
	backend appliances.

* `stack list storage controller`

   List global storage controller configuration for all hosts.



