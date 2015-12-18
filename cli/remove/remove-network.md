## remove network

### Usage

`stack remove network {network ...}`

### Description

Remove network definition from the system. If there are still nodes
	defined in the database that are assigned to the network name you
	are trying to remove, the command will not remove the network
	definition and print a message saying it cannot remove the network.

### Examples

* `stack remove network private`

   Remove network info for the network named 'private'.



