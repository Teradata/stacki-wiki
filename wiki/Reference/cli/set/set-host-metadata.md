## set host metadata

### Usage

`stack set host metadata {host ...} {metadata=string}`

### Description


	Set the metadata for a list of hosts. The metadata is
	reserved for the user and is not used internally by Stacki. The
	intention is to provide a mechanism similar to the AWS
	meta-data to allow arbitrary data to be attached to a host.

	It is recommended that the metadata (if used) should be a JSON
	document but there are no assumptions from Stacki on the
	structure of the data.

	Metadata should be accessed using the "metadata" read-only attribute.

	

### Arguments

* `[host]`

   One or more host names.


### Parameters
* `[metadata=string]`

   The metadata document


