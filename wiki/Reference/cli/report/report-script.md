## report script

### Usage

`stack report script [arch=string] [attrs=string] [os=string]`

### Description


	Take STDIN XML input and create a shell script that can be executed
	on a host.

	

### Parameters
* `{arch=string}`
* `{attrs=string}`
* `{os=string}`

   The OS type.

### Examples

* `stack report host interface backend-0-0 | stack report script`

   Take the network interface XML output from 'stack report host interface'
	and create a shell script.



