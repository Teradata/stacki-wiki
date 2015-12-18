## list node xml

### Usage

`stack list node xml [attrs=string] [eval=bool] [gen=string] [missing-check=bool] [pallet=string]`

### Description

Lists the XML configuration information for a host. The graph
	traversal for the XML output is rooted at the XML node file
	specified by the 'node' argument. This command executes the first
	pre-processor pass on the configuration graph, performs all
	variable substitutions, and runs all eval sections.

### Examples

* `stack list node xml compute`

   Generate the XML graph starting at the XML node named 'compute.xml'.



