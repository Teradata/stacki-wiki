## run host

### Usage

`stack run host [host ...] {command=string} [collate=string] [delay=string] [managed=boolean] [threads=string] [timeout=string] [x11=boolean]`

### Description

Run a command for each specified host.

### Examples

* `stack run host backend-0-0 command="hostname"`

   Run the command 'hostname' on backend-0-0.

* `stack run host backend command="ls /tmp"`

   Run the command 'ls /tmp/' on all backend nodes.



