## sync host firewall

### Usage

`stack sync host firewall [restart=boolean]`

### Description


	Reconfigure and optionally restart firewall for named hosts.

	

### Parameters
* `{restart=boolean}`

   If "yes", then restart iptables after the configuration files are
	applied on the host.
	The default is: yes.

### Examples

* `stack sync host firewall backend-0-0`

   Reconfigure and restart the firewall on backend-0-0.



