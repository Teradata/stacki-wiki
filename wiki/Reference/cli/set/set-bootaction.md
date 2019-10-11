## set bootaction

### Usage

`stack set bootaction {action} [args=string] [kernel=string] [os=string] [ramdisk=string] [type=string]`

### Description


	Set a bootaction specification.

	

### Arguments

* `[action]`

   Label name for the bootaction. You can see the bootaction label names by
	executing: 'stack list bootaction [host(s)]'.


### Parameters
* `{args=string}`
* `{kernel=string}`
* `{os=string}`
* `{ramdisk=string}`
* `{type=string}`

   Type of bootaction. Either 'os' or 'install'.

### Examples

* `stack set bootaction os type=os kernel="localboot 0"`

   Set the 'os' bootaction.

* `stack set bootaction memtest type=os kernel="kernel memtest"`

   Set the 'memtest' bootaction.



