---
layout: page
title: set host interface channel
permalink: /set-host-interface-channel
sidebarloc: /Reference/cli/set
---

## set host interface channel

### Usage

`stack set host interface channel [host ...] {channel=string} [interface=string] [mac=string]`

### Description

Sets the channel for a named interface.

### Arguments

* `{host}`

   One or more hosts.


### Parameters
* `[channel=string]`
* `{interface=string}`
* `{mac=string}`

   MAC address of the interface.

### Examples

* `stack set host interface channel backend-0-0 interface=eth1 channel="bond0"`

   Sets the channel for eth1 to be "bond0" (i.e., it associates eth1 with
	the bonded interface named "bond0").

* `stack set host interface channel backend-0-0 interface=eth1 channel=NULL`

   Clear the channel entry.



