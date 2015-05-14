## create distro

### Usage

`stack create distro {distribution} [inplace=bool] [md5=bool] [resolve=bool] [rolls=string] [root=string]`

### Description

Create a Stack distribution. This distribution is used to install
	Stack nodes.

### Arguments

* `{distribution}`

   The name of the distribution to build. Use "stack list distribution"
	to get the list of all valid distributions.
	Default is "default".


### Parameters
* `[inplace=bool]`

   If true, then build the distribution in the current directory.
	Default is false.
* `[md5=bool]`

   If true, then calculate the MD5 checksums for all files in the
	distribution.
	Default is true.
* `[resolve=bool]`

   If true, then resolve RPM versions during the build so only the
        most recent is included in the distribution. Normally this is
        not required since yum and anaconda expect all versions to be
        present. Currently, this option exists for internal use only.
	Default is false.
* `[rolls=string]`

   A space separated list of rolls to use when building a distribution.
	
	"rollname,version" is required when delimiting rolls.
	
	For example: rolls="base,6.0 kernel,6.0 os,6.2".	
	Default is "None".
* `[root=string]`

   The root directory where the rolls are located.
	Default is "/export/stack".

### Examples

* `stack create distro`

   Create a RedHat distribution in /export/stack/distributions/default.



