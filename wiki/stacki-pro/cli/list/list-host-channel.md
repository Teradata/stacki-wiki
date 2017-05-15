## list host channel

### Usage

`stack list host channel [host ...]`

### Description

List the Message Queue channel that are currently being
        transported from the given host(s) to the frontend.

### Arguments

* `{host}`

   Zero, one or more host names. If no host names are supplied, info about
	all the known hosts is listed.


### Examples

* `stack list host channel backend-0-0`

   List channel for backend-0-0.

* `stack list host channel`

   List channels for all known hosts.



