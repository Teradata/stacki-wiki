## open host console

### Usage

`stack open host console {host} [key=string] [vncflags=string]`

### Description

Open a console to a virtual machine.

### Arguments

* `{host}`

   Host name of machine.


### Parameters
* `[key=string]`

   A private key that will be used to authenticate the request. This
	should be a file name that contains the private key.
* `[vncflags=string]`

   VNC flags to be passed to the VNC viewer. The default flags are:
	"-log *:stderr:0 -FullColor -PreferredEncoding hextile". See the
	vncviewer man page for all the available options.


