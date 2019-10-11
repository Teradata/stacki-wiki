## add appliance

### Usage

`stack add appliance {appliance} [node=string] [public=bool]`

### Description


	Add an appliance specification to the database.

	

### Arguments

* `[appliance]`

   The appliance name (e.g., 'backend', 'frontend', 'nas').


### Parameters
* `{node=string}`
* `{public=bool}`

   True means this appliance will be displayed by 'insert-ethers' in
	the Appliance menu. The default is 'yes'.

### Examples

* `stack add appliance nas node=nas public=yes`

   



