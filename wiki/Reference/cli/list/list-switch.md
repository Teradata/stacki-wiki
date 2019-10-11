## list switch

### Usage

`stack list switch [switch ...] [expanded=boolean]`

### Description


	List Appliance, physical position, and model of any hosts with appliance type
	of `switch`.

	

### Arguments

* `{switch}`

   Zero, one or more switch names. If no switch names are supplies, info about
	all the known switches is listed.


### Parameters
* `{expanded=boolean}`

   If set to True, list additional switch information provided by plugins which
	may require slower lookups.
	Default is False.

### Examples

* `stack list host switch-0-0`

   List info for switch-0-0.

* `stack list switch`

   List info for all known switches/



