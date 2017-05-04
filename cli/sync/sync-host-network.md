## sync host network

### Usage

`stack sync host network [restart=boolean]`

### Description

Reconfigure and optionally restart the network for the named hosts.

### Parameters
* `{restart=boolean}`

   If "yes", then restart the network after the configuration files are
	applied on the host.
	The default is: yes.

### Examples

* `stack sync host network compute-0-0`

   Reconfigure and restart the network on compute-0-0.



