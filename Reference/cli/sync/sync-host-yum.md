---
layout: page
title: sync host yum
permalink: /sync-host-yum
sidebarloc: /Reference/cli/sync
---

## sync host yum

### Usage

`stack sync host yum`

### Description

Sync yum repo file to backend nodes.
	
	When a cart or pallet is added to the 
	frontend, to use the resulting repo but not
        reinstall machines, sync the new repo to the 
	backends for immediate use.

### Examples

* `stack sync host yum`

   Giving no hostname or regex will sync
        to all backend nodes by default.

* `stack sync host yum backend-0-0`

   Sync yum inventory file on backend-0-0

* `stack sync yum backend-0-[0-2]`

   Using regex, sync yum inventory file on backend-0-0
	backend-0-1, and backend-0-2.



