## Adding Files

Whatever you can do in a shell, you can do during install.

Our assumption is that when a machine comes up, it should be exactly the way you want at first boot. This way you're certain your site specific customization is going to run once you hit the install/reinstall button, because you've already done the hard configuration scripting to make it so.

Which means you probably don't want to recreate all of that work just because you've started using a new tool. You've already figured it out, you don't want to do it again, and you probably can't remember why you do some of the things you do in those scripts. We'll discuss how to modify a cart to:
* Not lose work you've already done.
* Put your already existing config files where they belong: on the installing node.

##  *site-custom* cart example continued

In the [Adding RPMS](Adding-RPMS) section, we started configuring an *site-custom* cart as an example -- we'll continue to use it here.

To properly have a fortune displayed when a user logs-in, you either have to put "fortune" in their .bashrc (untenable) or make it run automatically. Since /etc/profile.d has environment scripts, we'll put it there.

(Please note, the odds of you allowing users to login into the backends is probably not really a good idea, but for the sake of example, we are assuming this here.)

Go to the *nodes* directory of your cart:

```
# cd /export/stack/carts/site-custom/nodes
```

Edit *cart-site-custom-backend.xml*.

We are most concerned with what goes on between the:

  ```<stack:script stack:stage="install-post"> </stack:script>``` tags.

This runs during the post-install configuration. It maps to the %post stanza in kickstart.

**A ```<stack:file>``` tag must be placed between ```<stack:script>``` tags.**

So in a script tag with the stage set to "install-post" we are going to add a file to the /etc/profile.d directory.

```
<stack:script stack:stage="install-post">

<stack:file stack:name="/etc/profile.d/fortune.sh">
#!/bin/bash
fortune
</stack:file>

</stack:script>
```

This is the default structure for adding a file. If you don't set permissions, default is 644, default owner is root:root. You can set these options though, in the ```<stack:file>``` tag.

### Other options
If you need to make it executable, you can set the permissions:

```
<stack:script stack:stage="install-post">
<stack:file stack:name="/etc/profile.d/fortune.sh" perms="0755">
#!/bin/bash
fortune
</stack:file>
</stack:script>
```

And, if you need to change owner/group:

```
<stack:script stack:stage="install-post">
<stack:file stack:name="/etc/profile.d/fortune.sh" owner="root:apache" perms="0755">
#!/bin/bash
fortune
</stack:file>
</stack:script>
```
(Default perms are 0644, i.e. rw-r--r-- for the numerically challenged.)

If you want to append to a file, for example, to add *fortune* to an already existing profile.d script.

```
<stack:script stack:stage="install-post">
<stack:file stack:name="/etc/profile.d/stack-binaries.sh" mode="append" perms="0755">
fortune
</stack:file>
</stack:script>
```
(You can use all/some/none of those options.)

This will drop the file on the node on the path you've indicated.

Here's a realer (Yes, that's a word. I made it up. It's my word but you can use it.) example:

```
<stack:script stack:stage="install-post">

<stack:file stack:name="/etc/security/limits.d/90-nproc.conf">
# Default limit for number of user's processes to prevent
# accidental fork bombs.
# See rhbz #432903 for reasoning.

*          soft    nproc     64000
</stack:file>

</stack:script>
```

Here is a more complicated example:

```
<stack:script stack:stage="install-post">

<stack:file stack:name="/etc/security/limits.conf">
<![CDATA[
# /etc/security/limits.conf
#
#Each line describes a limit for a user in the form:
#
#<domain>        <type>  <item>  <value>
#
#Where:
#<domain> can be:
#        - an user name
#        - a group name, with @group syntax
#        - the wildcard *, for default entry
#        - the wildcard %, can be also used with %group syntax,
#                 for maxlogin limit
#
#<type> can have the two values:
#        - "soft" for enforcing the soft limits
#        - "hard" for enforcing hard limits
#
#<item> can be one of the following:
#        - core - limits the core file size (KB)
#        - data - max data size (KB)
#        - fsize - maximum filesize (KB)
#        - memlock - max locked-in-memory address space (KB)
#        - nofile - max number of open files
#        - rss - max resident set size (KB)
#        - stack - max stack size (KB)
#        - cpu - max CPU time (MIN)
#        - nproc - max number of processes
#        - as - address space limit (KB)
#        - maxlogins - max number of logins for this user
#        - maxsyslogins - max number of logins on the system
#        - priority - the priority to run user process with
#        - locks - max number of file locks the user can hold
#        - sigpending - max number of pending signals
#        - msgqueue - max memory used by POSIX message queues (bytes)
#        - nice - max nice priority allowed to raise to values: [-20, 19]
#        - rtprio - max realtime priority
#
#<domain>      <type>  <item>         <value>
#

#*               soft    core            0
#*               hard    rss             10000
#@student        hard    nproc           20
#@faculty        soft    nproc           20
#@faculty        hard    nproc           50
#ftp             hard    nproc           0
#@student        -       maxlogins       4
*       soft    nproc   64000
*       hard    nproc   64000
*       soft    nofile  65536
*       hard    nofile  65536
# End of file
mapr - memlock unlimited
mapr - core unlimited
mapr - nofile 32768
mapr - nproc unlimited
mapr - nice -10
mapr - renice -10
]]>
</stack:file>

</stack:script>
```

Note the "&lt;![CDATA[ ]]>" construction. It allows you to run a script or create a config file with special characters (special to the XML parser anyway) without having to work out XML entity issues. Issues that can fubar your kickstart file. Use it if in doubt, and if you have scripts with redirection or init-style scripts, this is a valuable tool to have to use work you've done wholesale.

The CDATA contruction looks like this:

```
<stack:script stack:stage="install-post">
<![CDATA[
whole bunch of stuff I don't want to escape
]]>
</stack:script>
```

We did it for this file because in the comments you'll notice there are &lt;domain&gt;, &lt;item&gt;, and &lt;type&gt; comments. The brackets would otherwise need to be escaped in XML with ```&lt; or &gt;```. But we're lazy because we're good system administrators so just throw it all into the CDATA construction.

We have touched on the surface of what can be done with files in Stacki UXML. Please see [Stacki Universal XML](SUX) for further details.

Adding scripts to enable start-up scripts and modify configuration can also be done during installation. Read [Adding-Scripts](Adding-Scripts) for further detail.
