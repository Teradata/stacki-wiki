## remove host bootflags

### Usage

`stack remove host bootflags {host}...`

### Description

Remove the kernel boot flags for a list of hosts.

### Arguments

* `{host}`

   List of hosts to remove kernel boot flag definitions. If no hosts are
	listed, then the global definition is removed.


### Examples

* `stack remove host bootflags compute-0-0`

   Remove the kernel boot flags definition for compute-0-0.



