## config host interface

### Usage

`stack config host interface {host} [flag=string] [interface=string] [mac=string] [module=string] [sync=bool]`

### Description


	!!! STACKIQ INTERNAL COMMAND ONLY !!!

	Configures host interfaces in the database.
	This command should only be called from a post section in a kickstart
	file.

	

### Arguments

* `[host]`

   Host name of machine


### Parameters
* `{flag=string}`
* `{interface=string}`
* `{mac=string}`
* `{module=string}`
* `{sync=bool}`

   When set to true, stack sync config is called. Defaults to true.


