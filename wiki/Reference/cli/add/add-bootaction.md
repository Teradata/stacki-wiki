## add bootaction

### Usage

`stack add bootaction {action} [args=string] [kernel=string] [os=string] [ramdisk=string] [type=string]`

### Description


	Add a bootaction specification to the system.
	
	

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

* `stack add bootaction os type=os kernel="localboot 0"`

   Add the 'os' bootaction.

* `stack add bootaction memtest type=os kernel="kernel memtest"`

   Add the 'memtest' bootaction.



