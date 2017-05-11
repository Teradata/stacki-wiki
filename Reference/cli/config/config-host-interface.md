## config host interface

### Usage

`stack config host interface {host} [flag=string] [interface=string] [mac=string] [module=string]`

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

   Driver modules to be loaded for the interfaces. If multiple modules
	are supplied, then they must be comma-separated.


