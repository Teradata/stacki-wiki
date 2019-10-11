## list switch config

### Usage

`stack list switch config [switch ...] [raw=string]`

### Description


	List the running-config for the switch.

	

### Arguments

* `{switch}`

   Zero, one or more switch names. If no switch names are supplied, info about
	all the known switches is listed.


### Parameters
* `{raw=string}`

   If set, print out the raw config from the switch and not the table view.

### Examples

* `stack list switch config switch-0-0`

   List running-config for switch-0-0.

* `stack list switch`

   List running-config for all known switches.

* `stack list switch config switch-0-0 raw=true`

   List raw running-config for switch-0-0.



