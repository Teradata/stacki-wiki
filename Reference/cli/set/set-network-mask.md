---
layout: page
title: set network mask
permalink: /set-network-mask
sidebarloc: /Reference/cli/set
---

## set network mask

### Usage

`stack set network mask [network ...] {mask=string}`

### Description

Sets the network mask for one or more networks.

### Arguments

* `{network}`

   The names of zero of more networks. If no network is specified
        the mask is set for all existing networks.


### Parameters
* `[mask=string]`

   Mask that the named network should have.

### Examples

* `stack set network mask ipmi mask=255.255.255.0`

   Sets the "ipmi" network mask to 255.255.255.0.



