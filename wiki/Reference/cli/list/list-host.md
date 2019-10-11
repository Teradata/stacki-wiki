## list host

### Usage

`stack list host [host ...] [hash=boolean]`

### Description


	List the Appliance, and physical position info for a list of hosts.

	

### Arguments

* `{host}`

   Zero, one or more host names. If no host names are supplied, info about
	all the known hosts is listed.


### Parameters
* `{hash=boolean}`

   If 'yes', output "synced" or "outdated" which indicates if the host is "in sync"
	with the box for the host (pallets and carts) and if the current installation file
	(profile) is the same as the installation file that was used when the host was last
	installed.
	Default is 'no'.

### Examples

* `stack list host backend-0-0`

   List info for backend-0-0.

* `stack list host`

   List info for all known hosts.



