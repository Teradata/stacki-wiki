Stacki allows the admin to customize the software
footprint of a backend node to enable additional
functionality.

In a default setup, Stacki installs backend nodes with
a very small software footprint. In Stacki parlance, the
backend node is brought up to **a ping and a prompt**.

The backend node will have its network configured, and
the SSH daemon is started to allow login access from
the frontend.

To make the backend node more useful, other application
software and services will need to be installed and
configured.

There are several "levels" of installing applications in Stacki,
we’re going to look at the simplest case. Assumptions are:

1. The application to be installed is available as an RPM
2. The application can be configured using simple shell command
   or a script.
3. The developer is has a basic knowledge of editing HTML-like syntax.

Stacki uses a collection of XML files that provide the definition
of a system, and the instructions for installing a backend node.
To extend the software footprint of a node, we will need to extend
the XML framework to accommodate the extra functionality
required.

The XML structure is not complicated - think of it as HTML with extra
tags. The tags Stacki incorporates, map to kickstart elements you 
should already be familiar with: pre, post, main, package. From there
it's mostly adding shell commands and scripts to install and configure
applications.

For more information about the available XML tags, refer to the
[Wire Reference Guide](Wire-Reference)

### Introduction to Carts

Carts are created by end users in order to customize the configuration of
backend nodes.
For this section, we will walk through an example of creating a cart to 
add an Apache web server to backend nodes.
We'll call this the *apache* cart.

First, we'll need to add the *apache* cart to the frontend:

	# stack add cart apache

This will create the directory */export/stack/carts/apache* and populate it
with the following files and directories:

```
RPMS/
nodes/
nodes/cart-apache-backend.xml
graph/
graph/cart-apache.xml
```

In Stacki, backend node configuration is controlled by a collection of XML
files.
A *node XML file* contains the description of additional packages and
configuration that should be applied to backend hosts.
For this example, we will edit *nodes/cart-apache-backend.xml* and include a
line that instructs Stacki to install the *httpd* package (the name of the
Apache web server).
Using your favorite editor, open *nodes/cart-apache-backend.xml* and you'll
see:

```
<?xml version="1.0" standalone="no"?>
<kickstart>

	<description>
        apache cart backend appliance extensions
	</description>

        <!-- <package></package> -->

<!-- shell code for post RPM installation -->
<post>

</post>
</kickstart>
```

To add the *httpd* package, change the line:

```
<!-- <package></package> -->
```

To:

```
<package>httpd</package>
```

Next, we need to add code that runs in the *post* section (the section that
executes after all packages are installed) that will enable the httpd server.
To do that, change the section:

```
<post>

</post>
```

To:

```
<post>
/sbin/chkconfig --add httpd
/sbin/chkconfig httpd on
</post>
```

Now we need to associate the *apache* cart with the default box.
This makes sure our modifications will be executed when
backend nodes are installed.

A box is collection of *pallets* and *carts*.
When you build a Stacki frontend, the *os* and *stacki* pallets are already
assembled into the *default* box.
To see what pallets and carts are included in the default box,
execute:

	# stack list box

And you'll see:

```
NAME     OS     PALLETS                   CARTS
default: redhat os-6.7-6.x stacki-3.0-6.x -----
```

This tells us that the default box is currently composed of the
*os* and *stacki* pallets (and no carts).

We can associate our *apache* cart to the default box by executing:

	# stack enable cart apache

And now *stack list box* shows us:

```
NAME     OS     PALLETS                   CARTS 
default: redhat os-6.7-6.x stacki-3.0-6.x apache
```

After the apache cart is associated with the default box, we can verify that
our changes will be applied to a backend host when it installs.
We can create a kickstart file for a backend host (in the command below,
the backend host's name is *backend-0-0*), by executing:

	# stack list host profile backend-0-0 > /tmp/ks.cfg	

If you open the file */tmp/ks.cfg*, you'll see that *httpd* is listed in the
*packages* section:

```
%packages --ignoremissing
foundation-rcs
httpd
libcap
ntp
```

And that our *post* section is in one of the post sections:

```
%post --log=/mnt/sysimage/var/log/stack-install.log

/sbin/chkconfig --add httpd
/sbin/chkconfig httpd on


%end
```

Now when a backend host is reinstalled, the Apache web server will
automatically be up and running.


### Adding New RPMS to a Cart

Download the RPM(s) for the application you want.
Then you'll want to copy them into your cart.

For this example, we'll still be using the *apache* cart that we created above.
Copy the RPM(s) into:

```
/export/stack/carts/apache/RPMS
```

If you want to add them on the fly, i.e. you don't want to reinstall your machines then execute:

	# stack compile cart apache	
	# stack report host yum "hostname" | stack report script | ssh -T "hostname"

In the above command, *hostname* is a name of one of your backend nodes.

Then to add *rpmname* to all your backend nodes.

	# stack run host backend comand="yum clean all && yum -y install <rpmname>"

To automatically apply the RPM *rpmname* to a backend node during installation,
just add another *package* line as described above.
For example, add the following line to your *cart-apache-backend.xml* node XML
file:

```
<package>rpmname</package>
```

