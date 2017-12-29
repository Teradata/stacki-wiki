## remove bootaction

### Usage

`stack remove bootaction {action} [os=string] [type=string]`

### Description


	Remove a boot action specification from the system.

	

### Arguments

* `[action]`

   The label name for the boot action. You can see the boot action label
	names by executing: 'stack list bootaction'.


### Parameters
* `{os=string}`
* `{type=string}`

   The 'type' parameter should be either 'os' or 'install'.

### Examples

* `stack remove bootaction action=default type=install`

   Remove the default bootaction for installation.



