## list host xml

### Usage

`stack list host xml [host]...`

### Description

Lists the monolithic XML configuration file for hosts. For each host
	supplied on the command line, this command prints the hostname and
	XML file configuration for that host. This is the same XML
	configuration file that is sent back to a host when a host begins
	it's installation procedure.

### Arguments

* `[host]`

   Zero, one or more host names. If no host names are supplied, info about
	all the known hosts is listed.


### Examples

* `stack list host xml compute-0-0`

   List the XML configuration file for compute-0-0.

* `stack list host xml`

   List the XML configuration files for all known hosts.



