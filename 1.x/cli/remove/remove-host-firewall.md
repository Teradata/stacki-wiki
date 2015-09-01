## remove host firewall

### Usage

`stack remove host firewall {host} [rulename=string]`

### Description

Remove a firewall rule for a host. To remove a rule,
	you must supply the name of the rule. The Rule names may
	be obtained by running "rocks list host firewall"

### Arguments

* `{host}`

   Name of a host machine.


### Parameters
* `[rulename=string]`

   Name of host-specific rule


