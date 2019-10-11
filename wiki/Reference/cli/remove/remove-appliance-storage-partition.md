## remove appliance storage partition

### Usage

`stack remove appliance storage partition {appliance ...} [device=string] [mountpoint=string]`

### Description


	Remove storage partition information for an appliance.

	

### Arguments

* `[appliance]`

   Appliance type (e.g., "backend").


### Parameters
* `{device=string}`
* `{mountpoint=string}`

   Mountpoint for the partition that needs to be removed from
	the database.

### Examples

* `stack remove appliance storage partition backend`

   Removes the partition information for backend appliances



