## add host key

### Usage

`stack add host key {host} [key=string]`

### Description


Add a public key for a host. One use of this public key is to
authenticate messages sent from remote services.



### Arguments

* `[host]`

   Host name of machine


### Parameters
* `{key=string}`

   A public key. This can be the actual key or it can be a path name to
	a file that contains a public key (e.g., /tmp/public.key).


