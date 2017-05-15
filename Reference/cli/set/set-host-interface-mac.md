---
layout: page
title: set host interface mac
permalink: /set-host-interface-mac
sidebarloc: /Reference/cli/set
---

## set host interface mac

### Usage

`stack set host interface mac {host ...} {interface=string} {mac=string}`

### Description

Sets the mac address for named interface on host.

### Arguments

* `[host]`

   Host name.


### Parameters
* `[interface=string]`
* `[mac=string]`

   The mac address of the interface. Usually of the form dd:dd:dd:dd:dd:dd
	where d is a hex digit. This format is not enforced. Use mac=NULL to
	clear the mac address.

### Examples

* `stack set host interface mac backend-0-0 interface=eth1 mac=00:0e:0c:a7:5d:ff`

   Sets the MAC Address for the eth1 device on host backend-0-0.



