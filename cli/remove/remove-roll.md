## remove roll

### Usage

`stack remove roll {roll}... [arch=string] [version=string]`

### Description

Remove a roll from both the database and filesystem.

### Arguments

* `{roll}`

   List of rolls. This should be the roll base name (e.g., base, hpc,
	kernel).


### Parameters
* `[arch=string]`

   The architecture of the roll to be removed. If no architecture is
	supplied, then all architectures will be removed.
* `[version=string]`

   The version number of the roll to be removed. If no version number is
	supplied, then all versions of a roll will be removed.

### Examples

* `stack remove roll kernel`

   Remove all versions and architectures of the kernel roll

* `stack remove roll ganglia version=5.0 arch=i386`

   Remove version 5.0 of the Ganglia roll for i386 nodes


### Related
[add roll](add-roll)

[create roll](create-roll)

[disable roll](disable-roll)

[enable roll](enable-roll)

[list roll](list-roll)


