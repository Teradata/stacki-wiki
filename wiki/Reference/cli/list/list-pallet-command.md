## list pallet command

### Usage

`stack list pallet command [pallet ...] [arch=string] [os=string] [release=string] [version=string]`

### Description


	List the commands provided by a pallet.

	

### Arguments

* `{pallet}`

   List of pallets. This should be the pallet base names (e.g., base, hpc,
	kernel). If no pallets are listed, then commands for all the pallets
	are listed.


### Parameters
* `{arch=string}`
* `{os=string}`
* `{release=string}`
* `{version=string}`

   The version number of the pallets to list. If no version number is
	supplied, then all versions of a pallet will be listed.

### Examples

* `stack list pallet command stacki`

   Returns the the list of commands installed by the stacki pallet.



