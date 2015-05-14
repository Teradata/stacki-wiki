## set network mtu

### Usage

`stack set network mtu {network}... {mtu} [mtu=string]`

### Description

Sets the MTU for one or more named networks.

### Arguments

* `{network}`

   One or more named networks that should have the defined MTU.

* `{mtu}`

   MTU that named networks should have.


### Parameters
* `[mtu=string]`

   Can be used in place of 'mtu' argument.

### Examples

* `stack set network mtu optiputer 9000`

   Sets the "optiputer" MTU address to 9000.

* `stack set network mtu optiputer mtu=9000`

   Same as above.


### Related
[add network](add-network)

[set network netmask](set-network-netmask)


