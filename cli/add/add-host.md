## add host

### Usage

`stack add host {host} [box=string] [cpus=string] [membership=string] [rack=string] [rank=string]`

### Description

Add an new host to the cluster.

### Examples

* `stack add host backend-0-1`

   Adds the host "backend-0-1" to the database with 1 CPU, a membership
	name of "backend", a rack number of 0, and rank of 1.

* `stack add host backend rack=0 rank=1 membership=Backend`

   Adds the host "backend" to the database with 1 CPU, a membership name
	of "Backend", a rack number of 0, and rank of 1.


### Related
[add host interface](add-host-interface)


