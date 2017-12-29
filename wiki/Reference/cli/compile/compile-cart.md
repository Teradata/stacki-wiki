## compile cart

### Usage

`stack compile cart [cart ...]`

### Description


	Compile a repo inside the cart so it can be used by backend nodes
	for installation.
	
	

### Arguments

* `{cart}`

   List of carts. This should be the cart base name (e.g., stacki, os,
	etc.). If no cart names are specified, then compiles repos for all
	known carts.


### Examples

* `stack compile cart devel`

   Compile a repo for the devel cart.



