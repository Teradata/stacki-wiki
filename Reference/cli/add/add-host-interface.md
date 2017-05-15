---
layout: page
title: add host interface
permalink: /add-host-interface
sidebarloc: /Reference/cli/add
---

## add host interface

### Usage

`stack add host interface {host} [default=boolean] [interface=string] [ip=string] [mac=string] [module=string] [name=string] [network=string] [vlan=string]`

### Description

Adds an interface to a host and sets the associated values.

### Arguments

* `[host]`

   Host name of machine


### Parameters
* `{default=boolean}`
* `{interface=string}`
* `{ip=string}`
* `{mac=string}`
* `{module=string}`
* `{name=string}`
* `{network=string}`
* `{vlan=string}`

   The VLAN ID to assign the interface

### Examples

* `stack add host interface backend-0-0 interface=eth1 ip=192.168.1.2 network=private name=fast-0-0`

   Add interface "eth1" to host "backend-0-0" with the given
	IP address, network assignment, and name.



