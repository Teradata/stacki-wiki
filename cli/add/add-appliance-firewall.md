## add appliance firewall

### Usage

`stack add appliance firewall {appliance ...} [action=string] [chain=string] [network=string] [output-network=string] [protocol=string] [rulename=string] [service=string] [table=string]`

### Description


Add a firewall rule for an appliance type.



### Arguments

* `[appliance]`

   Appliance type (e.g., "backend").


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

* `stack add appliance firewall login network=private service="all" protocol="all" action="ACCEPT" chain="FORWARD"`

   Accept all services and all protocols on the private network for the
	FORWARD chain.
	If 'eth0' is associated with the private network on a login appliance,
	then this will be translated as the following iptables rule:
	"-A FORWARD -i eth0 -j ACCEPT"

* `stack add appliance firewall login network=all service="8649" protocol="udp" action="REJECT" chain="INPUT"`

   Reject UDP packets with a destination port of 8649 on all networks for
	the INPUT chain.
	On login appliances, this will be translated into the following
	iptables rule:
	"-A INPUT -p udp --dport 8649 -j REJECT"



