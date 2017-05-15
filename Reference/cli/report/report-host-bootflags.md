---
layout: page
title: report host bootflags
permalink: /report-host-bootflags
sidebarloc: /Reference/cli/report
---

## report host bootflags

### Usage

`stack report host bootflags [host ...]`

### Description

Output the kernel boot flags for a specific host

### Arguments

* `{host}`

   Zero, one or more host names. If no host names are supplied, info about
	all the known hosts is listed.


### Examples

* `stack report host bootflags compute-0-0`

   Output the kernel boot flags for compute-0-0.



