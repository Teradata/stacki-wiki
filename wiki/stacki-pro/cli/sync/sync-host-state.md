## sync host state

### Usage

`stack sync host state [host ...] [function=string] [name=string] [sls=string] [test=bool]`

### Description

Run the highstate for each specified host.

### Arguments

* `{host}`

   Zero, one or more host names. If no host names are supplied, the command
	is run on all 'managed' hosts.


### Parameters
* `{function=string}`
* `{name=string}`
* `{sls=string}`
* `{test=bool}`

   If set to TRUE perform a dryrun and only list out the current state of
        the specified host(s).  The default is FALSE.

### Examples

* `stack sync host state backend-0-0`

   Sets backend-0-0 to the salt highstate.

* `stack sync host state backend-0-0 test=true`

   Dry run of highstate for backend-0-0.  This is usefull to inspect the
        currect state (and what is not in sync), and to see the full list of
        names and functions in the highstate.

* `stack sync host state backend-0-0 name=user-root function=user.present`

   Run the named state user-root function user.present on backend-0-0.  If the
        Attribute sync.root is defined as true this will set the root account password
        to the crypted valued stored in the attribute Kickstart_PrivateRootPassword.



