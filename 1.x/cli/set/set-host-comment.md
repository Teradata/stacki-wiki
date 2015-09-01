## set host comment

### Usage

`stack set host comment {host}... {comment} [comment=string]`

### Description

Set the comment field for a list of hosts.

### Arguments

* `{host}`

   One or more host names.

* `{comment}`

   The string to assign to the comment field for each host.


### Parameters
* `[comment=string]`

   Can be used in place of the comment argument.

### Examples

* `stack set host comment compute-0-0 "Fast Node"`

   Sets the comment field to "Fast Node" for compute-0-0.

* `stack set host comment compute-0-0 compute-0-1 "Slow Node"`

   Sets the comment field to "Slow Node" for compute-0-0 and compute-0-1.

* `stack set host comment compute-0-0 compute-0-1 comment="Slow Node"`

   Same as above.



