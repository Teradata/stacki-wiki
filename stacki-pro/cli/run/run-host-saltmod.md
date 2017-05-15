---
layout: page
title: run host saltmod
permalink: /run-host-saltmod
sidebarloc: /stacki-pro/cli/run
---

## run host saltmod

### Usage

`stack run host saltmod {command} {args}`

### Description

Runs a salt module on all compute nodes

### Arguments

* `[command]`
* `[args]`

   The arguments to the salt command.


### Examples

* `stack run saltmod command="cmd.run"   args="hostname"`

   Runs the cmd.run module on all hosts, and fetch the
	hostname from all nodes.



