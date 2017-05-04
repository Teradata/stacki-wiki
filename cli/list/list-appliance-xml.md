## list appliance xml

### Usage

`stack list appliance xml [appliance ...]`

### Description

Lists the XML profile for a given appliance type. This is useful
	for high level debugging but will be missing any host specific
	variables. It cannot be used to pass into 'rocks list host profile'
	to create a complete Kickstart/Jumpstart profile.

### Arguments

* `{appliance}`

   Optional list of appliance names.


### Examples

* `stack list appliance xml compute`

   Lists the XML profile for a compute appliance.

* `stack list appliance xml`

   Lists the XML profile for all appliance types.



