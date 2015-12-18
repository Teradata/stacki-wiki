## list host boot

### Usage

`stack list host boot [host ...]`

### Description

Lists the current bot action for hosts. For each host supplied on the
	command line, this command prints the hostname and boot action for
	that host. The boot action describes what the host will do the next
	time it is booted.

### Examples

* `stack list host boot compute-0-0`

   List the current boot action for compute-0-0.

* `stack list host boot`

   List the current boot action for all known hosts.



