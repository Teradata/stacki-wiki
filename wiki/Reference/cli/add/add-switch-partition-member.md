## add switch partition member

### Usage

`stack add switch partition member {switch} {name=string} [enforce_sm=boolean] [guid=string] [interface=string] [member=string] [membership=string]`

### Description


	Add members to an infiniband partition in the Stacki database for one or
	more switches.

	

### Arguments

* `[switch]`

   The name of the switches to add partition members to.


### Parameters
* `[name=string]`
* `{enforce_sm=boolean}`
* `{guid=string}`
* `{interface=string}`
* `{member=string}`
* `{membership=string}`

   The membership state to use for this member on the partition.  Must be 'both',
	or 'limited'.  Defaults to 'limited'.


