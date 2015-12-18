## report script

### Usage

`stack report script [arch=string] [attrs=string] [os=string]`

### Description

Take STDIN XML input and create a shell script that can be executed
	on a host.

### Examples

* `stack report host interface compute-0-0 | rocks report script`

   Take the network interface XML output from 'rocks report host interface'
	and create a shell script.



