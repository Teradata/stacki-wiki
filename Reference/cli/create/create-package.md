---
layout: page
title: create package
permalink: /create-package
sidebarloc: /Reference/cli/create
---

## create package

### Usage

`stack create package [dir=string] [name=string] [prefix=string] [release=string] [rpmextra=string] [version=string]`

### Description

Create a RedHat or Solaris package from a given directory.  The
	package will install files in either the same location as the given
	directory, or a combination of the directory basename and the
	provided prefix.

### Parameters
* `{dir=string}`
* `{name=string}`
* `{prefix=string}`
* `{release=string}`
* `{rpmextra=string}`
* `{version=string}`

   Version number of the created package (default is current version of Rocks+)

### Examples

* `stack create package dir=/opt/stream name=stream`

   Create a package named stream in the current directory using the
	contents of the /opt/stream directory.  The resulting package will
	install its files at /opt/stream.

* `stack create package dir=/opt/stream name=localstream prefix=/usr/local`

   Create a package named localstream in the current directory using the
	contents of the /opt/stream directory.  The resulting package will
	install its files at /usr/local/stream.

* `stack createpackage dir=/opt/stream name=stream rpmextra="Requires: iperf, AutoReqProv: no"`

   Creates the steam package with an RPM "requires" directive on iperf,
	and disables automatic dependency resolution for the package.



