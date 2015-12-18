## set host boot

### Usage

`stack set host boot {host ...} [action=string]`

### Description

Set a bootaction for a host. A hosts action can be set to 'install' 
	or to 'os' (also, 'run' is a synonym for 'os').

### Examples

* `stack set host boot compute-0-0 action=os`

   On the next boot, compute-0-0 will boot the profile based on its
	"run action". To see the node's "run action", execute:
	"rocks list host compute-0-0" and examine the value in the
	"RUNACTION" column.



