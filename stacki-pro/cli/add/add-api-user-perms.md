---
layout: page
title: add api user perms
permalink: /add-api-user-perms
sidebarloc: /stacki-pro/cli/add
---

## add api user perms

### Usage

`stack add api user perms {user} [perm=string]`

### Description

Set permission for user

### Arguments

* `[user]`

   Username


### Parameters
* `{perm=string}`

   RegExp of Commands that the user is allowed to run.

### Examples

* `stack add user perm user1 perm='list.host.*'`

   Allows 'user1' to run all commands that conform to the
	regular expression "list.host.*".



