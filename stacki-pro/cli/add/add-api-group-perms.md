---
layout: page
title: add api group perms
permalink: /add-api-group-perms
sidebarloc: /stacki-pro/cli/add
---

## add api group perms

### Usage

`stack add api group perms {group} [perm=string]`

### Description

Add permissions to a group.

### Arguments

* `[group]`

   Group name to add permissions to


### Parameters
* `{perm=string}`

   Regular expression of permission

### Examples

* `stack add group perms default perm="report.*"`

   All users in the 'default' group to run 'report' commands



