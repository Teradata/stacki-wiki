## sync host repo

### Usage

`stack sync host repo`

### Description


	Sync a repository configuration file to backend nodes.

	When a cart or pallet is added to the
	frontend, to use the resulting repo but not
	reinstall machines, sync the new repo to the
	backends for immediate use.

	

### Examples

* `stack sync host repo`

   Giving no hostname or regex will sync
	to all backend nodes by default.

* `stack sync host repo backend-0-0`

   Sync the repository inventory file on backend-0-0

* `stack sync repo backend-0-[0-2]`

   Using regex, sync repository inventory file on backend-0-0
	backend-0-1, and backend-0-2.



