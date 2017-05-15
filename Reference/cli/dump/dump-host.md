---
layout: page
title: dump host
permalink: /dump-host
sidebarloc: /Reference/cli/dump
---

## dump host

### Usage

`stack dump host [host ...]`

### Description

Dump the host information as rocks commands.

### Arguments

* `{host}`

   Zero, one or more host names. If no host names are supplied, 
	information for all hosts will be listed.


### Examples

* `stack dump host compute-0-0`

   Dump host compute-0-0 information.

* `stack dump host compute-0-0 compute-0-1`

   Dump host compute-0-0 and compute-0-1 information.

* `stack dump host`

   Dump all hosts.



