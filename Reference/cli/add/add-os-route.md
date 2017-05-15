---
layout: page
title: add os route
permalink: /add-os-route
sidebarloc: /Reference/cli/add
---

## add os route

### Usage

`stack add os route {os} [address=string] [gateway=string] [netmask=string]`

### Description

Add a route for an OS type

### Arguments

* `[os]`

   The OS type (e.g., 'linux', 'sunos', etc.). This argument is required.


### Parameters
* `{address=string}`
* `{gateway=string}`
* `{netmask=string}`

   Specifies the netmask for a network route.  For a host route
	this is not required and assumed to be 255.255.255.255


