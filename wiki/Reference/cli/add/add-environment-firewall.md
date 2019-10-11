## add environment firewall

### Usage

`stack add environment firewall {environment ...} {action=string} {chain=string} {protocol=string} {service=string} [comment=string] [flags=string] [network=string] [output-network=string] [rulename=string] [table=string]`

### Description


	Add a firewall rule for an environment.

	

### Arguments

* `[environment]`

   An environment name.


### Parameters
* `[action=string]`
* `[chain=string]`
* `[protocol=string]`
* `[service=string]`
* `{comment=string}`
* `{flags=string}`
* `{network=string}`
* `{output-network=string}`
* `{rulename=string}`
* `{table=string}`

   The table to add the rule to. Valid values are 'filter',
	'nat', 'mangle', and 'raw'. If this parameter is not
	specified, it defaults to 'filter'


