## sync switch

### Usage

`stack sync switch [switch ...] [nukeswitch=boolean] [persistent=boolean]`

### Description


	Reconfigure switch and optionally set the configuration 
	to the startup configuration.

	

### Arguments

* `{switch}`

   Zero, one or more switch names. If no switch names are supplied,
	all switches will be reconfigured.


### Parameters
* `{nukeswitch=boolean}`
* `{persistent=boolean}`

   If "yes", then set the startup configuration.
	The default is: yes.

### Examples

* `stack sync switch switch-0-0`

   Reconfigure and set startup configuration on switch-0-0.

* `stack sync switch switch-0-0 persistent=no`

   Reconfigure switch-0-0 but dont set the startup configuration..

* `stack sync switch`

   Reconfigure and set startup configuration on all switches.



