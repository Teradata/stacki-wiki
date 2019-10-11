## list host hash

### Usage

`stack list host hash {host} [profile=boolean]`

### Description


	Calculate and list the MD5 hashes of a host's:

		- pallets
		- carts
		- profile (e.g., kickstart file, autoyast file, etc.)

	

### Arguments

* `[host]`

   Host name of machine


### Parameters
* `{profile=boolean}`

   If 'yes', output a hash for the host(s) profile.
	Default is 'no'.

### Examples

* `stack list host hash backend-0-0`

   Create an install hash for backend-0-0.



