# Writing a REST API Client

The Stacki REST API provides the entire
Stack Command-Line interface through a
web service - with one exception - which
we will explain later.

The Stacki REST API provides 1 endpoint.
** /stack **

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
   * Set header 'csrftoken' to the CSRFToken from the CSRF Cookie
   * Set header 'X-CSRFToken' to the CSRFToken from the CSRF Cookie
   * Set Content-Type to 'application/x-www-form-urlencoded'
   * Set Data to USERNAME=<username>&PASSWORD=<password>

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


### REST API ADMINISTRATION

The REST API endpoint is available on the frontend.
To access the REST API, a username, and API key is
necessary. To create the username/key pair, command-line
tools are made available.

The stacki commands that are available are listed in
(cli/restapi-cmd.md)
