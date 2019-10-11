## list cart

### Usage

`stack list cart [cart ...] {expanded=string}`

### Description


	List the status of available carts.
	
	

### Arguments

* `{cart}`

   List of carts. This should be the cart base name (e.g., stacki, os,
	etc.). If no carts are listed, then status for all the carts are
	listed.


### Parameters
* `[expanded=string]`

   Include the source url of the cart.

### Examples

* `stack list cart kernel`

   List the status of the kernel cart.

* `stack list cart`

   List the status of all the available carts.

* `stack list cart expanded=True`

   List the status of all the available carts and their source urls.



