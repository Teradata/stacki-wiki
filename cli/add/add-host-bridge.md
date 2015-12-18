## add host bridge

### Usage

`stack add host bridge {host} [interface=string] [name=string] [network=string]`

### Description

Add a bridge interface to a given host.

### Examples

* `stack add host bridge backend-0-0 name=cloudbr0  network=private interface=eth0`

   This command will create a bridge called "cloudbr0", and
	attach it to physical interface eth0 and place it on the
	private network.



