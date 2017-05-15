---
layout: page
title: stacki rest
permalink: /stacki-rest
sidebarloc: /stacki-pro
---

# Stacki ReST API

## Installing Stacki REST API

The Stacki REST API is distributed as a web service
running as a Django Application. To install the API
you will need to install the stacki-pro pallet.

Refer to the [Stacki Pro Installation Guide](stacki-pro-install) for information about how to install the stacki-pro pallet.

After the installation, the Stacki REST API is available.
By default, Stacki includes a webservice client, and creates
admin credentials to help validate the API.

## Testing the ReST API

Stacki-pro comes with a build in webservice client.
The webservice client is called **wsclient**. The webservice
admin credentials are placed in `/root/stacki-ws.cred`

To test the web service client, run
```shell
# wsclient list host
```

This should print a JSON string that contains output
from the command.
```json
[{"box": "default", "status": "up", "installaction":
"install", "appliance": "frontend", "runaction": "os",
"cpus": 1, "rank": "0", "environment": "", "host":
"node234-002", "rack": "0"},
{"box": "default", "status": "up", "installaction":
"install", "appliance": "backend", "runaction": "os",
"cpus": 2, "rank": "25", "environment": "", "host":
"node211", "rack": "0"},
{"box": "default", "status": "up", "installaction":
"install", "appliance": "backend", "runaction": "os",
"cpus": 2, "rank": "26", "environment": "", "host":
"node210", "rack": "0"},
{"box": "default", "status": "up", "installaction":
"install", "appliance": "backend", "runaction": "os",
"cpus": 4, "rank": "28", "environment": "", "host":
"node209", "rack": "0"},
{"box": "default", "status": "up", "installaction":
"install", "appliance": "backend", "runaction": "os",
"cpus": 4, "rank": "30", "environment": "", "host":
"node207", "rack": "0"},
{"box": "default", "status": "up", "installaction":
"install", "appliance": "backend", "runaction": "os",
"cpus": 4, "rank": "6", "environment": "", "host":
"node217", "rack": "0"}]
```

## Writing a REST API Client

The Stacki REST API provides the entire
Stack Command-Line interface through a
web service - with one exception - which
we will explain later.

The Stacki REST API provides 1 endpoint - **/stack**

### PROTOCOL

1. Get CSRF Token

   HTTP GET **http://\<hostname\>/stack**

   Running a HTTP GET Command against the /stack
   endpoint, returns a CSRF cookie. This CSRF cookie
   must be used to log in to the service.

1. Login to the Service
   
   HTTP POST **http://\<hostname\>/stack/login**

   By default, an admin user is created, and allowed
   to log in and call API endpoints.

   Send a HTTP POST Command to **/stack/login**.

   The **username** and **password** must be sent to the URL
   as follows
   * Set header `csrftoken` to the CSRFToken from the CSRF Cookie
   * Set header `X-CSRFToken` to the CSRFToken from the CSRF Cookie
   * Set Content-Type to `application/x-www-form-urlencoded`
   * Set Data to `USERNAME=<username>&PASSWORD=<password>`

   Upon successful login, the response headers will include the following.
   * **CSRFToken cookie** - This is different from the csrftoken cookie obtained
     in the previous GET call
   * **Session Cookie** - This will keep the API session active.
   

1. Run API Call

   HTTP POST http://\<hostname\>/stack

   The API call syntax is very similar to the `stack` command line tool
   syntax.
   * Set header `csrftoken` to CSRFtoken value obtained after successful login
   * Set header `X-CSRFToken` to CSRFToken value obtained after successful login
   * Set header `sessionid` to sessionid value obtained after successful login
   * Set Content-Type to `application/json`
   * Set Data to JSON String in the following format:
     ```
{
  "cmd": "list host"
}
     ```
   * This will call the **list host** command, on the API server.
   
   If the command is executed successfully, it will return
   a JSON string, that contains the output of the command execution.
   ```json
[
    {
        "appliance": "backend", 
        "box": "default", 
        "cpus": 2, 
        "environment": "", 
        "host": "node210", 
        "installaction": "install", 
        "rack": "0", 
        "rank": "26", 
        "runaction": "os", 
        "status": "up"
    }
]
   ```

### API RESTRICTIONS

The Stacki REST API does not allow **"run host"** commands,
since this exposes arbitrary shell execution.

The Stacki REST API allows only an administrator to run
**sync** commands

### REST API ADMINISTRATION

The REST API endpoint is available on the frontend.
To access the REST API, a username, and API key is
necessary. To create the username/key pair, command-line
tools are made available.

The complete list of stacki commands that manipulate access
to the ReST API are available here - [ReST API Command Line](restapi-cmd)

1. To add a user to the API, run

   ```# stack add user greg group=default admin=False```

   This adds a user with username **greg** belonging to the
   **default** group. The **admin** flag for this user is
   set to false. This means that the user **greg** will be
   able to query the stacki api, but will not be able to
   change the state of the system.

   The output of this command will be a json string, that
   contains the username, API key, and hostname of the API
   server.
   ```json
{
  "username": "greg", 
  "hostname": "node234-002.stacki.com", 
  "key": "NFdl45R_JoQEQUs8RMtpnHmwAmI8UQHQGRuBL0OI2mQ"
}
   ```
   To allow user **greg** to access the API, use the
   username/key pair listed.
   
   To run the `wsclient` application with this key pair,
   copy the entire JSON output into `stacki-ws.cred` file in
   the users home directory.

1. To add a group, run

   ```# stack add group staff```

   This adds a group called **staff** to the system.

1. To set permissions on a group, run

   ```# stack add group perms staff perms="list.*"```

   This allows users in group **staff** to run any "list"
   commands.

1. To set permissions for a user, run

   ```# stack add user perms greg perms="report.*"```

   This allows user **greg** to run any "report" command in
   addition to all the commands allowed by the "default"
   group.

1. To set admin privileges for a user, run

   ```# stack set user admin greg admin=True```

   This will allow user **greg** to run any command on the
   system.
