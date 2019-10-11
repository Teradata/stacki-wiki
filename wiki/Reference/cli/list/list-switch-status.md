## list switch status

### Usage

`stack list switch status [switch ...]`

### Description


	List Port, Speed, State of the switch  and Mac, VLAN, Hostname, and interface
	about each port on the switch.

	

### Arguments

* `{switch}`

   Zero, one or more switch names. If no switch names are supplies, info about
	all the known switches is listed.


### Examples

* `stack list switch status switch-0-0`

   List status info for switch-0-0.

* `stack list switch status`

   List status info for all known switches/



