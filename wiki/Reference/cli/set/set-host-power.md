## set host power

### Usage

`stack set host power {host ...} {command=string} [debug=boolean] [method=string]`

### Description


	Sends a "power" command to a host. Valid power commands are: on, off, reset, and status. This
	command uses IPMI for hardware based hosts to change the power setting.

	

### Arguments

* `[host]`

   One or more host names.


### Parameters
* `[command=string]`
* `{debug=boolean}`
* `{method=string}`

   Set a desired method for communicating to hosts, possible methods
	include but are not limited to ipmi and ssh.

### Examples

* `stack set host power stacki-1-1 command=reset`

   Performs a hard power reset on host stacki-1-1.

* `stack set host power stacki-1-1 command=off method=ssh`

   Turns off host stacki-1-1 using ssh.



