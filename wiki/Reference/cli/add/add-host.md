## add host

### Usage

`stack add host {host} [box=string] [environment=string] [longname=string] [rack=string] [rank=string]`

### Description


	Add an new host to the cluster.

	

### Arguments

* `[host]`

   A single host name.  If the hostname is of the standard form of
	basename-rack-rank the default values for the appliance, rack,
	and rank parameters are taken from the hostname.


### Parameters
* `{box=string}`
* `{environment=string}`
* `{longname=string}`
* `{rack=string}`
* `{rank=string}`

   The position of the machine in the rack. The convention in Stacki
	is to number from the bottom of the rack to the top starting at 0.
	If not provided and the host name is of the standard form the rank
	number is taken from the host name.

### Examples

* `stack add host backend-0-1`

   Adds the host "backend-0-1" to the database with 1 CPU, a appliance
	name of "backend", a rack number of 0, and rank of 1.

* `stack add host backend rack=0 rank=1 longname=Backend`

   Adds the host "backend" to the database with 1 CPU, a long appliance name
	of "Backend", a rack number of 0, and rank of 1.


### Related
[add host interface](add-host-interface)


