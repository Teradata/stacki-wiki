## set network mtu

### Usage

`stack set network mtu {network ...} {mtu=string}`

### Description


	Sets the MTU for one or more networks.

	

### Arguments

* `[network]`

   The names of one or more networks.


### Parameters
* `[mtu=string]`

   MTU value the networks should have.

### Examples

* `stack set network mtu fat mtu=9000`

   Sets the "fat" network to jumbo frames.



