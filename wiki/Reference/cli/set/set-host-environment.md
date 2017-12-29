## set host environment

### Usage

`stack set host environment {host ...} {environment=string}`

### Description


	Specifies an Environment for the gives hosts.  Environments are
	used to add another level to attribute resolution.  This is commonly
	used to partition a single Frontend into managing multiple clusters.
	
	

### Arguments

* `[host]`

   One or more host names.


### Parameters
* `[environment=string]`

   The environment name to assign to each host.

### Examples

* `stack set host environment backend environment=test`

   Assign all backend appliance host to the test environment.



