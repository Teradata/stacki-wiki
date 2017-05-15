---
layout: page
title: set host address
permalink: /set-host-address
sidebarloc: /Reference/cli/set
---

## set host address

### Usage

`stack set host address {host} [dns=string] [domain=string] [gateway=string] [ip=string] [netmask=string] [shortname=string]`

### Description

Change the networking info for a frontend.

### Arguments

* `[host]`

   The name of the frontend.


### Parameters
* `{dns=string}`
* `{domain=string}`
* `{gateway=string}`
* `{ip=string}`
* `{netmask=string}`
* `{shortname=string}`

   The new short name. This is the first part of the FQDN. For
	example, if the FQDN is a.yoda.com, then the short name is 'a'.

### Examples

* `stack set host address localhost ip=1.2.3.4`

   Change the frontend's IP address to 1.2.3.4.



