## add host route

### Usage

`stack add host route {host ...} [address=string] [gateway=string] [netmask=string]`

### Description

Add a route for a host

### Arguments

* `[host]`

   Host name of machine


### Parameters
* `{address=string}`
* `{gateway=string}`
* `{netmask=string}`

   Specifies the netmask for a network route.  For a host route
	this is not required and assumed to be 255.255.255.255


