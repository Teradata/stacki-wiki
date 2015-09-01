## report script

### Usage

`stack report script [arch=string] [attrs=string] [os=string]`

### Description

Take STDIN XML input and create a shell script that can be executed
	on a host.

### Parameters
* `[arch=string]`

   The architecture type.
* `[attrs=string]`

   Attributes to be used while building the output shell script.
* `[os=string]`

   The OS type.

### Examples

* `stack report host interface compute-0-0 | rocks report script`

   Take the network interface XML output from 'rocks report host interface'
	and create a shell script.



