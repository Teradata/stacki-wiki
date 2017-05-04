## dump host interface

### Usage

`stack dump host interface [host ...]`

### Description


Dump the host interface information as stack commands.



### Arguments

* `{host}`

   Zero, one or more host names. If no host names are supplied, 
	information for all hosts will be listed.


### Examples

* `stack dump host interface backend-0-0`

   Dump the interfaces for backend-0-0.

* `stack dump host interface backend-0-0 backend-0-1`

   Dump the interfaces for backend-0-0 and backend-0-1.

* `stack dump host interface`

   Dump all interfaces.



