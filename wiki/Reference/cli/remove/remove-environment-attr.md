## remove environment attr

### Usage

`stack remove environment attr [environment ...] {attr=string}`

### Description


	Remove an attribute for an Environment.

	

### Arguments

* `{environment}`

   One or more Environment specifications (e.g., 'test').


### Parameters
* `[attr=string]`

   The attribute name that should be removed.

### Examples

* `stack remove environment attr test attr=sge`

   Removes the attribute sge for text environment machines.



