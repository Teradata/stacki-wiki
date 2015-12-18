## disable pallet

### Usage

`stack disable pallet {pallet ...} [arch=string] [box=string] [version=string]`

### Description

Disable an available pallet. The pallet must already be copied on the
	system using the command "stack add pallet".

### Examples

* `stack disable pallet kernel`

   Disable the kernel pallet.

* `stack disable pallet ganglia version=5.0 arch=i386`

   Disable version 5.0 the Ganglia pallet for i386 nodes


### Related
[add pallet](add-pallet)

[create pallet](create-pallet)

[enable pallet](enable-pallet)

[list pallet](list-pallet)

[remove pallet](remove-pallet)


