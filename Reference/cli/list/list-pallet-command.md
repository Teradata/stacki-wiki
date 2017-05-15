---
layout: page
title: list pallet command
permalink: /list-pallet-command
sidebarloc: /Reference/cli/list
---

## list pallet command

### Usage

`stack list pallet command [pallet ...]`

### Description

List the commands provided by a pallet.

### Arguments

* `{pallet}`

   List of pallets. This should be the pallet base names (e.g., base, hpc,
	kernel). If no pallets are listed, then commands for all the pallets
	are listed.


### Examples

* `stack list pallet command stacki`

   Returns the the list of commands installed by the stacki pallet.



