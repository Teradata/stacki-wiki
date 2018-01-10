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

#### Listing Attributes

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

#### Adding/Setting attributes

Global:
`stack set attr attr=[name] value=[new setting]`
 
Appliance:
`stack set appliance attr [appliance] attr=[name] value=[new setting]` 

Single host:
`stack set host attr [hostname] attr=[name] value=[new setting]`
 
Setting an Attribute assigns value to the key name. It will create the attr if it does not exist.

`stack add attr` commands do the same, but fail if the attribute already exists.

#### Removing attributes

This is actually fairly obvious.

Global:
`stack remove attr attr=[key]`

Appliance:
`stack remove appliance attr attr=[key]`

Host:
`stack remove host attr attr=[key]`

### Using attributes in Carts.

The real power of attributes comes when using them in carts. Attributes can be used for variable substitution and used in conditionals.

There are more details in the [Carts](Carts) section of the documentation, but I'll give an example here.

#### Variable substitution

In a kickstart/autoyast/preseed file any attribute's key can be called by using an xml entity format which is `&<attrkey>;`. So

Let's look at the resolv.xml file for an example. There is this bit of code snippet:

```
<stack:file stack:name="/etc/hosts">
127.0.0.1	localhost.localdomain localhost
&hostaddr;	&hostname;.&domainname; &hostname;
</stack:file>
```

The stack:file tag says to put the following stuff in /etc/hosts on the installing machine (e.g. backend-0-0)

The `&hostaddr;	&hostname;.&domainname; &hostname;` line gets compiled during the network file request to:

10.5.255.254 backend-0-0.local backend-0-0

So my file on the backend will look like this:

```
127.0.0.1       localhost.localdomain localhost
10.5.255.254    backend-0-0.local backend-0-0
```

Any attribute key can be used in an XML entity structure to call the value of that key. Program your cluster.


#### Using an attribute as a conditional

Attributes can also be to fire code if a condition is met.

Take for example adding a prometheus server for monitoring to a cluster.

I have created an attribute call "prometheus.firewall." I want to use it to add firewall rules to the host serving as my Prometheus server.

So I define the attribute:

```
# stack set attr attr=prometheus.firewall value=False
```

But host backend-0-2 is my firewall so I'll set it to "True."

```
# stack set host attr backend-0-2 attr=prometheus.firewall value=True
```

Now when backend-0-2 installs, it will run the following commands:

```
<stack:script stack:stage="install-post" stack:cond="prometheus.firewall">
/opt/stack/bin/stack add host firewall &hostname; network=all \
        table=filter rulename=PROMETHEUS service="9090" \
        protocol="tcp" action="ACCEPT" chain="INPUT" \
        flags="-m state --state NEW" comment="Prometheus"

/opt/stack/bin/stack add host firewall &hostname; network=all \
        table=filter rulename=GRAFANA service="3000" \
        protocol="tcp" action="ACCEPT" chain="INPUT" \
        flags="-m state --state NEW" comment="Grafana"

systemctl restart iptables
</stack:script>
```

But no other machine will.

In this way, you can have multiple configurations for a service in one cart file, dependent on attributes you have set.

One thing I should mention: the 'stack:cond=' structure is python-esque in implementation so you can also use lists/and/or/not on that right side:

These are all snipped:

List:
```
stack:script stack:stage="install-post" stack:cond=" in ['CentOS', 'RHEL']"
```
And:
```
stack:script stack:stage="install-post" stack:cond="os == 'CentOS' and os == 'RHEL']"
```

Or:
```
stack:script stack:stage="install-post" stack:cond="os == 'CentOS' or os == 'RHEL']"
```

### Using attributes in Spreadsheets

If you are defining lots of attributes for a particular application, then it's easier to pack these into an attribute file.


This is an example of what happens for the stacki-kubernetes pallet. It's large, but will give you a good idea of what's possible.

```
| target      | kube.domain      | kube.enable_dashboard | kube.insecure | kube.master | kube.master_ip | kube.minion | kube.pod_dir            | kube.pull_pods | kube.secure | docker.registry.external | docker.registry.local | etcd.cluster_member | etcd.prefix     |
|:------------|:-----------------|:----------------------|:--------------|:------------|:---------------|:------------|:------------------------|:---------------|:------------|:-------------------------|:----------------------|:--------------------|:----------------|
| global      | kubernetes.local | False                 | False         | False       | 10.5.255.254   | True        | install/kubernetes/pods | True           | True        | True                     | False                 | False               | /stacki/network |
| backend-0-0 |                  | True                  |               | True        |                |             |                         |                |             |                          |                       | True                |                 |
| backend-0-1 |                  |                       |               |             |                |             |                         |                |             |                          |                       | True                |                 |
| backend-0-2 |                  |                       |               |             |                |             |                         |                |             |                          |                       | True                |                 |
| backend-0-3 |                  |                       |               |             |                |             |                         |                |             |                          |                       |                     |                 |
| backend-0-4 |                  |                       |               |             |                |             |                         |                |             |                          |                       |                     |                 |

```

In reality the csv file looks like this:
```
target,kube.domain,kube.enable_dashboard,kube.insecure,kube.master,kube.master_ip,kube.minion,kube.pod_dir,kube.pull_pods,kube.secure,docker.registry.external,docker.registry.local,etcd.cluster_member,etcd.prefix
global,kubernetes.local,False,False,False,10.5.255.254,True,install/kubernetes/pods,True,True,True,False,False,/stacki/network
backend-0-0,,True,,True,,,,,,,,True,
backend-0-1,,,,,,,,,,,,True,
backend-0-2,,,,,,,,,,,,True,
backend-0-3,,,,,,,,,,,,,
backend-0-4,,,,,,,,,,,,,
```

Let's unpack it a bit:

The header line requires "target" followed by all the keys, comma delimited.

The next lines state which "target" (global,appliance, or host) a value should be set for. You'll note, the global line has a value for every key. This is the default value.

The individual hosts, change the default value. It's easier to define a global value that will be common, and change the exceptions at the host or appliance level.

This attribute file, contains no appliance level targets.

Load it:

```
# stack load attrfile file=kube-attrs.csv
```

Output:
```
Sync Config
	       	       Sync DNS
	       	       Sync Host
	       	       Sync DHCP
	       	       Sync Host Repo
	       Sync Host Config
	       	       Sync Host Boot
	       Sync Host Config
	       	       Sync Host Boot
	       Sync Host Config
	       	       Sync Host Boot
	       Sync Host Config
	       	       Sync Host Boot
	       Sync Host Config
	       	       Sync Host Boot
/export/stack/spreadsheets/RCS/kube-attrs.csv,v  <--  /export/stack/spreadsheets/kube-attrs.csv
file is unchanged; reverting to previous revision 1.1
done
date: write error: Broken pipe
/export/stack/spreadsheets/RCS/kube-attrs.csv,v  -->  /export/stack/spreadsheets/kube-attrs.csv
revision 1.1 (locked)
done
```

Now every attribute we have defined, can be used for variable substitution or used as a conditional to implement scripts and files in a cart.

Using attribute files is a *Stacki best practice*, they're easier to manage and communicate with other members of your infrastructure team. 
