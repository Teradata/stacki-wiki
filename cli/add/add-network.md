## add network

### Usage

`stack add network {name} {address=string} {mask=string} [dns=boolean] [gateway=string] [mtu=string] [pxe=boolean] [zone=string]`

### Description


Add a network to the database. By default,
the "private" network is already defined.



### Arguments

* `[name]`

   Name of the new network.


### Parameters
* `[address=string]`
* `[mask=string]`
* `{dns=boolean}`
* `{gateway=string}`
* `{mtu=string}`
* `{pxe=boolean}`
* `{zone=string}`

   The Domain name or the DNS Zone name to use
	for all hosts of this particular subnet. Default
	is set to the name of the network.


