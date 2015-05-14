## disable roll

### Usage

`stack disable roll {roll}... [arch=string] [dist=string] [version=string]`

### Description

Disable an available roll. The roll must already be copied on the
	system using the command "rocks add roll".

### Arguments

* `{roll}`

   List of rolls to disable. This should be the roll base name (e.g.,
	base, hpc, kernel).


### Parameters
* `[arch=string]`

   If specified enables the roll for the given architecture.  The default
	value is the native architecture of the host.
* `[dist=string]`

   The name of the distribution on which to enable the roll. If no
	distribution is specified the roll is enabled for the default
	distribution.
* `[version=string]`

   The version number of the roll to be disabled. If no version number is
	supplied, then all versions of a roll will be disabled.

### Examples

* `stack disable roll kernel`

   Disable the kernel roll

* `stack disable roll ganglia version=5.0 arch=i386`

   Disable version 5.0 the Ganglia roll for i386 nodes


### Related
[add roll](add-roll)

[create roll](create-roll)

[enable roll](enable-roll)

[list roll](list-roll)

[remove roll](remove-roll)


