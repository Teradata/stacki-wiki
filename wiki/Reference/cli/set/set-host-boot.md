## set host boot

### Usage

`stack set host boot {host ...} {action=string} [nukecontroller=boolean] [nukedisks=boolean] [sync=boolean]`

### Description


	Set a bootaction for a host. A hosts action can be set to 'install'
	or to 'os'.

	

### Arguments

* `[host]`

   One or more host names.


### Parameters
* `[action=string]`
* `{nukecontroller=boolean}`
* `{nukedisks=boolean}`
* `{sync=boolean}`

   Controls if 'sync host boot' needs to be run after setting the
	bootaction. Default: True

### Examples

* `stack set host boot backend-0-0 action=os`

   On the next boot, backend-0-0 will boot the profile based on its
	"run action".



