## remove pallet

### Usage

`stack remove pallet {pallet ...} [arch=string] [release=string] [version=string]`

### Description


	Remove a pallet from both the database and filesystem.	

	

### Arguments

* `[pallet]`

   List of pallets. This should be the pallet base name (e.g., base, hpc,
	kernel).


### Parameters
* `{arch=string}`
* `{release=string}`
* `{version=string}`

   The version number of the pallet to be removed. If no version number is
	supplied, then all versions of a pallet will be removed.

### Examples

* `stack remove pallet kernel`

   Remove all versions and architectures of the kernel pallet.

* `stack remove pallet ganglia version=5.0 arch=i386`

   Remove version 5.0 of the Ganglia pallet for i386 nodes.


### Related
[add pallet](add-pallet)

[create pallet](create-pallet)

[disable pallet](disable-pallet)

[enable pallet](enable-pallet)

[list pallet](list-pallet)


