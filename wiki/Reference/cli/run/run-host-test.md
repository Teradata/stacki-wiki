## run host test

### Usage

`stack run host test [host ...] {test=string} [extras=string] [status=string]`

### Description


	Run tests on hosts. This is commonly used to "validate" the
	hardware for a cluster.

	

### Arguments

* `{host}`

   Zero, one or more host names. If no host names are supplied, the command
	is run on all 'managed' hosts. By default, all backend nodes are
	'managed' nodes. To determine if a host is managed, execute:
	'stack list host attr hostname | grep managed'. If you see output like:
	'backend-0-0: managed true', then the host is managed.


### Parameters
* `[test=string]`
* `{extras=string}`
* `{status=string}`

   Determine if "stack run host test" is already running. If it is,
	output "is running". If there are no other instances of "stack run
	host test" running, then output "is not running".

### Examples

* `stack run host test backend-0-0 test="memory"`

   Run the "memory" test on backend-0-0.

* `stack run host test backend test="all" extras="/tmp/test"`

   Run all the tests on all the backend nodes and store the results in
	"/tmp/test.memory", "/tmp/test.disk" and "/tmp/test.network".



