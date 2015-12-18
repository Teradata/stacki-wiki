## iterate host

### Usage

`stack iterate host [host ...] {command=string}`

### Description

Iterate sequentially over a list of hosts.  This is used to run 
	a shell command on the frontend with with '%' wildcard expansion for
	every host specified.

### Examples

* `stack iterate host backend command="scp file %:/tmp/"`

   Copies file to the /tmp directory of every backend node



