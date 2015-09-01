## set host installaction

### Usage

`stack set host installaction {host}... {action} [action=string]`

### Description

Set the install action for a list of hosts.

### Arguments

* `{host}`

   One or more host names.

* `{action}`

   The install action to assign to each host. To get a list of all actions,
	execute: "rocks list bootaction".


### Parameters
* `[action=string]`

   Can be used in place of the action argument.

### Examples

* `stack set host installaction compute-0-0 install`

   Sets the install action to "install" for compute-0-0.

* `stack set host installaction compute-0-0 compute-0-1 "install i386"`

   Sets the install action to "install i386" for compute-0-0 and compute-0-1.

* `stack set host installaction compute-0-0 compute-0-1 action="install i386"`

   Same as above.


