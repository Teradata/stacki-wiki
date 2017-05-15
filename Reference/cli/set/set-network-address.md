---
layout: page
title: set network address
permalink: /set-network-address
sidebarloc: /Reference/cli/set
---

## set network address

### Usage

`stack set network address {network} {address=string}`

### Description

Sets the network address of a network.

### Arguments

* `[network]`

   The name of the network.


### Parameters
* `[address=string]`

   Address that the named network should have.

### Examples

* `stack set network address ipmi address=192.168.10.0`

   Sets the "ipmi" network address to 192.168.10.0.



