---
layout: page
title: add appliance route
permalink: /add-appliance-route
sidebarloc: /Reference/cli/add
---

## add appliance route

### Usage

`stack add appliance route {appliance} {address=string} {gateway=string} [netmask=string]`

### Description

Add a route for an appliance type in the cluster

### Arguments

* `[appliance]`

   The appliance type (e.g., 'backend').


### Parameters
* `[address=string]`
* `[gateway=string]`
* `{netmask=string}`

   Specifies the netmask for a network route.  For a host route
	this is not required and assumed to be 255.255.255.255


