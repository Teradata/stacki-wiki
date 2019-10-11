## pack cart

### Usage

`stack pack cart {cart} [compression=string] [suffix=string]`

### Description


	Pack a cart into a compressed file.
	Default is tgz.

	Compressed file is output in the current 
	working directory, so don't do it in the
	cart directory you're compressing. 

	No, really, you'll be in recursive hell and
	then where will you be?
	
	GroundHog Day my friend, GroundHog Day.

	

### Arguments

* `[cart]`

   The name of the cart to be compressed.


### Parameters
* `{compression=string}`
* `{suffix=string}`

   Put the suffix on the subsequent cart file.
	Default is tgz.

### Examples

* `stack pack cart site-custom`

   Tars up site-custom into site-custom.tgz.
	Includes all dirs but repodata and fingerprint.

	This does NOT remove the cart from the system.


### Related
[unpack cart file=](unpack-cart-file=)


