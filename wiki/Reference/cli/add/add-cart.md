## add cart

### Usage

`stack add cart [cart] [authfile=string] [downloaddir=string] [downloadonly=boolean] [file=string] [password=string] [url=string] [urlfile=string] [username=string]`

### Description


	Add a cart. Files to download are concatenated
	from "url," "urlfile," and "authfile" options
	if any files are designated in the authfile.
	
	

### Arguments

* `{cart}`

   The name of the cart to be created.
	Can also be a URL to a cart that we would like to download and add.


### Parameters
* `{authfile=string}`
* `{downloaddir=string}`
* `{downloadonly=boolean}`
* `{file=string}`
* `{password=string}`
* `{url=string}`
* `{urlfile=string}`
* `{username=string}`

   If the remote cart download server requires authentication.

### Examples

* `stack add cart urlfile=/tmp/tdurls downloaddir=/export authfile=/root/carts.json`

   Download the carts in /tmp/tdurls into /export.
	Use the username/password in /root/carts.json.

	Example json looks like this:
	{
	"username":"myuserid",
	"password":"mypassword"
	}

* `stack add cart authfile=/root/carts.json`

   Specify Username, Password, and Cart URL information in the carts.json file.
	{
		"username":"myuserid",
		"password":"mypassword",
		"urlbase": "https://sdartifact.td.teradata.com/artifactory",
		"files": [ "pkgs-generic-snapshot-sd/stacki-5/kubernetes/kubernetes-stacki5-12.02.18.02.12-rc3.tgz" ]
	}



