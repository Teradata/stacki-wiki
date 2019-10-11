## sync host boot

### Usage

`stack sync host boot`

### Description


	You'll rarely have to use this command.

	It usually gets run as part of the
	"stack set host boot" command.

	Recreates the /tftpboot/pxelinux/pxelinux.cfg/
	pxe boot files for backend nodes.

	If the "stack set host boot <nodes> action=install"
	these will install from the network.

	If the "stack set host boot <nodes> action=os"
	backends install from local disk.

	

### Examples

* `stack sync host bootfile`

   Rebuild all tftpboot files for backend nodes.



