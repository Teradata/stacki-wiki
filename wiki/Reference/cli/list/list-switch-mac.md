## list switch mac

### Usage

`stack list switch mac [switch ...] [pinghosts=bool]`

### Description


	List mac address table on switch.

	

### Arguments

* `{switch}`

   Zero, one or more switch names. If no switch names are supplies, info about
	all the known switches is listed.


### Parameters
* `{pinghosts=bool}`

   Send a ping to each host connected to the switch. Hosts do not show up in the
	mac address table if there is no traffic.

### Examples

* `stack list host mac switch-0-0`

   List mac table for switch-0-0.

* `stack list switch mac`

   List mac table for all known switches/



