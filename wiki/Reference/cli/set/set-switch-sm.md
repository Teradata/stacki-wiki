## set switch sm

### Usage

`stack set switch sm {switch} [disable=boolean]`

### Description


	Enable the subnet manager for the given switch.

	

### Arguments

* `[switch]`

   Exactly one infiniband switch name which will become the subnet manager for
	the fabric it is on.  All other infiniband switches on the same fabric will
	have their subnet manager status disabled.  Fabric is determined soley based
	on the 'ibfabric' attribute.


### Parameters
* `{disable=boolean}`

   When set to True, will disable subnet manager status on that switch only.
	Defaults to False.

### Examples

* `stack set switch sm infiniband-3-12`

   Set the switch infiniband-3-12 to be the only subnet manager for its fabric.



