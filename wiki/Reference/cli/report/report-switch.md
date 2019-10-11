## report switch

### Usage

`stack report switch {switch} [nukeswitch=boolean]`

### Description


	Output the switch configuration file.

	

### Arguments

* `[switch]`

   Name of the switch. If no switches are supplied, then output the report for all switches.


### Parameters
* `{nukeswitch=boolean}`

   If 'yes', then put the switch into a default state (e.g., no vlans, no partitions),
	Just a "flat" switch.
	Default: no

### Examples

* `stack report switch ethernet-1-1`

   Output the configation file for ethernet-1-1.



