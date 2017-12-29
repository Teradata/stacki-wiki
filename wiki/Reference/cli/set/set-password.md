## set password

### Usage

`stack set password`

### Description


	Change the root password for relevant cluster services.  In particular, this changes the Unix
	'root' account password for the Frontend.  Note that this password is also the default
	password for all backend nodes, but backends will not have their passwords set to the new
	password until after a reinstall.

	

### Examples

* `stack set password`

   Set the password for Stacki.  You will be prompted for the current password and the new password.



