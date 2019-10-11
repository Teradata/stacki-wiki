## sync host ansible

### Usage

`stack sync host ansible [attribute=string]`

### Description


	Sync a an ansible inventory to nodes.

	Syncs the same file to every node in
	/etc/ansible/hosts.

	

### Parameters
* `{attribute=string}`

   A shell syntax glob pattern to specify attributes to
	be sent to the report generator.

	Create group targets in the ini file.

### Examples

* `stack sync ansible backend-0-0`

   Sync ansible inventory file on backend-0-0

* `stack sync ansible a:backend`

   Sync ansible inventory file to all backends.

* `stack sync host ansible`

   Giving no hostname or regex will sync
	to all backend nodes by default.

* `stack sync ansible backend-0-[0-2]`

   Using regex, sync inventory file on backend-0-0
	backend-0-1, and backend-0-2.



