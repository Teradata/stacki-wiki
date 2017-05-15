---
layout: page
title: remove host group
permalink: /remove-host-group
sidebarloc: /Reference/cli/remove
---

## remove host group

### Usage

`stack remove host group {host ...} {group=string}`

### Description

Removes a group from or more hosts.

### Arguments

* `[host]`

   One or more host names.


### Parameters
* `[group=string]`

   Group for the host.

### Examples

* `stack remove host group backend-0-0 group=test`

   Removes host backend-0-0 from the test group.



