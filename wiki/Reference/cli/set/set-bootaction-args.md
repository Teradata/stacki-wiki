## set bootaction args

### Usage

`stack set bootaction args {action} {args=string} [os=string] [type=string]`

### Description


	Updates the args for a bootaction.

	

### Arguments

* `[action]`

   Name of the bootaction that needs to be updated.


### Parameters
* `[args=string]`
* `{os=string}`
* `{type=string}`

   type of the bootaction. Can be install or os.

### Examples

* `stack set bootaction args headless args="ip=bootif:dhcp inst.ks=https://10.25.241.117/install/sbin/profile.cgi" type="install" os="redhat"`

   Sets the args for bootaction named headless with type="install" and os="redhat"
	to be "ip=bootif:dhcp inst.ks=https://10.25.241.117/install/sbin/profile.cgi".



