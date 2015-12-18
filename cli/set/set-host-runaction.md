## set host runaction

### Usage

`stack set host runaction {host ...} {action=string}`

### Description

Set the run action for a list of hosts.

### Examples

* `stack set host runaction backend-0-0 action=os`

   Sets the run action to "os" for backend-0-0.

* `stack set host runaction backend-0-0 backend-0-1 action=memtest`

   Sets the run action to "memtest" for backend-0-0 and backend-0-1.



