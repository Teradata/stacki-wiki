## create new pallet

### Usage

`stack create new pallet {name=string} [os=string] [version=string]`

### Description

	
	Create a skeleton directory structure for a pallet
	source.

	This command is to be used mainly by pallet developers.

	This command creates a directory structure from
	templates that can be then be populated with required
	software and configuration.

	Refer to Pallet Developer Guide for more information.

	

### Parameters
* `[name=string]`
* `{os=string}`
* `{version=string}`

   Version of the pallet. Typically the version of the
	application to be palletized.

### Examples

* `stack create new pallet name=valgrind version=3.10.1`

   Creates a new pallet for Valgrind version 3.10.1.



