---
layout: page
title: set network zone
permalink: /set-network-zone
sidebarloc: /Reference/cli/set
---

## set network zone

### Usage

`stack set network zone {network} {zone=string}`

### Description

Sets the DNS zone (domain name) for a network.

### Arguments

* `[network]`

   The name of the network.


### Parameters
* `[zone=string]`

   Zone that the named network should have.

### Examples

* `stack set network zone ipmi zone=ipmi`

   Sets the "ipmi" network zone to "ipmi".



