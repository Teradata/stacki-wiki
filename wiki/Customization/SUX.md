## Stacki Universal XML

Every OS that's installed automatically over the network (NOT from images) has a shell like language to perform the install. For CentOS/RedHat this is kickstart. For SLES/SUSE this is autoyast. For Ubuntu/Debian this is preseed.

On the surface they are different, but underneath they have the same basic structure:

* Pre install actions before the system is installed.
* Package installation.
* Post installation.
* First boot configuration.

This is not rocket science, you can install a Linux system over a network with shell-scripts. It's dumb, but you can.

Stacki has been used to install CentOS/RHEL variants, Ubuntu, SLES, and even CoreOS. We have a real good idea about how OS installation happens and what needs to happen in order to install all of these from the same frontend.

We used to write specific files for kickstart, autoyast, and preseed, but in Stacki 5.0, we've managed to abstract the installation steps so you only have to write the XML once. There should be minimal, if any changes, for a different OS.

This language is Stacki Universal XML (affectionately known as SUX).

Don't freak out by the XML. It's more like HTML with extra tags and those tags map to specific structures that are common to all auto-installation mechanisms. If you've ever written an HTML document, you can write SUX. If you've ever written a kickstart/preseed/autoyast file, you can write SUX.

There are two things to note about SUX (and XML in general):
1. SUX uses optional XML attributes pretty heavily. Don't confuse an XML attribute with what Stacki calls attributes. An XML attribute is a key-value pair that is added to the starting XML tag in a block. Further, what Stacki calls an attribute is called an entity in SUX (see [Using Attributes](Using-Attributes)).

1. All XML tags and attributes require the `stack` namespace this is why you need to write `stack:package` instead of just `package`. We have some good reasons for this (mostly because of autoyast), but it can be somewhat of a pain.

The following goes into the configuration of a cart or pallet. You will almost always write carts and not pallets. So the following examples are what you write into your carts xml files.

### Required XML

All tags need an opening and a closing tag, just like HTML, but closing tags are not optional.

When you create a cart it will be created under
`/export/stack/carts/<cartname>`.
There will be a file there called `/export/stack/carts/<cartname>/nodes/cart-<cartname>-backend.xml`

This is file your are going to edit for your cart configuration.

Every stacki xml file starts with an opening `<stack:stack>` tag and closes with the same tag only with a slash `</stack:stack>`.

Everything else goes in-between those two tags.

There is only one set of these in any XML file, but it's required.

```
<stack:stack>

<!– Stacki Universal XML code goes here -->

</stack:stack>
```

This is actually valid XML, a profile will be built from this. It just doesn't do anything.

### Packages

Adding packages can be done in individual package tags:

The format is `<stack:package>package_name</stack:package>`

Just like HTML, there is an opening tag and a closing tag.

```
<stack:package>teradata-citadel</stack:package>
```

Or as a list, where each package is on a line by itself.

```
<stack:package>
lsof
socat
screen
</stack_package>
```

A full representation of this file would be:
```
<stack:stack>

<stack:package>teradata-citadel</stack:package>

<stack:package>
lsof
socat
screen
</stack:package>

</stack:stack>
```

#### Stages

Depending on the operating system, package can be installed at two stages of the installation. All operating systems support installing packages during the system installer step (e.g. RedHat Anaconda). Stacki refers to this stage as `install`. Some operating systems (e.g. SLES) support installing packages on first boot after the system installer ran. This is helpful for packages that cannot correctly run there post sections inside the constrained installation environment. Stacki refers to this stage as `boot`.

The package tag can be modified with either a `stack:stage="install"` or a `stage:stage="boot"` to indicate when the package should be installed.
The default is `install`, so for most cases this never needs to be specified.

An example of this would be:
```
<stack:stack>

  <stack:package stack:stage="boot">badrpm</stack:package>

</stack:stack>
```

#### Disabling

For the over optimizers with nothing better to do, you can also request the installer not install a package. Again operating systems handle this request differently and you will often find the installer declines your request when dependencies require it.

To disable a package add the `stack:enable="false"` XML attribute to the package tag. The default, which does not need to be specified in `stack:enable="true"`.

#### Patterns

Most operating systems have a notion of package groups, for example in SLES these are call software patterns. You can use the package tag to install these as well but you need to add the `stack:meta="true"` attribute to the tag. The default is `stack:meta="false"`. There is no support for disabling meta packages.


### Scripts

Adding installation scripts is done with the `stack:script` tag.

#### Stages

Depending on the operating system scripts can be run at five different stages during installation. Just like the `stack:package` tag these are specified using XML attributes.  The different stages are:

