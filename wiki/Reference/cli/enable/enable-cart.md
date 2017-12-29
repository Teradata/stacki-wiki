## enable cart

### Usage

`stack enable cart {cart ...} [box=string]`

### Description


	Enable an available cart. The cart must already be initialized on the
	system using the command "stack add cart".

	

### Arguments

* `[cart]`

   List of carts to enable. This should be the cart base name (e.g.,
	stacki, boss, os).


### Parameters
* `{box=string}`

   The name of the box in which to enable the cart. If no box is
	specified the cart is enabled for the default box.

### Examples

* `stack enable cart local`

   Enable the cart named "local".


### Related
[add cart](add-cart)

[disable cart](disable-cart)

[list cart](list-cart)


