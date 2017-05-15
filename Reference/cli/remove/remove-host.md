---
layout: page
title: remove host
permalink: /remove-host
sidebarloc: /Reference/cli/remove
---

## remove host

### Usage

`stack remove host {host ...}`

### Description

Remove a host from the database. This command will remove all
	related database rows for each specified host.

### Arguments

* `[host]`

   List of hosts to remove from the database.


### Examples

* `stack remove host backend-0-0`

   Remove the backend-0-0 from the database.



