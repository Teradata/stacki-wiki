## remove os storage partition

### Usage

`stack remove os storage partition {os ...} [device=string] [mountpoint=string]`

### Description


	Remove storage partition configuration for an OS type.

	

### Arguments

* `[os]`

   OS type (e.g., 'redhat', 'sles').


### Parameters
* `{device=string}`
* `{mountpoint=string}`

   Mountpoint for the partition that needs to be removed from
	the database.

### Examples

* `stack remove os storage partition redhat`

   Removes the partition information for redhat os type



