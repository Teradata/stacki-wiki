## set host membership

### Usage

`stack set host membership {host}... {membership} [membership=string]`

### Description

Set the membership for hosts.

### Arguments

* `{host}`

   One or more host names.

* `{membership}`

   The membership to assign to each host.


### Parameters
* `[membership=string]`

   Can be used in place of the membership argument.

### Examples

* `stack set host membership "NAS Appliance" nas-0-0`

   Sets the membership to 'NAS Appliance' for nas-0-0.

* `stack set host membership "NAS Appliance" membership=nas-0-0`

   Same as above.

* `stack set host membership Compute`

   Sets the membership to 'Compute' for all known hosts.



