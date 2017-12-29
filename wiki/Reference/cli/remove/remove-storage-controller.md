## remove storage controller

### Usage

`stack remove storage controller {scope} [adapter=int] [enclosure=int] [slot=int]`

### Description


	Remove a storage controller configuration from the database.

	

### Arguments

* `[scope]`

   Zero or one argument. The argument is the scope: a valid os (e.g.,
	'redhat'), a valid appliance (e.g., 'backend') or a valid host
	(e.g., 'backend-0-0). No argument means the scope is 'global'.


### Parameters
* `{adapter=int}`
* `{enclosure=int}`
* `{slot=int}`

   Slot address(es). This can be a comma-separated list. If slot is '*',
	adapter/enclosure address applies to all slots.

### Examples

* `stack remove storage controller backend-0-0 slot=1`

   Remove the disk array configuration for slot 1 on backend-0-0.

* `stack remove storage controller backend slot=1,2,3,4`

   Remove the disk array configuration for slots 1-4 for the backend
	appliance.



