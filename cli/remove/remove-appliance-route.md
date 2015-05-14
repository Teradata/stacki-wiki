## remove appliance route

### Usage

`stack remove appliance route {appliance} {address} [address=string]`

### Description

Remove a static route for an appliance type.

### Arguments

* `{appliance}`

   Appliance name. This argument is required.

* `{address}`

   The address of the static route to remove. This argument is required.


### Parameters
* `[address=string]`

   Can be used in place of the 'address' argument.

### Examples

* `stack remove appliance route compute 1.2.3.4`

   Remove the static route for the 'compute' appliance that has the
	network address '1.2.3.4'.



