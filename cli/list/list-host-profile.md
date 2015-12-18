## list host profile

### Usage

`stack list host profile [host ...]`

### Description

Outputs a XML wrapped Kickstart/Jumpstart profile for the given hosts.
	If not, profiles are listed for all hosts in the cluster. If input is
	fed from STDIN via a pipe, the argument list is ignored and XML is
	read from STDIN.  This command is used for debugging the Rocks
	configuration graph.

### Examples

* `stack list host profile compute-0-0`

   Generates a Kickstart/Jumpstart profile for compute-0-0.

* `stack list host xml compute-0-0 | rocks list host profile`

   Does the same thing as above but reads XML from STDIN.



