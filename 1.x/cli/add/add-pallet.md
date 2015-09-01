## add pallet

### Usage

`stack add pallet [pallet]... [clean=bool] [dir=string] [updatedb=string]`

### Description

Add pallet ISO images to this machine's pallet directory. This command
	copies all files in the ISOs to the local machine. The default location
	is a directory under /export/stack/pallets.

### Arguments

* `[pallet]`

   A list of pallet ISO images to add to the local machine. If no list is
	supplied, then if a pallet is mounted on /mnt/cdrom, it will be copied
	to the local machine.


### Parameters
* `[clean=bool]`

   If set, then remove all files from any existing pallets of the same
	name, version, and architecture before copying the contents of the
	pallets onto the local disk.  This parameter should not be set
	when adding multi-CD pallets such as the OS pallet, but should be set
	when adding single pallet CDs such as the Grid pallet.
* `[dir=string]`

   The base directory to copy the pallet to.
	The default is: /export/stack/pallets.
* `[updatedb=string]`

   Add the pallet info to the cluster database.
	The default is: true.

### Examples

* `stack add pallet clean=1 kernel*iso`

   Adds the Kernel pallet to local pallet directory.  Before the pallet is
	added the old Kernel pallet packages are removed from the pallet
	directory.

* `stack add pallet kernel*iso pvfs2*iso ganglia*iso`

   Added the Kernel, PVFS, and Ganglia pallets to the local pallet
	directory.


### Related
[create pallet](create-pallet)

[disable pallet](disable-pallet)

[enable pallet](enable-pallet)

[list pallet](list-pallet)

[remove pallet](remove-pallet)


