## Adding software

One of the easiest ways to add functionality and customization is to add software to your backend nodes.

There are couple ways to do this - this is the no-brainer, gottagetitworkingrightnow, easy way.

### Creating a Cart

Carts are created by administrators in order to customize the configuration of backend nodes.

For this section, we will walk through an example of creating a cart to
add software we want to have on our backend nodes.

We need a cart, so we'll create a *site-custom* cart that contains all the changes we care about for our data center.

First, we'll need to add the *site-custom* cart to the frontend:

	# stack add cart site-custom

List it:
	# stack list cart
	NAME        BOXES
	site-custom

You'll notice it's not associated with a Box. (More on this later.) So it will not fire on backend installs until you enable the cart.

We'll edit first, then enable.

The "add cart" command will create the directory */export/stack/carts/site-custom* and populate it with the following files and directories:

```
RPMS/
nodes/
nodes/cart-site-custom-backend.xml
graph/
graph/cart-site-custom.xml
```

Now edit cart-site-custom-backend.xml to make the changes you want to install on backend nodes.

### Add already existing RPM.

***If:***
* An RPM already exists in one of the pallets on the frontend.
* It is not installed during the default Stacki install.


***Then:***
* Add the name of the RPM to a set of package tags to have it installed.

For example, I like to have "screen", "socat", and "tcpdump" on my backend nodes when I'm testing out a new application - just because I'm like that.

All three of these pieces of software already exist in my repository. (I added CentOS and CentOS-Updates isos as my os pallets.)

```
# yum list socat screen tcpdump
Available Packages
screen.x86_64         4.1.0-0.23.20120314git3c2946.el7_2        CentOS-7-redhat7
socat.x86_64          1.7.3.2-2.el7                             CentOS-7-redhat7
tcpdump.x86_64        14:4.9.0-5.el7                            CentOS-7-redhat7
```

Using your favorite editor, open *nodes/cart-site-custom-backend.xml* and you'll see:

```
<stack:stack>
	<stack:description>
	site-custom cart backend appliance extensions
	</stack:description>

	<stack:package><!-- add packages here --></stack:package>

<stack:script stack:stage="install-post">
<!-- add shell code for post install configuration -->
</stack:script>

</stack:stack>
```

Take this piece:

```
<!-- <stack:package></stack:package> -->
```

Take out the html commenting, and change it to:

```
<stack:package>screen</stack:package>
<stack:package>socat</stack:package>
<stack:package>tcpdump</stack:package>
```

Now, when the backend nodes are installed, these three RPMS will be added.

# Adding an RPM from the interwebzzz.

Sometimes you want to download one or two or a few RPMS from the whirled-wide interwebzzz. (If it's more than three, you should seriously consider [adding a software pallet](Adding-Software-Pallets))

"cd" to the */export/stack/carts/site-custom/RPMS directory. Get your wild and crazy package. We'll add [fortune-mod](https://centos.pkgs.org/7/puias-x86_64/fortune-mod-1.99.1-17.sdl7.x86_64.rpm.html). Describe-ed thusly:


	Fortune-mod contains the ever-popular fortune program, which will
	display quotes or witticisms. Fun-loving system administrators can add
	fortune to users' .login files, so that the users get their dose of
	wisdom each time they log in.

And since we are fun-loving system administrators, we will add this to our *site-custom* cart to help people realize the world is not so sad and dreary, just them.

So get it from the webzz or scp it to the cart RPMS directory from wherever you downloaded it:
	# wget --no-check-certificate http://springdale.math.ias.edu/data/puias/7/x86_64/os/Addons/Packages/fortune-mod-1.99.1-17.sdl7.x86_64.rpm

Make sure it's there:
	# ls .
	fortune-mod-1.99.1-17.sdl7.x86_64.rpm


Now we'll add that to our package tags so it installs.

This time though, I'll do it as a list, which you can also do:

```
<stack:package>
screen
socate
tcpdump
fortune-mod
</stack:package>
```

Now we need to associate the *site-custom* cart with the default box so our changes will take effect when a machine is installed/reinstalled.

A *box* is collection of *pallets* and *carts* that can be assigned to a machine or collection of machines.

When you build a Stacki frontend, the *os* and *stacki* pallets are already
assembled into the *default* box.

To see what pallets and carts are included in the default box,
execute:

	# stack list box

And you'll see:

```
# stack list box
NAME    default
OS      redhat
PALLETS stacki-5.0_20171128_b0ed4e3-redhat7 os-7.4_20171128-redhat7
```

This tells us that the default box is currently composed of the
*os* and *stacki* pallets (and no carts).

We can associate our *site-custom* cart to the default box by executing:

	# stack enable cart apache

And now *stack list box* shows us:

```
# stack list box
NAME    default
OS      redhat
PALLETS stacki-5.0_20171128_b0ed4e3-redhat7 os-7.4_20171128-redhat7
CARTS   site-custom
```

After the *site-custom* cart is associated with the default box, we can verify that our changes will be applied to a backend host when it installs.
We can create a kickstart file for a backend host (in the command below,
the backend host's name is *backend-0-0*), by executing:

	# stack list host profile backend-0-0 > /tmp/ks.cfg

If you open the file */tmp/ks.cfg*, you'll see that *screen*, *socat*, *tcpdump*, and *fortune-mod* are listed in the
*packages* section:

```
<section source="/export/stack/carts/site-custom/nodes/cart-site-custom-backend.xml"><![CDATA[
fortune-mod
screen
socat
tcpdump
        ]]></section>
```

Now when a backend host is reinstalled, these RPMS will be on the installed hosts.


### Add RPMS on the fly
If you want to add the RPMs on the fly, i.e. you don't want to reinstall your machines then execute:

	# stack sync host repo a:backend

The a:backend says to run this on all "appliances of type "backend."

The "sync host repo" synchronises the /etc/yum.repos.d/stacki.repo to the backend machines. This repo config files now contains the *site-custom* cart as a repository so any RPMS in that cart are available to the backends. See the [About Repos](About-Repos) for further information about the repository structure.

Then to add *rpmname* to all your backend nodes.

	# stack run host a:backend command="yum clean all && yum -y install <rpmname>"

### Creating your own RPMS.

Stacki has the ability to create rudimentary RPMS from directories to allow installing site specific software. Putting those applications in RPMS is recommended because it allows you to add them to a cart and take advantage of the peer-to-peer installer during installation. You can find details in [Creating Site RPMS](Creating-Site-RPMS)

Frequently, there are configuration requirements for the service you have installed with an RPM. We will continue with the **site-custom** cart example in the [Adding Files](Adding-Files) and [Adding Scripts](Adding-Scripts) scripts sections to demonstrate.

Start with [Adding Files](Adding-Files) first.
