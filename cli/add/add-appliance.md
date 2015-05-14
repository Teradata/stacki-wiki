## add appliance

### Usage

`stack add appliance {appliance} [membership=string] [node=string] [public=bool]`

### Description

Add an appliance specification to the database.

### Arguments

* `{appliance}`

   The appliance name (e.g., 'compute', 'frontend', 'nas').


### Parameters
* `[membership=string]`

   The full membership name of the appliance. This name will be displayed
	in the appliances menu by insert-ethers (e.g., 'NAS Appliance'). If
	not supplied, the membership name is set to the appliance name.
* `[node=string]`

   The name of the root XML node (e.g., 'compute', 'nas', 'viz-tile'). If
	not supplied, the node name is set to the appliance name.
* `[public=bool]`

   True means this appliance will be displayed by 'insert-ethers' in 
	the Appliance menu. The default is 'yes'.

### Examples

* `stack add appliance nas membership="NAS Appliance" node=nas public=yes`

   

* `stack add appliance tile membership=Tile node=viz-tile public=yes`

   



