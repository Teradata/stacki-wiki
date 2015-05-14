## add os route

### Usage

`stack add os route {os} {address} {gateway} [netmask=string]`

### Description

Add a route for an OS type

### Arguments

* `{os}`

   The OS type (e.g., 'linux', 'sunos', etc.). This argument is required.

* `{address}`

   Host or network address

* `{gateway}`

   Network or device gateway


### Parameters
* `[netmask=string]`

   Specifies the netmask for a network route.  For a host route
	this is not required and assumed to be 255.255.255.255


