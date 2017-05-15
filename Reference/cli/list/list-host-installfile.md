---
layout: page
title: list host installfile
permalink: /list-host-installfile
sidebarloc: /Reference/cli/list
---

## list host installfile

### Usage

`stack list host installfile [chapter=string]`

### Description

Process an XML-based installation file and output an OS-specific
	installation file (e.g., a kickstart or jumpstart file).

### Parameters
* `{chapter=string}`

   Which chapter within the XML installation file to process (e.g.,
	"kickstart", "begin", etc.).

### Examples

* `stack list host installfile chapter="kickstart"`

   Output a RedHat-compliant kickstart file.



