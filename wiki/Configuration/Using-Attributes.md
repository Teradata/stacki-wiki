## Attributes

"Attributes" are **key/value pairs** stored in the database that allow users to:

* Modify how a server works
* Modify how Stacki works with a server
* How Stacki relates to a cluster and the application running onit.
* How a server is installed.

Attributes are used in all facets of cluster management and are persistent across install/reinstall of a single or many servers.

Attributes are also easy to add, set, and remove on the command line.

By default, Stacki comes with a set of attributes that help direct the base installation of a server.

There are three levels on which an attribute can be defined.

The order is global -> appliance -> host.

* Global: The top level attribute. Default designations should be put at a global level.
* Appliance: These values are added to or modified by those in the appliance list that this server belongs to.
* Host: Host attributes assigned specifically to a given host are added or modified.

This leaves us with a custom per-server list of attributes that will be used primarily for generating installation, but also for classification.

If you have set a global attribute default to "True" and it's set at an individual host level default to "False", during installation, when that attribute is called, it will evaluate to "False."

This allows us to program our cluster rather than keeping multiple files around for different scenarios. We can program different configuration based on a defined attribute.

### Listing Attributes

To see what attributes you have, use the "stack list command."

```
# stack list attr
```

Shows attributes defined at the Global level. An initial frontend installation will show you the attributes Stacki uses as part of the default installation.

```
stack list appliance attr [appliance]
```

Shows the list of appliance defined attrs. An attribute list is concatenated from Global + Appliance + Host. With the layer below overwriting the layer if both layers define the same attribute.

```
stack list host attr [hostname]
```

Shows the attributes for a given host.

An attribute list is concatenated from Global + Appliance + Host. With the layer below overwriting the layer if both layers define the same attribute.

### Adding/Setting attributes


### Removing attributes

### Using attributes in Spreadsheets

### Using attributes in Carts.
