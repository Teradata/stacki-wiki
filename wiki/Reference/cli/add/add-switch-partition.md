## add switch partition

### Usage

`stack add switch partition {switch} {name=string} [enforce_sm=boolean] [options=string]`

### Description


	Adds a partition for an Infiniband switch to the Stacki database.
	Note that a sync is still required to enact this change on the switch.

	

### Arguments

* `[switch]`

   The name of the switches on which to create this partition.


### Parameters
* `[name=string]`
* `{enforce_sm=boolean}`
* `{options=string}`

   A set of options to create the partition with.  The format is 
	'flag=value flag2=value2'.  Currently supported are 'ipoib=True|False'
	and 'defmember=limited|full'.  Unless explicitly specified, 'ipoib' and
	'defmember' are not set.


