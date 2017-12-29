## add api user

### Usage

`stack add api user {username} [admin=bool] [group=string]`

### Description


	Create a user to the REST API.
	This command will print out a JSON
	string that contains the Username, API Key,
	and Hostname of the API server.
	

### Arguments

* `[username]`

   Username of the user being created


### Parameters
* `{admin=bool}`
* `{group=string}`

   Comma-separated list of groups that the
	user should belong to. Default is "default".

### Examples

* `stack add user greg admin=True`

   Adds a user called 'greg' with admin privileges
	to the API



