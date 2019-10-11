## set switch partition options

### Usage

`stack set switch partition options {switch} {name=string} [enforce_sm=boolean] [options=string]`

### Description


	Sets the infiniband partition flags in the Stacki database.
	Note that a sync is still required to enact this change on the switch.

	

### Arguments

* `[switch]`

   The name of the switches on which to set these options.


### Parameters
* `[name=string]`
* `{enforce_sm=boolean}`
* `{options=string}`

   A list of options to set on the partition.  The format is 
	'flag=value flag2=value2'.  Currently supported are 'ipoib=True|False'
	and 'defmember=limited|full'.  Unless explicitly specified, 'ipoib' and
	'defmember' are not set.


