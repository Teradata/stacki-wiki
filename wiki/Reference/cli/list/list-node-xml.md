## list node xml

### Usage

`stack list node xml [attrs=string] [eval=bool] [gen=string] [missing-check=bool] [pallet=string]`

### Description


	Lists the XML configuration information for a host. The graph
	traversal for the XML output is rooted at the XML node file
	specified by the 'node' argument. This command executes the first
	pre-processor pass on the configuration graph, performs all
	variable substitutions, and runs all eval sections.

	

### Parameters
* `{attrs=string}`
* `{eval=bool}`
* `{gen=string}`
* `{missing-check=bool}`
* `{pallet=string}`

   If set, only expand nodes from the named pallet. If not
	supplied, then the all pallets are used.

### Examples

* `stack list node xml backend`

   Generate the XML graph starting at the XML node named 'backend.xml'.



