## add host route

### Usage

`stack add host route {host} {address} {gateway} [netmask=string]`

### Description

Add a route for a host

### Arguments

* `{host}`

   Host name of machine

* `{address}`

   Host or network address

* `{gateway}`

   Network or device gateway


### Parameters
* `[netmask=string]`

   Specifies the netmask for a network route.  For a host route
	this is not required and assumed to be 255.255.255.255


