## sync host network

### Usage

`stack sync host network [restart=boolean]`

### Description


	Reconfigure and optionally restart the network for the named hosts.

	Note that this will always trigger a 'stack sync config' on the Frontend.

	

### Parameters
* `{restart=boolean}`

   If "yes", then restart the network after the configuration files are
	applied on the host.
	The default is: yes.

### Examples

* `stack sync host network backend-0-0`

   Reconfigure and restart the network on backend-0-0.



