## set attr doc

### Usage

`stack set attr doc {attr=string} {doc=string}`

### Description


	Changes a string containing documention for an attribute

	

### Parameters
* `[attr=string]`
* `[doc=string]`

   Documentation of the attribute

### Examples

* `stack set attr doc attr="ssh.use_dns" doc="hosts with ssh.use_dns == True will enable DNS lookups in sshd config."`

   Sets the documentation string for 'ssh.use_dns'


### Related
[list attr doc](list-attr-doc)

[set attr](set-attr)


