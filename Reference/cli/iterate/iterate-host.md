---
layout: page
title: iterate host
permalink: /iterate-host
sidebarloc: /Reference/cli/iterate
---

## iterate host

### Usage

`stack iterate host [host ...] {command=string}`

### Description

Iterate sequentially over a list of hosts.  This is used to run 
	a shell command on the frontend with with '%' wildcard expansion for
	every host specified.

### Arguments

* `{host}`

   Zero, one or more host names. If no host names are supplied iterate over
	all hosts except the frontend.


### Parameters
* `[command=string]`

   The shell command to be run for each host.  The '%' character is used as
	a wildcard to indicate the hostname.  Quoting of the '%' to expand to a 
	literal is accomplished with '%%'.

### Examples

* `stack iterate host backend command="scp file %:/tmp/"`

   Copies file to the /tmp directory of every backend node



