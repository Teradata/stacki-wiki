## add pallet

### Usage

`stack add pallet [pallet ...] [clean=bool] [dir=string] [password=string] [updatedb=string] [username=string]`

### Description


	Add pallets to this machine's pallet directory. This command copies all
	files in ISOs or paths recognized by stacki to be pallets to the local
	machine. The default location is a directory under /export/stack/pallets.
	See also the 'probepal' utility to ascertain how, if at all, stacki will
	recognize it.

	

### Arguments

* `{pallet}`

   A list of pallets to add to the local machine. If no list is supplied
	stacki will check if a pallet is mounted on /mnt/cdrom, and if so copy it
	to the local machine. If the pallet is hosted on the internet, it will
	be downloaded to a temporary directory before being added.  All temporary
	files and mounts will be cleaned up, with the exception of /mnt/cdrom.


### Parameters
* `{clean=bool}`
* `{dir=string}`
* `{password=string}`
* `{updatedb=string}`
* `{username=string}`

   A username that will be used for authenticating to any remote pallet locations

### Examples

* `stack add pallet clean=true kernel*iso`

   Adds the Kernel pallet to local pallet directory.  Before the pallet is
	added the old Kernel pallet packages are removed from the pallet
	directory.

* `stack add pallet kernel*iso https://10.0.1.3/pallets/`

   Added the Kernel pallet along with any pallets found at the remote server
	 to the local pallet directory.


### Related
[create new pallet](create-new-pallet)

[create pallet](create-pallet)

[disable pallet](disable-pallet)

[enable pallet](enable-pallet)

[list pallet](list-pallet)

[remove pallet](remove-pallet)


