---
layout: page
title: set host comment
permalink: /set-host-comment
sidebarloc: /Reference/cli/set
---

## set host comment

### Usage

`stack set host comment {host ...} {comment=string}`

### Description

Set the comment field for a list of hosts.

### Arguments

* `[host]`

   One or more host names.


### Parameters
* `[comment=string]`

   The string to assign to the comment field for each host.

### Examples

* `stack set host comment backend-0-0 comment="Fast Node"`

   Sets the comment field to "Fast Node" for backend-0-0.



