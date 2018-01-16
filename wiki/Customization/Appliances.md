## Appliances

An "appliance" in Stacki nomenclature is a way to group installation and configuration logic for a particular set of hosts.

The "backend" appliance is the default appliance applied to all installing backend nodes.

The backend appliance has a default box (which can be changed) and default network install file assigned to any individual node of appliance "backend".

You can create appliances to express a node's or a group of nodes' role within a cluster, e.g. a database or web server.

We have one client who creates an appliance based on the hardware of the machine. Their "data" appliance is a machine with 24x4G drives. Their "edge" nodes are 5x2G SSD drives. We have another client who bases their appliances on the role a machine play in the cluster. They have 34 different appliances defined.

### When do I create an appliance?

The decision to use an appliance as a way to express some kind of logic in a cluster can be a way to reduce the complexity of your cart infrastructure.

We use attributes as conditionals in SUX to determine configuration based on the attribute. In a cart xml file, this can get long and difficult to keep in your head.

One way to handle this is to define an appliance, and use the appliance type as the conditional. We'll show an example of this in a moment.

### Creating an appliance
