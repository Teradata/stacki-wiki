## set network mask

### Usage

`stack set network mask {network ...} {mask=string}`

### Description


	Sets the network mask for one or more networks.

	

### Arguments

* `[network]`

   The names of one or more networks.


### Parameters
* `[mask=string]`

   Mask that the named network should have.

### Examples

* `stack set network mask ipmi mask=255.255.255.0`

   Sets the "ipmi" network mask to 255.255.255.0.



