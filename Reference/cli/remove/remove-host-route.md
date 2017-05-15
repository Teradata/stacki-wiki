---
layout: page
title: remove host route
permalink: /remove-host-route
sidebarloc: /Reference/cli/remove
---

## remove host route

### Usage

`stack remove host route {host ...} {address=string}`

### Description

Remove a static route for a host.

### Arguments

* `[host]`

   Name of a host machine.


### Parameters
* `[address=string]`

   The address of the static route to remove. This argument is required.

### Examples

* `stack remove host route backend-0-0 address=1.2.3.4`

   Remove the static route for the host 'backend-0-0' that has the
	network address '1.2.3.4'.



