## list pallet

### Usage

`stack list pallet [pallet ...] {expanded=bool} [arch=string] [os=string] [release=string] [version=string]`

### Description


	List the status of available pallets.

	

### Arguments

* `{pallet}`

   List of pallets. This should be the pallet base name (e.g., base, hpc,
	kernel). If no pallets are listed, then status for all the pallets are
	listed.


### Parameters
* `[expanded=bool]`
* `{arch=string}`
* `{os=string}`
* `{release=string}`
* `{version=string}`

   The version number of the pallets to list. If no version number is
	supplied, then all versions of a pallet will be listed.

### Examples

* `stack list pallet kernel`

   List the status of the kernel pallet.

* `stack list pallet`

   List the status of all the available pallets.

* `stack list pallet expanded=true`

   List the status of all the available pallets and their urls.


### Related
[add pallet](add-pallet)

[create pallet](create-pallet)

[disable pallet](disable-pallet)

[enable pallet](enable-pallet)

[remove pallet](remove-pallet)


