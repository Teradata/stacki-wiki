## set host bootaction

### Usage

`stack set host bootaction {host ...} {action=string} {type=string} [sync=boolean]`

### Description


	Update bootaction for a host.

	

### Arguments

* `[host]`

   One or more host names.


### Parameters
* `[action=string]`
* `[type=string]`
* `{sync=boolean}`

   controls if 'sync host boot' needs to be run after
	setting the bootaction.

### Examples

* `stack set host bootaction action=memtest type=os sd-stacki-131`

   sets the bootaction for sd-stacki-131 to memtest



