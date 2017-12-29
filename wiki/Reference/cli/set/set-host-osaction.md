## set host osaction

### Usage

`stack set host osaction {host ...} {action=string}`

### Description


	Set the run action for a list of hosts.
	
	

### Arguments

* `[host]`

   One or more host names.


### Parameters
* `[action=string]`

   The run action to assign to each host. To get a list of all actions,
	execute: "stack list bootaction".

### Examples

* `stack set host osaction backend-0-0 action=os`

   Sets the run action to "os" for backend-0-0.

* `stack set host osaction backend-0-0 backend-0-1 action=memtest`

   Sets the run action to "memtest" for backend-0-0 and backend-0-1.



