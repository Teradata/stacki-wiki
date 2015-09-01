## remove environment attr

### Usage

`stack remove environment attr {environment} {attr} [attr=string]`

### Description

Remove an attribute for an Environment.

### Arguments

* `{environment}`

   One or more Environment specifications (e.g., 'test').

* `{attr}`

   The attribute name that should be removed.


### Parameters
* `[attr=string]`

   Can be used in place of the attr argument.

### Examples

* `stack remove environment attr test sge`

   Removes the attribute sge for text environment machines.

* `stack remove environment attr test attr=sge`

   Same as above.



