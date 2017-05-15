---
layout: page
title: set host vmedia
permalink: /set-host-vmedia
---

## set host vmedia

### Usage

`stack set host vmedia {host ...} {path=string}`

### Description

Mount a bootable ISO on a remote machine.
	Currently works for Dell, HP Servers.

### Examples

* `stack set host vmedia compute-0-0 path=/etc/redhat.iso`

   Mount redhat.iso on compute-0-0 (Dell node) remotely.

* `stack set host vmedia compute-0-0 path=http://10.1.2.11/redhat.iso`

   Mount redhat.iso on compute-0-0 (HP node) remotely.



