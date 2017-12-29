## disable cart

### Usage

`stack disable cart {cart ...} [box=string]`

### Description


	Disables a cart. The cart must already be copied on the
	system using the command "stack add cart".
	
	

### Arguments

* `[cart]`

   List of carts to disable. This should be the cart base name (e.g.,
	base, hpc, kernel).


### Parameters
* `{box=string}`

   The name of the box in which to disable the cart. If no box is
	specified the cart is disabled for the default box.

### Examples

* `stack disable cart local`

   Disable the cart named "local".


### Related
[add cart](add-cart)

[enable cart](enable-cart)

[list cart](list-cart)


