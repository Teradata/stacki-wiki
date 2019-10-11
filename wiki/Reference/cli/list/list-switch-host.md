## list switch host

### Usage

`stack list switch host [switch ...]`

### Description


	List Interface, Port, Interface, Vlan, and Network of any hosts-to-switch
	relationships being managed.

	

### Arguments

* `{switch}`

   Zero, one or more switch names. If no switch names are supplies, info about
	all the known switchs is listed.


### Examples

* `stack list switch host switch-0-0`

   List hosts connected to switch-0-0.

* `stack list switch host`

   List any hosts on all known switches.



