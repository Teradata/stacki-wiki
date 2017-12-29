## unpack cart

### Usage

`stack unpack cart {cart} [file=string]`

### Description


	Unpack a cart into the carts directory.
	
	Assumes it was packed with "stack pack cart."

	Also assumes the cart name matches the xml
	file naming scheme.

	If your cart wasn't, don't come crying to me.

	File is uncompressed into /export/stack/carts/.

	If the cart doesn't exist, it's added to the 
	database.

	

### Arguments

* `[cart]`

   The name of the cart to be created.


### Parameters
* `{file=string}`

   A bz2, xz, or gz file with your cart in it.


