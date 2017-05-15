---
layout: page
title: set network mtu
permalink: /set-network-mtu
sidebarloc: /Reference/cli/set
---

## set network mtu

### Usage

`stack set network mtu [network ...] {mtu=string}`

### Description

Sets the MTU for one or more networks.

### Arguments

* `{network}`

   The names of zero of more networks. If no network is specified
        the MTU is set for all existing networks.


### Parameters
* `[mtu=string]`

   MTU value the networks should have.

### Examples

* `stack set network mtu fat mtu=9000`

   Sets the "fat" network to jumbo frames.



