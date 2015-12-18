## create pallet

### Usage

`stack create pallet {pallet ...} [name=string] [newest=boolean] [version=string]`

### Description

Create a pallet.  You may specify either a single XML file to build
	one pallet or a list of ISO files to build a Meta pallet.

### Examples

* `stack create pallet pallet-base.xml`

   Creates the Rocks Base pallet from the pallet-base.xml description file.

* `stack create pallet base*iso kernel*iso`

   Create a composite pallet from a list of pallet ISOs.


### Related
[add pallet](add-pallet)

[disable pallet](disable-pallet)

[enable pallet](enable-pallet)

[list pallet](list-pallet)

[remove pallet](remove-pallet)


