## add switch host

### Usage

`stack add switch host {switch} {host=string} {port=string} [interface=string]`

### Description


	Add a new host to a switch

	

### Arguments

* `[switch]`

   Name of the switch


### Parameters
* `[host=string]`
* `[port=string]`
* `{interface=string}`

   Name of the interface you want to use to connect to the switch.
	Default: The first interface that is found that shares the
	same network as the switch.

### Examples

* `stack add switch host switch-0 host=backend-0 port=20`

   Add host backend-0 to switch-0 connected to port 20



