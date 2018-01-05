## Stacki Universal XML == SUX

Every OS that's installed automatically over the network (NOT from images) has a shell like language to perform the install. For CentOS/RedHat this is kickstart. For SLES/SUSE this is autoyast. For Ubuntu/Debian this is preseed.

On the surface they are different, but underneath they have the same basic structure:
* Pre install actions before the system is installed.
* Package installation.
* Post installation.
* First boot configuration.

This is not rocket science, you can install a Linux system over a network  with shell-scripts. It's dumb, but you can.

Stacki has been used to install CentOS/RHEL variants, Ubuntu, SLES, and even CoreOS. We have a real good idea about how OS installation happens and what needs to happen in order to install all of these from the same frontend.

We used to write specific files for kickstart, autoyast, and preseed, but in Stacki 5.0, we've managed to abstract the installation steps so you only have to write the XML once. There should be minimal, if any changes, for a different OS.

This "language" is Stacki Universal XML. (Affectionately known as "SUX.")

Don't freak out by the "XML." It's more like "HTML + extra tags" and those tags map to specific structures that are common to all auto-installation mechanisms.

If you've ever written an html document, you can write SUX.

If you've ever written a kickstart/preseed/autoyast file, you can write SUX.

So let's write SUX.

The following goes into the configuration of a cart or pallet. You will almost always write carts and not pallets. So the following examples are what you write into your carts xml files.

### Required XML.
All tags need an opening and a closing tag, just like html.

Closing tags are not optional.

When you create a cart it will be created under /export/stack/carts/&lt;cartname&gt;. There will be a file there called /export/stack/carts/&lt;cartname&gt;/nodes/cart-&lt;cartname&gt;-backend.xml

This is file your are going to edit for your cart configuration.

Every stacki xml file starts with an opening &lt;stack:stack&gt; tag and closes with the same tag only with a slash &lt;/stack:stack&gt;.

Everything else goes in-between those two tags.

There is only one set of these in any XML file, but it's required.

```
<stack:stack>

<!– Stacki Universal XML code goes here -->

</stack:stack>
```

This is actually valid XML, a profile will be built from this. It just doesn't do anything.

### Package tags

Adding packages can be done in individual package tags:

The format is &lt:stack:package&gt;package_name<l5;/stack:package>

Just like html, there is an opening tag and a closing tag.

```
<stack:package>teradata-citadel</stack:package>
```

Or as a list:

```
<stack:package>
lsof
socat
screen
</stack_package>
```

A fell representation of this file would be:

<stack:stack>
<stack:package>teradata-citadel</stack:package>
<stack:package>
lsof
socat
screen
</stack:package>
</stack:stack>

### Script tags

The script tags allow code to be run at various points during the installation: pre, post, and first boot.

There are 4 types of scripts:
* 2 pre-scripts: Install and Boot

Install: executed before partitioning
```
<stack:script stack:stage=“install-pre”>stuff</stack:script>
```

First boot: executed before network is up.
```
<stack:script stack:stage=“boot-pre”>stuff</stack:script>
```

* 2 post scripts: Install and Boot

Install: executed after partitioning with new system mounted.
```
<stack:script stack:stage=“install-post”>stuff</stack:script>
```

First boot: after network and other services are up. This runs last before login.

```
<stack:script stack:stage=“boot-post”>stuff</stack:script>
```

#### Altering script tags

Installation can be altered by providing parameters to script tags.

Alter behavior by adding the following:
* **stack:shell=“python|bash|perl"**
  - The code must be written in the language defined by “shell”
  only use in `<stack:script>` tags.


* **stack:chroot=“false”** (or “true”)
  - runs the script in a non-chroot environment (outside installing system)
  only use for in `<stack:script stack:stage=install-pre|post>`


* **stack:cond=“database attribute”**
  - Will run ONLY if the conditional is met. Python style syntax.
  - e.g `<stack:script stack:stage=”install-post” stack:cond=“os.version == ‘12.x’”>`
  - stack:cond can be used in all stack tags.


#### Script tag examples
Script tags can be chroot or non-chroot. By default chroot is true, so a post install script sets up scripts/files/etc. in the environment being installed.

##### A non-chroot script, i.e. chroot=false, runs in the installer environment.

This is a non-chroot example:

```
<stack:stack>

<stack:script stack:stage="install-post" stack:chroot="false">
#!/bin/sh
mkdir -p /mnt/tmp/stack_site
cp /tmp/stack_site/__init__.py /mnt/tmp/stack_site/
</stack:script>

</stack:stack>
```

##### Script with a conditional:

Uses a conditional to fire if and only if the os.version is 12.x. Please see [Using Attributes](Using-Attributes) for more details.

This is a chrooted script by default, so affects the environment being installed.

```
stack:stack>

<stack:script stack:cond="os.version == '12.x'" stack:stage="install-post">
/usr/bin/mlabel x:BOOTEFI
</stack:script>

</stack:stack>
```

#####  A simple install-pre:

This runs before partitioning in the environment being installed. There is no notion of chroot for pre scripts.

```
<stack:stack>

<stack:script stack:stage="install-pre">
if [ -d /sys/firmware/efi ]; then        
	netboot=`efibootmgr | awk '/^BootCurrent:/{print $2;}'`        
	[ ! -z $netboot ] &amp;&amp; echo $netboot/tmp/uefi_netbootfi
</stack:script>

</stack:stack>
```

##### First boot script.

Sometimes configuration has to happen during the first boot after services are up. The "boot-post" stage will always be the last thing to be run during the first boot after installation. Anything that has to be done to make the machine ready that you can't do during install, do here.

```
<stack:stack>

<stack:script stack:stage="boot-post”>
systemctl enable uefi-boot-method
systemctl start uefi-boot-method
</stack:script>

</stack:stack>
```

There is no boot-pre example. It's something that's rarely used.

### File tags.

You might want to add files, append to files, or create scripts to be run. The place to do that is in &lt;stack:file&gt;&lt;/stack:file&gt; tags.

File tags always go between script tags. If you have a file tag outside of a stack:script tag, your install script will barf, prolifically.

Here's a simple example:

```
<stack:script stack:stage=“install-post”>
<stack:file name=“/etc/motd”>
Backend installed by Stacki: &hostname;</stack:file>
</stack:script>

```

I'm writing an motd  that says "Backend installed by Stacki ...." The ... is going to look up the &hostname; in the database and substitute it. So the motd on backend-0-0 will read:

```Backend installed by Stacki: backend-0-0```

and on backend-0-2

```Backend installed by Stacki: backend-0-2```

#### Altering file tags

You can alter the behavior of file tags by adding one or more of the following parameters:

* add stack:mode=“append” to append.
* add “stack:perms="755”"" to set permissions (default is 644 or rw-r—r—)
* add “stack:owner="prometheus:prometheus"” to set userid/gid

##### File tag examples.

Changing permissions and append to /etc/ssh/sshd_config

```
<stack:script stack:stage=“install-post”>

<stack:file stack:name="/etc/ssh/sshd_config" stack:perms="640” stack:mode=“append”>
ForwardX11 No
</stack:file>

</stack:script>
```
