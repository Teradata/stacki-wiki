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

We're going to create an appliance. This is what is currently available.

```
# stack list appliance
APPLIANCE LONG NAME PUBLIC
frontend  Frontend  no
builder   Builder   no
backend   Backend   yes
```

The "Public" field set to "yes" mean it will show up in a "discover-nodes" to be chosen during discovery.

We'll add a "login" appliance as part of our cluster so that the unwashed masses can log in.

```
# stack add appliance login longname="Login" node=backend public=yes
```
The "longname" option here is the pretty name of our appliance, used when displaying the node type in "discover-nodes."

The "node" option tells us where in the installation graph to tag this node. You will almost always want to use "backend" because this gives us a basic node for installation. We will add what we want for a "login" node in a cart.

List it:

```
# stack list appliance
APPLIANCE LONG NAME PUBLIC
frontend  Frontend  no
builder   Builder   no
backend   Backend   yes
login     Login     yes
```

So if we are discovering machines, we can choose Login for a machine or a set of machines we are discovering.

If we set this after the initial install, we can set the appliance on the command line:

Add it:
```
# stack set host appliance backend-0-[01] appliance=login
```

List it:
```
# stack list host
HOST        RACK RANK APPLIANCE OS     BOX     ENVIRONMENT OSACTION INSTALLACTION STATUS COMMENT
stacki-50   0    0    frontend  redhat default ----------- default  default       up
backend-0-0 0    0    login     redhat default ----------- default  console       ------
backend-0-1 0    1    login     redhat default ----------- default  console       ------
backend-0-2 0    2    backend   redhat default ----------- default  console       ------
backend-0-3 0    3    backend   redhat default ----------- default  console       ------
backend-0-4 0    4    backend   redhat default ----------- default  console       ------
```

There are a couple of attributes we want to set if we want to manage these from the command line with `stack run`. We can set these at the appliance level so any "login" appliance will get them.

```
# stack set attr appliance login attr=managed value=True
```

We want to make this so users can log-in. This means a number of things that are too long to create here, but we'll do something basic: adding sssd and using a minimal config file.

Add a cart:
```
stack add cart login
```

Edit /export/stack/carts/login/nodes/cart-login-backend.xml and add the following between the opening and closing &lt:stack:stack&gt; tags:

```
<stack:script stack:cond="appliance == 'login'" stack:stage="install-post">
<stack:file stack:name="/etc/sssd/sssd.confg">
[sssd]
services = nss, pam
domains = shadowutils

[nss]

[pam]

[domain/shadowutils]
id_provider = files

auth_provider = proxy
proxy_pam_target = sssd-shadowutils

proxy_fast_alias = True
</stack:file>
</stack:script>
```

Enable the cart:

```
stack enable cart login
```

Notice the conditional based on the "login" appliance type.

Test it with `stack list host profile &lt;hostname&gt;` for a backend node and a login node. The sssd configuration should be output for only the login node.

All configuration for the "login" node should be contained in install-post scripts that check the conditional appliance == 'login'.

This is one way to skin this particular cat.
