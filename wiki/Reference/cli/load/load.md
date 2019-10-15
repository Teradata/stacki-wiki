## load

### Usage

`stack load [document=string] [exec=boolean] [force=boolean]`

### Description


	Load configuration data from the provided JSON document.

	A series of stack commands will be printed to STDOUT which, if run, would
	import the data in the JSON document into the stacki database.  Note, all of
	these commands are database manipulation - commands such as 'sync config',
	'sync host network', 'sync host boot', etc. must be run manually.

	

### Parameters
* `{document=string}`
* `{exec=boolean}`
* `{force=boolean}`

   If set to True, will disregard any non-syntax validation done on the json data.
	This is useful to, for example, load incomplete partitioning data, which the admin
	intends to complete later..
	Defaults to False.

### Examples

* `stack stack load dump.json | bash`

   The data in 'dump.json' will be converted into stack commands and run.


### Related
[dump](dump)


