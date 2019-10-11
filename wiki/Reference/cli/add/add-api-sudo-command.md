## add api sudo command

### Usage

`stack add api sudo command [command=string]`

### Description


	Add a command, or a set of commands, to the webservice
	sudo list. This allows the webservice to sudo up to
	root to run the commands. It can take a regular expression
	or an individual command.
	

### Parameters
* `{command=string}`

   Command to add to sudo list. Format of this command is
	{ verb } [ object ... ] [ * ]

### Examples

* `stack add sudo command command='sync config'`

   Add "sync config" command to the sudolist.

* `stack add sudo command command='load *'`

   Add "sync config" command to the sudolist.



