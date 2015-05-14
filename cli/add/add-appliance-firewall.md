## add appliance firewall

### Usage

`stack add appliance firewall {appliance} [action=string] [chain=string] [network=string] [output-network=string] [protocol=string] [rulename=string] [service=string] [table=string]`

### Description

Add a firewall rule for an appliance type.

### Arguments

* `{appliance}`

   Appliance type (e.g., "compute").


### Parameters
* `[action=string]`

   The iptables 'action' this rule (e.g., ACCEPT, REJECT, DROP).
* `[chain=string]`

   The iptables 'chain' for this this rule (e.g., INPUT, OUTPUT, FORWARD).
* `[network=string]`

   The network for this rule. This is a named network
        (e.g., 'private') and must be one listed by the command
        'rocks list network'.
	To have this firewall rule apply to all networks, specify the
	keyword 'all'.
* `[output-network=string]`

   The output network for this rule. This is a named
	network (e.g., 'private') and must be one listed by the command
        'rocks list network'.
* `[protocol=string]`

   The protocol associated with the service. For example, "tcp" or "udp".
	To have this firewall rule apply to all protocols, specify the
	keyword 'all'.
* `[rulename=string]`

   The rule name for the rule to add. This is the handle by
	which the admin can remove or override the rule.
* `[service=string]`

   The service identifier, port number or port range. For example
	"www", 8080 or 0:1024.
	To have this firewall rule apply to all services, specify the
	keyword 'all'.
* `[table=string]`

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



