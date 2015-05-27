## add host bridge

### Usage

`stack add host bridge {host} [iface=string] [name=string] [network=string]`

### Description

Add a bridge interface to a given host

### Arguments

* `{host}`

   Hostname


### Parameters
* `[iface=string]`

   Physical interface to be bridged
* `[name=string]`

   Name for the bridge interface.
* `[network=string]`

   Name of the network on which the physical
	device to be bridged exists.

### Examples

* `stack add host bridge compute-0-0 name=cloudbr0  network=private iface=eth0`

   This command will create a bridge called "cloudbr0", and
	attach it to physical interface eth0 and place it on the
	private network.


