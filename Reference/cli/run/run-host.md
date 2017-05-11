## run host

### Usage

`stack run host [host ...] {command=string} [collate=string] [delay=string] [managed=boolean] [threads=string] [timeout=string] [x11=boolean]`

### Description

Run a command for each specified host.

### Arguments

* `{host}`

   Zero, one or more host names. If no host names are supplied, the command
	is run on all 'managed' hosts. By default, all compute nodes are
	'managed' nodes. To determine if a host is managed, execute:
	'rocks list host attr hostname | grep managed'. If you see output like:
	'compute-0-0: managed true', then the host is managed.


### Parameters
* `[command=string]`
* `{collate=string}`
* `{delay=string}`
* `{managed=boolean}`
* `{threads=string}`
* `{timeout=string}`
* `{x11=boolean}`

   If 'yes', enable X11 forwarding when connecting to hosts.
	Default is 'no'.

### Examples

* `stack run host backend-0-0 command="hostname"`

   Run the command 'hostname' on backend-0-0.

* `stack run host backend command="ls /tmp"`

   Run the command 'ls /tmp/' on all backend nodes.



