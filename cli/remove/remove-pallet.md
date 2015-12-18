## remove pallet

### Usage

`stack remove pallet {pallet ...} [arch=string] [version=string]`

### Description

Remove a pallet from both the database and filesystem.

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


