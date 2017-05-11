## add host message

### Usage

`stack add host message {host ...} {message=string} [channel=string]`

### Description

Adds a message to one or most host Message Queues

### Arguments

* `[host]`

   Zero, one or more host names. If no host names are supplied, the
        message is sent to all hosts.


### Parameters
* `[message=string]`
* `{channel=string}`

   Name of the channel

### Examples

* `stack add host message backend-0-0 "hello world" channel=debug`

   Sends "hello world" over the debug channel using the Message
        Queue on backend-0-0.



