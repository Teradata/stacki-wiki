## add roll

### Usage

`stack add roll [roll]... [clean=bool] [dir=string] [updatedb=string]`

### Description

Add Roll ISO images to this machine's roll directory. This command
	copies all files in the ISOs to the local machine. The default location
	is a directory under /export/rocks/rolls.

### Arguments

* `[roll]`

   A list of Roll ISO images to add to the local machine. If no list is
	supplied, then if a roll is mounted on /mnt/cdrom, it will be copied
	to the local machine.


### Parameters
* `[clean=bool]`

   If set, then remove all files from any existing rolls of the same
	name, version, and architecture before copying the contents of the
	Rolls onto the local disk.  This parameter should not be set
	when adding multi-CD Rolls such as the OS Roll, but should be set
	when adding single Roll CDs such as the Grid Roll.
* `[dir=string]`

   The base directory to copy the roll to.
	The default is: /export/rocks/rolls.
* `[updatedb=string]`

   Add the roll info to the cluster database.
	The default is: true.

### Examples

* `stack add roll clean=1 kernel*iso`

   Adds the Kernel Roll to local Roll directory.  Before the Roll is
	added the old Kernel Roll packages are removed from the Roll directory.

* `stack add roll kernel*iso pvfs2*iso ganglia*iso`

   Added the Kernel, PVFS, and Ganglia Rolls to the local Roll
	directory.


### Related
[create roll](create-roll)

[disable roll](disable-roll)

[enable roll](enable-roll)

[list roll](list-roll)

[remove roll](remove-roll)


