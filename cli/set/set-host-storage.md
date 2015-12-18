## set host storage

### Usage

`stack set host storage [host ...] {action=string} {enclosure=string} {slot=string}`

### Description

Set state for a storage device for hosts (e.g., to change the state
	of a disk from 'offline' to 'online').

### Examples

* `stack set host storage compute-0-0 enclosure=32 slot=5  action=online`

   Set the storage device located at '32:5' to "online" for compute-0-0.



