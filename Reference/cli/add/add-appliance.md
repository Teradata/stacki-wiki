---
layout: page
title: add appliance
permalink: /add-appliance
sidebarloc: /Reference/cli/add
---

## add appliance

### Usage

`stack add appliance {appliance} [longname=string] [node=string] [public=bool]`

### Description

Add an appliance specification to the database.

### Arguments

* `[appliance]`

   The appliance name (e.g., 'backend', 'frontend', 'nas').


### Parameters
* `{longname=string}`
* `{node=string}`
* `{public=bool}`

   True means this appliance will be displayed by 'insert-ethers' in
	the Appliance menu. The default is 'yes'.

### Examples

* `stack add appliance nas longname="NAS Appliance" node=nas public=yes`

   



