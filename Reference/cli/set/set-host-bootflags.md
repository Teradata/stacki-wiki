---
layout: page
title: set host bootflags
permalink: /set-host-bootflags
sidebarloc: /Reference/cli/set
---

## set host bootflags

### Usage

`stack set host bootflags {host ...} [flags=string]`

### Description

Set the boot flags for a host. The boot flags will applied to the
	configuration file that a host uses to boot the running kernel. For
	example, if a node uses GRUB as its boot loader, the boot flags will 
	part of the 'append' line.

### Arguments

* `[host]`

   Zero, one or more host names. If no host names are supplied, then the
	global bootflag will be set.


### Parameters
* `{flags=string}`

   The boot flags to set for the host.

### Examples

* `stack set host bootflags compute-0-0 flags="mem=1024M"`

   Apply the kernel boot flags "mem=1024M" to compute-0-0.



