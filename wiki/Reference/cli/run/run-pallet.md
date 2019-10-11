## run pallet

### Usage

`stack run pallet {pallet ...} [arch=string] [os=string] [release=string] [version=string]`

### Description


	Installs a pallet on the fly

	

### Arguments

* `[pallet]`

   List of pallets. This should be the pallet base name (e.g., base, hpc,
	kernel).


### Parameters
* `{arch=string}`
* `{os=string}`
* `{release=string}`
* `{version=string}`

   The version number of the pallets to be ran. If no version number is
	supplied, then all versions of a pallet will be ran.

### Examples

* `stack run pallet ubuntu`

   Installs the Ubuntu pallet onto the current system.



