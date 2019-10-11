## set switch partition membership

### Usage

`stack set switch partition membership {switch} {name=string} [enforce_sm=boolean] [guid=string] [interface=string] [member=string] [membership=string]`

### Description


	Set membership state on an infiniband partition in the Stacki database for
	a switch.

	

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


