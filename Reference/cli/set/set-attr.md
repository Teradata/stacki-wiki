---
layout: page
title: set attr
permalink: /set-attr
sidebarloc: /Reference/cli/set
---

## set attr

### Usage

`stack set attr {attr=string} {value=string} [shadow=boolean]`

### Description

Sets a global attribute for all nodes

### Parameters
* `[attr=string]`
* `[value=string]`
* `{shadow=boolean}`

   If set to true, then set the 'shadow' value (only readable by root
	and apache).

### Examples

* `stack set attr attr=sge value=False`

   Sets the sge attribution to False


### Related
[list attr](list-attr)

[remove attr](remove-attr)


