## list host switch

### Usage

`stack list host switch [host ...]`

### Description


	List information about a host's interfaces and which switch ports they are connected to.

	

### Arguments

* `{host}`

   Zero, one or more host names. If no hosts names are supplied, info about
	all the known hosts is listed.


### Examples

* `stack list host switch backend-0-0`

   List switch/port to host/interface relationship (if any).

* `stack list host switch backend-0-0 status=y`

   List switch/port to host/interface relationship (if any) and display the link speed
	and link state.



