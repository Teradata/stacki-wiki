## list host graph

### Usage

`stack list host graph [host]... [arch=string] [basedir=string]`

### Description

For each host, output a graphviz script to produce a diagram of the
	XML configuration graph. If no hosts are specified, a graph for every
	known host is listed.

### Arguments

* `[host]`

   Zero, one or more host names. If no host names are supplied, info about
	all the known hosts is listed.


### Parameters
* `[arch=string]`

   Optional. If specified, generate a graph for the specified CPU type.
	If not specified, then 'arch' defaults to this host's architecture.
* `[basedir=string]`

   Optional. If specified, the location of the XML node files.

### Examples

* `stack list host graph compute-0-0`

   Generates a graph for compute-0-0