1. `stack:stage="install-pre"` : before disk partitioning
1. `stack:stage="install-pre-package"` : before package installation
1. `stack:stage="install-post"` : after package installation
1. `stack:stage="boot-pre"` : after reboot before init scripts
1. `stack:stage="boot-post"` : after init scripts

The default stage is `stack:stage="install-post"`.

Not all operating systems support all these stages. The following table shows if the stage is supported natively by the installers, is provided by stacki, and not supported.


OS     | install-pre | install-pre-package | install-post | boot-pre | boot-post
------ | ----------- | ------------------- | ------------ | -------- | ---------
RedHat | native      |                     | native       | stacki   | stacki
SLES   | native      | native              | native       | native   | native


#### Chroot

Scripts run in the `stack:stage="install-post"` have to option of running chrooted into the install image, or non-chrooted. It is extremely rare for a script to require the non-chrooted environment, but when needed add the `stack:chroot="false"` attribute to the script tag (default is `stack:chroot="false"`).

#### Language

Script are assumed to be written for the Bash shell, but can also be written in any language. To specify a different language use the `stack:shell` attribute and specify the complete system path to the interpreter. For example, to use the Stacki version of Python add the attribute `stack:shell="/opt/stack/bin/python"` to the script tag.

#### Files

You might want to add files, append to files, or create scripts to be run. The place to do that is in a `stack:file` tag.

File tags can only be used within `stack:script` section, and will only work if the shell is Bash (or sh compatible). The tag is really just a helper function see you don't have to write shell here documents. You don't need to use it to create files but you should.

For example, to modify the message of the day file do the following:

```
<stack:script>
<stack:file stack:name=“/etc/motd”>
Backend installed by Stacki: &hostname;</stack:file>
</stack:script>

```

In this example we are writing an motd that says "Backend installed by Stacki X", where X is going to look up the &hostname; host attribute substitute it. So the motd on backend-0-0 will read:

```
Backend installed by Stacki: backend-0-0
```

and on backend-0-2

```
Backend installed by Stacki: backend-0-2
```

See [Using Attributes](Using-Attributes) for more examples of how SUX uses XML entities for host attributes.

You can alter the behavior of file tags by adding one or more of the following XML attributes.

* `stack:mode="MODE"`   Where MODE is "append" or "create" (default is "create")

* `stack:perms="PERMS"` Where PERMS is the UNIX numeric file permissions (e.g. "755")

* `stack:owner="OWNER"` Where OWNER is either the UNIX user or the UNIX user:group for the file. These values can be numeric or text. For example `stack:owner="apache"` to set only the user, and `stack:owner="root:apache"` to set both the user and group.
All operating system installers run as root and will create files owned as "root:root", this attribute is only needed to create non-root files.

### Conditionals

The `stack:cond` attribute can be added to any SUX tag to define a conditional section of the profile.  For example:

```
<stack:package stack:cond="False">tcpdump</stack:package>
```

SUX will parse the above XML and evaluate the conditional as false, and the tcpdump package will not be added to the installer's package list. Instead of just testing on True or False we can actually test on the Stacki host attributes.  To see what you can test on for a given host look at the output of `stack list host attr <hostname>`. Any attribute in the list is available for testing inside the conditional.

For example to test if a machine is running is Amazon EC2 we can look at the `platform` attribute. Note, that at attribute does not have to exist to use it, if an attribute isn't there it will just evaulate to False.

```
<stack:package stack:cond="platform == 'aws'">tcpdump</stack:package>
```

In the above we replace the simple condition with the Python looking statement `platform == 'aws'`. This looks like Python because it is (sort of) but will the Stacki host attributes all defined as variables.

The `stack:cond` XML attribute can be added to any SUX tag.


### Examples

#### non-chrooted script

In this example a script in the `stack:stage="install-post"` is run as `stack:chroot="false"` so we can copy a file from the installer ramdisk onto the system disk. Not the `stack:stage` attribute is not used here as that is the default stage for all scripts.

```
<stack:stack>

<stack:script stack:chroot="false">
mkdir -p /mnt/tmp/stack_site
cp /tmp/stack_site/__init__.py /mnt/tmp/stack_site/
</stack:script>

</stack:stack>
```

#### conditional script

In this example the disk label is modified only is the operating system version is "12.x" (which in this example refers to SLES 12.x). Here we specify the `stack:stage` even though it isn't required, and use a `stack:cond` that tests to `os.version` attribute.

```
<stack:stack>

<stack:script stack:cond="os.version == '12.x'" stack:stage="install-post">
/usr/bin/mlabel x:BOOTEFI
</stack:script>

</stack:stack>
```
