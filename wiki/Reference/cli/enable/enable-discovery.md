## enable discovery

### Usage

`stack enable discovery [appliance=string] [basename=string] [box=string] [debug=boolean] [install=boolean] [installaction=string] [rack=string] [rank=string]`

### Description


	Start the node discovery daemon.

	

### Parameters
* `{appliance=string}`
* `{basename=string}`
* `{box=string}`
* `{debug=boolean}`
* `{install=boolean}`
* `{installaction=string}`
* `{rack=string}`
* `{rank=string}`

   The rank number to start from when discovering nodes. Defaults to the next availble rank number for the rack.

### Examples

* `stack enable discovery`

   Discover nodes and install the backend appliance using all defaults.


### Related
[disable discovery](disable-discovery)

[report discovery](report-discovery)


