## add os firewall

### Usage

`stack add os firewall {os ...} [action=string] [chain=string] [network=string] [output-network=string] [protocol=string] [rulename=string] [service=string] [table=string]`

### Description


Add a firewall rule for an OS type.



### Arguments

* `[os]`

   OS type (e.g., 'linux', 'sunos').


### Parameters
* `{action=string}`
* `{chain=string}`
* `{network=string}`
* `{output-network=string}`
* `{protocol=string}`
* `{rulename=string}`
* `{service=string}`
* `{table=string}`

   The table to add the rule to. Valid values are 'filter',
	'nat', 'mangle', and 'raw'. If this parameter is not
	specified, it defaults to 'filter'

### Examples

* `stack add os firewall linux network=private service="all" protocol="all" action="ACCEPT" chain="FORWARD"`

   Accept all services and all protocols from the private network on
	the FORWARD chain for Linux hosts.
	If 'eth0' is associated with the private network on a Linux host, then
	this will be translated as the following iptables rule:
	"-A FORWARD -i eth0 -j ACCEPT".



