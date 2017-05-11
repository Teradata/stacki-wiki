## remove storage controller

### Usage

`stack remove storage controller {scope} [adapter=int] [enclosure=int] [slot=int]`

### Description


Remove a storage controller configuration from the database.



### Arguments

* `[scope]`

   Zero or one argument. The argument is the scope: a valid os (e.g.,
	'redhat'), a valid appliance (e.g., 'compute') or a valid host
	(e.g., 'compute-0-0). No argument means the scope is 'global'.


### Parameters
* `{adapter=int}`
* `{enclosure=int}`
* `{slot=int}`

   Slot address(es). This can be a comma-separated list. If slot is '*',
	adapter/enclosure address applies to all slots.

### Examples

* `stack remove storage controller compute-0-0 slot=1`

   Remove the disk array configuration for slot 1 on compute-0-0.

* `stack remove storage controller compute slot=1,2,3,4`

   Remove the disk array configuration for slots 1-4 for the compute
	appliance.



