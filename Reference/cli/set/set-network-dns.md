---
layout: page
title: set network dns
permalink: /set-network-dns
sidebarloc: /Reference/cli/set
---

## set network dns

### Usage

`stack set network dns [network ...] {dns=boolean}`

### Description

Enables or Disables DNS for one of more networks.
        
        If DNS is enabled for a network then all known hosts on that network
        will have their hostnames and IP addresses in a DNS server running
        on the Frontend.  This will serve both forward and reverse lookups.

### Arguments

* `{network}`

   The names of zero of more networks. If no network is specified
        the DNS is set for all existing networks.


### Parameters
* `[dns=boolean]`

   Set to True to enable DNS for the given networks.

### Examples

* `stack set network dns private dns=false`

   Disables DNS on the "private" network.



