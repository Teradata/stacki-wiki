## remove os route

### Usage

`stack remove os route {os ...} {address=string}`

### Description

Remove a static route for an OS type.

### Arguments

* `[os]`

   The OS type (e.g., 'linux', 'sunos', etc.).


### Parameters
* `[address=string]`

   The address of the static route to remove.

### Examples

* `stack remove os route linux address=1.2.3.4`

   Remove the static route for the OS 'linux' that has the
	network address '1.2.3.4'.



