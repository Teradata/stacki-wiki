## set host boot

### Usage

`stack set host boot {host ...} [action=string]`

### Description


Set a bootaction for a host. A hosts action can be set to 'install'
or to 'os' (also, 'run' is a synonym for 'os').



### Arguments

* `[host]`

   One or more host names.


### Parameters
* `{action=string}`

   The label name for the bootaction. This must be one of: 'os',
	'install', or 'run'.

	If no action is supplied, then only the configuration file for the
	list of hosts will be rewritten.

### Examples

* `stack set host boot compute-0-0 action=os`

   On the next boot, compute-0-0 will boot the profile based on its
	"run action". To see the node's "run action", execute:
	"rocks list host compute-0-0" and examine the value in the
	"RUNACTION" column.



