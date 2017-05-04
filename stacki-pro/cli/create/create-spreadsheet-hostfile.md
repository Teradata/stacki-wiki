## create spreadsheet hostfile

### Usage

`stack create spreadsheet hostfile [appliance=string] [chatty=boolean] [hosts=string] [interface=string] [ipfile=string] [ipmi=boolean] [network=string] [network_name=string] [output-file=string] [output-headers=string] [rack=string] [rank=string] [rosterfile=string] [sshport=string]`

### Description

Create a hostfile spreadsheet for brownfield. Outputs a CSV
	file to /root/discovered_hosts.csv by default. This file
	can be used by "stack load hostfile" to preseed the database.

### Parameters
* `{appliance=string}`
* `{chatty=boolean}`
* `{hosts=string}`
* `{interface=string}`
* `{ipfile=string}`
* `{ipmi=boolean}`
* `{network=string}`
* `{network_name=string}`
* `{output-file=string}`
* `{output-headers=string}`
* `{rack=string}`
* `{rank=string}`
* `{rosterfile=string}`
* `{sshport=string}`

   We can scan for an ssh network and get the hosts. We assume port 22.
	If ssh is running on a different port, do that here.

### Examples

* `stack create spreadsheet hostfile`

   Basic:
	stack create spreadsheet hostfile network=10.3.255.0/24 
	Intermediate:
	stack create spreadsheet hostfile network=10.3.255.0/24 
	network_name=public 
	Advanced:
	stack create spreadsheet hostfile network=10.3.255.0/24 rack=10 rank=3
	network_name=public appliance=edge



