## set network subnet

### Usage

`stack set network subnet {network}... {subnet} [subnet=string]`

### Description

Sets the subnet for one or more named networks.

### Arguments

* `{network}`

   One or more named networks that should have the defined subnet.

* `{subnet}`

   Subnet that named networks should have.


### Parameters
* `[subnet=string]`

   Can be used in place of subnet argument.

### Examples

* `stack set network subnet optiputer 132.239.51.0`

   Sets the "optiputer" subnet address to 132.239.51.0.

* `stack set network subnet optiputer subnet=132.239.51.0`

   Same as above.

* `stack set network subnet optiputer cavewave 67.58.32.0`

   Sets both the "optiputer" and "cavewave" subnet addresses to the
	same value of 67.58.32.0.


### Related
[add network](add-network)

[set network netmask](set-network-netmask)


