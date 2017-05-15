---
layout: page
title: set host boot order
permalink: /set-host-boot-order
---

## set host boot order

### Usage

`stack set host boot order {host ...} [action=string] [options=string]`

### Description

Set boot order for a host without having to go through the BIOS
	settings manually.

### Examples

* `stack set host boot order compute-0-0 action=pxe`

   Set compute-0-0 to pxe boot first.

* `stack set host boot order compute-0-0 action=disk options=persistent`

   Set compute-0-0 to boot from hard disk persistently.



