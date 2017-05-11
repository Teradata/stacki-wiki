## set appliance attr

### Usage

`stack set appliance attr [appliance ...] {attr=string} {value=string} [shadow=boolean]`

### Description

Sets an attribute to an appliance and sets the associated values

### Arguments

* `{appliance}`

   Name of appliance


### Parameters
* `[attr=string]`
* `[value=string]`
* `{shadow=boolean}`

   If set to true, then set the 'shadow' value (only readable by root
	and apache).

### Examples

* `stack set appliance attr backend attr=sge value=False`

   Sets the sge attribution to False for backend appliances



