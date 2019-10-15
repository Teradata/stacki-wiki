## sync host firmware

### Usage

`stack sync host firmware [host ...] [force=bool]`

### Description


	Syncs firmware to hosts that are compatible with the firmware

	

### Arguments

* `{host}`

   Zero or more hosts to sync. If none are specified, all hosts will have their firmware synced.


### Parameters
* `{force=bool}`

   Force the firmware update process to run for hosts that are already in sync.

### Examples

* `stack sync host firmware switch-18-11`

   If a compatible firmware version is tracked by stacki, the firmware will be synced to switch-18-11.

* `stack sync host firmware`

   For each host, if a compatible firmware version is tracked by stacki, it will be synced to the host.



