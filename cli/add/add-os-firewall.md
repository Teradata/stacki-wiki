## add os firewall

### Usage

`stack add os firewall {os} [action=string] [chain=string] [network=string] [output-network=string] [protocol=string] [rulename=string] [service=string] [table=string]`

### Description

Add a firewall rule for an OS type.

### Arguments

* `{os}`

   OS type (e.g., 'linux', 'sunos').


### Parameters
* `[action=string]`

   The iptables 'action' this rule should be applied to (e.g.,
	ACCEPT, REJECT, DROP).
* `[chain=string]`

   The iptables 'chain' this rule should be applied to (e.g.,
	INPUT, OUTPUT, FORWARD).
* `[network=string]`

   The network this rule should be applied to. This is a named network
        (e.g., 'private') and must be one listed by the command
        'rocks list network'.
	To have this firewall rule apply to all networks, specify the
	keyword 'all'.
* `[output-network=string]`

   The output network this rule should be applied to. This is a named
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

* `stack add os firewall linux network=private service="all" protocol="all" action="ACCEPT" chain="FORWARD"`

   Accept all services and all protocols from the private network on
	the FORWARD chain for Linux hosts.
	If 'eth0' is associated with the private network on a Linux host, then
	this will be translated as the following iptables rule:
	"-A FORWARD -i eth0 -j ACCEPT".



