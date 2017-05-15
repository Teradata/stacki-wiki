---
layout: page
title: update host firmware
permalink: /update-host-firmware
---

## update host firmware

### Usage

`stack update host firmware {host ...} {name=string}`

### Description

Update firmware on machine remotely.
	Currently works only for Dell, HP Servers.

### Examples

* `stack update host firmware compute-0-0 name=ESM.bin`

   Update iDRAC firmware on compute-0-0 to ESM.bin.



