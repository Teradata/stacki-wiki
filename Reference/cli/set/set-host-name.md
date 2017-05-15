---
layout: page
title: set host name
permalink: /set-host-name
sidebarloc: /Reference/cli/set
---

## set host name

### Usage

`stack set host name {host} {name=string}`

### Description

Rename a host.

### Arguments

* `[host]`

   The current name of the host.


### Parameters
* `[name=string]`

   The new name for the host.

### Examples

* `stack set host name backend-0-0 name=new-backend-0-0`

   Changes the name of backend-0-0 to new-backend-0-0.



