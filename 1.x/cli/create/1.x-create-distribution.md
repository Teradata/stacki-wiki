## create distribution

### Usage

`stack create distribution {distribution} [inplace=bool] [md5=bool] [pallets=string] [resolve=bool] [root=string]`

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
* `[pallets=string]`

   A space separated list of pallets to use when building a distribution.
	"name,version" is required when delimiting pallets.
	
	For example: pallets="base,6.0 kernel,6.0 os,6.2".	
	Default is "None".
* `[resolve=bool]`

   If true, then resolve RPM versions during the build so only the
        most recent is included in the distribution. Normally this is
        not required since yum and anaconda expect all versions to be
        present. Currently, this option exists for internal use only.
	Default is false.
* `[root=string]`

   The root directory where the pallets are located.
	Default is "/export/stack".

### Examples

* `stack create distribution`

   Create a RedHat distribution in /export/stack/distributions/default.



