## add host firewall

### Usage

`stack add host firewall {host ...} [action=string] [chain=string] [comment=string] [flags=string] [network=string] [output-network=string] [protocol=string] [rulename=string] [service=string] [table=string]`

### Description


	Add a firewall rule for the specified hosts.

	

### Arguments

* `[host]`

   Host name of machine


### Parameters
* `{action=string}`
* `{chain=string}`
* `{comment=string}`
* `{flags=string}`
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

* `stack add host firewall localhost network=private service="all" protocol="all" action="ACCEPT" chain="FORWARD"`

   Accept all services and all protocols from the private network on
	the FORWARD chain.
	If 'eth0' is associated with the private network, then this will
	be translated as the following iptables rule:
	"-A FORWARD -i eth0 -j ACCEPT".

* `stack add host firewall localhost network=all service="40000"  protocol="tcp" action="REJECT" chain="INPUT"`

   Reject TCP packets that are destined for port 40000 on all networks
	on the INPUT chain.
	This will be translated into the following rule:
	"-A INPUT -p tcp --dport 40000 -j REJECT"



