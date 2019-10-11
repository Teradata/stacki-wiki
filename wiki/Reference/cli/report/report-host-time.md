## report host time

### Usage

`stack report host time {host}`

### Description


	Create a time configuration report (NTP or chrony).
	At a minimum at least one server in the cluster has to be designated as a "parent"
	time server. This ensures that there's atleast one server in the cluster that can
	serve time. By default, the stacki frontend is a parent timekeeper.
	Ideally, a "parent" time server will also have the "time.servers" attribute set
	to talk to an external time server, so that the cluster is in sync with the external
	time-keeping entity.

	Relevant Attributes:

	time.servers -	Optional - Comma-separated list of servers (IP addresses
			or resolvable names) that dictate the servers to use for time-keeping.
			This list is in *addition* to the Stacki frontend.

	time.orphantype - Required for at-least one host in the cluster.
			Only the value of "parent" affects the behaviour
			of the NTP service. If a host is designated as a
			parent Orphan-type, that means this host can
			co-ordinate time with other peers to maintain
			time on the time island.

	time.protocol - Optional - Can take the value of "chrony" or "ntp". Default
			Stacki behaviour is to use chrony for all hosts, except SLES 11 hosts.
			SLES 11 hosts use NTP by default

	

### Arguments

* `[host]`

   Host name of machine


### Examples

* `stack report host time backend-0-0`

   Create a time configuration file for backend-0-0.

	*Configuration*
	Scenario 1: Use Frontend for time keeping
	If the desired behavior is to use the frontend as the primary, and only time server,
	no configuration changes have to be made in Stacki. This is the default behavior.

	Scenario 2: Use frontend for time keeping, in sync with an external time server.
	Set time.servers attribute on the frontend to the IP Address, or Hostname of an external time server.
	This will set the frontend to sync time against an external time server, and all other hosts to
	sync time from the frontend.

	Scenario 3: Sync time on all hosts using an external time server only.
	Unset the frontend appliance attribute of time.orphantype. This will disable the frontend
	from serving time.
	Set the time.servers attribute for all hosts to the IP address, or Hostname of external
	time server. This will require that all hosts can contact, and connect to the external time
	server.

	Scenario 4: Sync time on some hosts from external time servers, and create a time island.
	Set some of the hosts' time.orphantype attribute to parent. Then set those hosts' time.servers
	attribute to the IP address, or Hostname of external time server. The list of parent time servers
	can include the frontend or not.

	Scenario 5: Don't use Stacki to sync time.
	To do this, make sure that the time.protocol attribute is not set for a host or a set of hosts.



