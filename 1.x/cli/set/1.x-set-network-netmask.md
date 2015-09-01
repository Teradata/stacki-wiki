## set network netmask

### Usage

`stack set network netmask {network}... {netmask} [netmask=string]`

### Description

Sets the network mask for one or more named networks .

### Arguments

* `{network}`

   One or more named networks that should have the defined netmask.

* `{netmask}`

   Netmask that named networks should have.


### Parameters
* `[netmask=string]`

   Can be used in place of netmask argument.

### Examples

* `stack set network netmask optiputer 255.255.255.0`

   Sets the netmask for the "optiputer" network to a class-c address
	space.

* `stack set network netmask optiputer netmask=255.255.255.0`

   Same as above.

* `stack set network netmask optiputer cavewave 255.255.0.0`

   Sets the netmask for the "optiputer" and "cavewave" networks to
	a class-b address space.


### Related
[add network](add-network)

[set network subnet](set-network-subnet)


