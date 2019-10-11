## list host attr

### Usage

`stack list host attr [host] [attr=string] [display=string]`

### Description


	Lists the set of attributes for hosts.

	

### Arguments

* `{host}`

   Host name of machine


### Parameters
* `{attr=string}`
* `{display=string}`

   Control which attributes are displayed for the provided
	hosts.

	'all' will display all attributes for each host, grouped
	by host.  This is the default.

	'common' will display only attributes which are identical
	for every host.

	'distinct' will display only attributes which are not
	identical for every host.

### Examples

* `stack list host attr backend-0-0`

   List the attributes for backend-0-0.



