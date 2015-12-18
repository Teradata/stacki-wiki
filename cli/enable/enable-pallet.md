## enable pallet

### Usage

`stack enable pallet {pallet ...} [arch=string] [box=string] [release=string] [version=string]`

### Description

Enable an available pallet. The pallet must already be copied on the
	system using the command "stack add pallet".

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


