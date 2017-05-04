## add api blacklist command

### Usage

`stack add api blacklist command [command=string]`

### Description

Add a command to the webservice
	blacklist. This disallows the
	command from running, by anyone,
	including the admin. This has the
	granularity of a command. This means
	that you can only blacklist individual
	commands, and not entire verbs of
	commands.

### Parameters
* `{command=string}`

   Command to blacklist

### Examples

* `stack add blacklist command command='list host message'`

   Add "list host message" command to the blacklist.



