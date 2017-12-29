## create keys

### Usage

`stack create keys [key=string] [passphrase=boolean]`

### Description


	Create a RSA private/public key pair. These keys can be used to
	control the power for host and to open a console to VM. The private
	key will be stored in the specified by the 'key' parameter and the
	public key will be written to standard out.

	

### Parameters
* `{key=string}`
* `{passphrase=boolean}`

   Set this to 'no' if you want a passphraseless private key. The default
	is 'yes'.


