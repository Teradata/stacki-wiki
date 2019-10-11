## set bootaction ramdisk

### Usage

`stack set bootaction ramdisk {action} {ramdisk=string} [os=string] [type=string]`

### Description


	Updates the ramdisk for a bootaction.

	

### Arguments

* `[action]`

   Name of the bootaction that needs to be updated.


### Parameters
* `[ramdisk=string]`
* `{os=string}`
* `{type=string}`

   type of the bootaction. Can be install or os.

### Examples

* `stack set bootaction ramdisk memtest ramdisk="initrd.img-5.0-7.x-x86_64" type="os" os="redhat"`

   Sets the ramdisk for bootaction named memtest with type="os" and os="redhat"
	to be "initrd.img-5.0-7.x-x86_64".



