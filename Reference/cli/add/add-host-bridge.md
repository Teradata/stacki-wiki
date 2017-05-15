---
layout: page
title: add host bridge
permalink: /add-host-bridge
sidebarloc: /Reference/cli/add
---

## add host bridge

### Usage

`stack add host bridge {host} [interface=string] [name=string] [network=string]`

### Description

Add a bridge interface to a given host.

### Arguments

* `[host]`

   Hostname


### Parameters
* `{interface=string}`
* `{name=string}`
* `{network=string}`

   Name of the network on which the physical
	device to be bridged exists.

### Examples

* `stack add host bridge backend-0-0 name=cloudbr0  network=private interface=eth0`

   This command will create a bridge called "cloudbr0", and
	attach it to physical interface eth0 and place it on the
	private network.



