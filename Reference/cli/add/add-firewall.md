---
layout: page
title: add firewall
permalink: /add-firewall
sidebarloc: /Reference/cli/add
---

## add firewall

### Usage

`stack add firewall [action=string] [chain=string] [network=string] [output-network=string] [protocol=string] [rulename=string] [service=string] [table=string]`

### Description

Add a global firewall rule for the all hosts in the cluster.

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

* `stack add firewall network=public service="ssh" protocol="tcp" action="ACCEPT" chain="INPUT" flags="-m state --state NEW" table="filter" rulename="accept_public_ssh"`

   Accept TCP packets for the ssh service on the public network on
	the INPUT chain in the "filter" table and apply the "-m state --state NEW"
	flags to the rule.
	If 'eth1' is associated with the public network, this will be
	translated as the following iptables rule:
	"-A INPUT -i eth1 -p tcp --dport ssh -m state --state NEW -j ACCEPT"

* `stack add firewall network=private service="all" protocol="all" action="ACCEPT" chain="INPUT"`

   Accept all protocols and all services on the private network on the
	INPUT chain.
	If 'eth0' is the private network, then this will be translated as
	the following iptables rule:
	"-A INPUT -i eth0 -j ACCEPT"



