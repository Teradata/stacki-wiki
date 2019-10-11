## report ansible

### Usage

`stack report ansible [attribute=string]`

### Description


	Report an Ansible Inventory Script.

	File defaults to /etc/ansible/hosts in "ini" format.

	Does not do vars.

	

### Parameters
* `{attribute=string}`

   A shell syntax glob pattern to specify attributes to
	be listed. The attribute is the stanza header.

### Examples

* `stack report ansible`

   Create an inventory file of the managed hosts, rack, and
	appliances currently available.

* `stack report ansible attribute=kube_master,kube_worker`

   Create an inventory file of the managed hosts, rack, and
	appliances and nodes that have kube_master or kube_minion set. The 
	attribute name is the group target.

	..snip..

	[kube_master]
	backend-0-0

	[kube_worker]
	backend-0-1
	backend-0-2
	backend-0-3
	backend-0-4
	..snip..



