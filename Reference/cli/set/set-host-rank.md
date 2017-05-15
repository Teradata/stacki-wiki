---
layout: page
title: set host rank
permalink: /set-host-rank
sidebarloc: /Reference/cli/set
---

## set host rank

### Usage

`stack set host rank {host ...} {rank=string}`

### Description

Set the rank number for a list of hosts.

### Arguments

* `[host]`

   One or more host names.


### Parameters
* `[rank=string]`

   The rank number to assign to each host.

### Examples

* `stack set host rank compute-0-2 rank=2`

   Set the rank number to 2 for compute-0-2.



