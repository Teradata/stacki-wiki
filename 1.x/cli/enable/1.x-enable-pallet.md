## enable pallet

### Usage

`stack enable pallet {pallet}... [arch=string] [distribution=string] [version=string]`

### Description

Enable an available pallet. The pallet must already be copied on the
	system using the command "stack add pallet".

### Arguments

* `{pallet}`

   List of pallets to enable. This should be the pallet base name (e.g.,
	base, hpc, kernel).


### Parameters
* `[arch=string]`

   If specified enables the pallet for the given architecture.  The default
	value is the native architecture of the host.
* `[distribution=string]`

   The name of the distribution on which to enable the roll. If no
	distribution is specified the roll is enabled for the default
	distribution.
* `[version=string]`

   The version number of the pallet to be enabled. If no version number is
	supplied, then all versions of a pallet will be enabled.

### Examples

* `stack enable pallet kernel`

   Enable the kernel pallet.

* `stack enable pallet ganglia version=5.0 arch=i386`

   Enable version 5.0 the Ganglia pallet for i386 nodes.


### Related
[add pallet](add-pallet)

[create pallet](create-pallet)

[disable pallet](disable-pallet)

[list pallet](list-pallet)

[remove pallet](remove-pallet)


