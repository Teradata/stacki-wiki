## set host power

### Usage

`stack set host power {host}... [action=string] [key=string]`

### Description

Turn the power for a host on or off.

### Arguments

* `{host}`

   One or more host names.


### Parameters
* `[action=string]`

   The power setting. This must be one of 'on', 'off' or 'install'.
	The 'install' action will turn the power on and force the host to
	install.
* `[key=string]`

   A private key that will be used to authenticate the request. This
        should be a file name that contains the private key.

### Examples

* `stack set host power compute-0-0 action=on`

   Turn on the power for compute-0-0.



