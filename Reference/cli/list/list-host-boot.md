---
layout: page
title: list host boot
permalink: /list-host-boot
sidebarloc: /Reference/cli/list
---

## list host boot

### Usage

`stack list host boot [host ...]`

### Description

Lists the current bot action for hosts. For each host supplied on the
	command line, this command prints the hostname and boot action for
	that host. The boot action describes what the host will do the next
	time it is booted.

### Arguments

* `{host}`

   Zero, one or more host names. If no host names are supplied, info about
	all the known hosts is listed.


### Examples

* `stack list host boot compute-0-0`

   List the current boot action for compute-0-0.

* `stack list host boot`

   List the current boot action for all known hosts.



