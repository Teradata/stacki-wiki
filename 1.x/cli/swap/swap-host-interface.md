## swap host interface

### Usage

`stack swap host interface {host} [ifaces=string] [sync-config=boolean]`

### Description

Swaps two host interfaces in the database.

### Arguments

* `{host}`

   Host name of machine


### Parameters
* `[ifaces=string]`

   Two comma-separated interface names (e.g., ifaces="eth0,eth1").
* `[sync-config=boolean]`

   If "yes", then run 'rocks sync config' at the end of the command.
	The default is: yes.


