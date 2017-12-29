## set bootaction kernel

### Usage

`stack set bootaction kernel [bootaction] [kernel=string] [os=string] [type=string]`

### Description


	Updates the kernel for a bootaction.
	

### Arguments

* `{bootaction}`

   Name of the bootaction that needs to be updated.


### Parameters
* `{kernel=string}`
* `{os=string}`
* `{type=string}`

   type of the bootaction. Can be install or os.

### Examples

* `stack set bootaction kernel memtest kernel="memtest" type="os" os="redhat"`

   Sets the kernel for bootaction named memtest with type="os" and os="redhat" 
	to be "memtest".



