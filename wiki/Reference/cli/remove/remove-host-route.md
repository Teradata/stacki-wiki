## remove host route

### Usage

`stack remove host route {host ...} {address=string} [syncnow=string]`

### Description


	Remove a static route for a host.

	

### Arguments

* `[host]`

   Name of a host machine.


### Parameters
* `[address=string]`
* `{syncnow=string}`

   If set to true, the routing table will be updated as well as the db.

### Examples

* `stack remove host route backend-0-0 address=1.2.3.4`

   Remove the static route for the host 'backend-0-0' that has the
	network address '1.2.3.4'.

* `stack remove host route backend-0-0 address=1.2.3.4 syncnow=true`

   Remove the static route for the host 'backend-0-0' that has the
	network address '1.2.3.4' and remove the route from the routing table.



