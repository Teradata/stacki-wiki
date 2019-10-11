## sync switch ib

### Usage

`stack sync switch ib [switch ...] [nukeswitch=boolean]`

### Description


	Reconfigure Infiniband switches.

	

### Arguments

* `{switch}`

   Zero, one or more ib switch names. If no switch names are supplied,
	all switches will be reconfigured.  All switches will have root's
	public key uploaded, and if `nukeswitch` is True, all will be wiped.
	Only switches which are currently subnet managers will have any other
	configuration applied.


### Parameters
* `{nukeswitch=boolean}`

   If 'yes', then put the switch into a default state (e.g., no vlans, no partitions),
	Just a "flat" switch.
	Default: no

### Examples

* `stack sync switch infiniband-0-0`

   Reconfigure and set startup configuration on infiniband-0-0.

* `stack sync switch`

   Reconfigure all switches.



