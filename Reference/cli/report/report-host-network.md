---
layout: page
title: report host network
permalink: /report-host-network
sidebarloc: /Reference/cli/report
---

## report host network

### Usage

`stack report host network {host ...}`

### Description

Outputs the network configuration file for a host (on RHEL-based
	machines, this is the contents of the file /etc/sysconfig/network).

### Arguments

* `[host]`

   Hostname.


### Examples

* `stack report host network compute-0-0`

   Output the network configuration for compute-0-0.



