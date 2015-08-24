Our assumption is that when a machine comes up, it should be exactly the way you want at first boot. This way you're certain your stuff is going to run once you hit the install/reinstall button because you've already done the hard configuration scripting to make it so. 

Which means you probably don't want to recreate all of that work just because you've started using a new tool. You've already figured it out, you don't want to do it again, and you probably can't remember why you do some of the things you do in those scripts. We'll discuss how to use extend-backend.xml to:
* Not lose work you've already done.
* Put your already existing config files or scripts where they belong: on the installing node.

The scope of this document uses the extend-backend.xml to create your customizations. There are more complicated ways to do this that lead to shorter xml, and subsequently less complex looking, kickstart files. If you want details on that, email the list, and we'll be happy to document. 

We'll deal with two types of files: configuration files and scripts that have to run.

##### Configuration files

% Go to the site-profiles directory
```
# cd /export/stack/site-profiles/default/1.0/nodes/
```

% Create extend-backend.xml
If you don't already have an extend-backend.xml file, create one:
```
# cp skeleton.xml extend-backend.xml
```
Feel free to remove all the commenting. I do. It drives me crazy.

We are most concerned with what goes on between \<post>\</post> tags. Remember, this runs during the post-install configuration. It maps to the %post stanza in kickstart.

So in post tags:
```
<post>

<file name="/full/path/of/file.conf">
These are the contents of my file
</file>

</post>
```

% But if I need to make it executable I'll set the permissions:
```
<post>
<file name="/full/path/of/file.conf" perms="0755">
Contents
</file>
</post>
```
% If I need to change owner/group:
```
<post>
<file name="/full/path/of/file.conf" perms="0660" owner="bob:jobob">
Contents
</file>
</post>
```
(Default perms are 0644, i.e. rw-r--r-- for the numerically challenged.)

% If I want to append to a file: 
```
<post>
<file name="/full/path/of/file.conf" perms="0400" owner="bob:jobob" mode="append">
Contents
</file>
</post>
```
(You can use all/some/none of those options.)

This will drop the file on the node on the path you've indicated.

##### Scripts

There are two ways to add/run scripts:
* Adding them in a file and then running them
* Running them in a \<post>\</post> tags.

Adding scripts is pretty much the same thing. Add the contents of the script to a file, and then call the script during install or at first boot depending on what applications have to be running when it's called.

###### Add a script to be run

```
<post>
<file name="/full/path/of/script/dothis.sh" perms="755">
#!/bin/bash
Run a long bash script.
</file>

/full/path/of/script/dothis.sh
</post>
```

Oh yeah, you might need a "mkdir -p /full/path/of/script" before you can put the file in the directory. 

```
<post>
mkdir -p /full/path/of/sccript

<file name="/full/path/of/script/dothis.sh" perms="755">
#!/bin/bash
Run a long bash script.
</file>

/full/path/of/script/dothis.sh
</post>
```

% If you want to log output to a file:
```
<post>
/full/path/of/script/dothis.sh &gt; /root/joebob.log
</post>
```
Notice the &gt;. The >, <, and & are not interpreted by the xml parser so to use them in kickstart file you need to use the entities: &gt; &lt; &amp;

But what if you have a big script that has a bunch of characters that don't escape easily?

You can use the <![CDATA[ construction to bypass having to escape anything.

Like this example:

```
<post>

mkdir -p /etc/cron.hourly

<file name="/etc/cron.hourly/ntp" perms="0755">
<![CDATA[#!/bin/sh

/usr/sbin/ntpq -pn 2> /dev/null | grep '^\*' > /dev/null

if [ $? -eq 0 ]; then
        svcadm restart network/ntp > /dev/null 2>&1
fi
]]>
</file>
</post>
```

If your scripts need full network and services, then you can run them at first boot:

after all your <post></post> tags you can do:

<boot order="post">
/full/path/of/script/or/file.sh
</boot>

The output of that will be in /root/rocks-post.log after an install. 

Let's say we have an application called "killerapp." It comes in an RPM that I've added to the contrib directory, and I'm adding it in package tags. There's a config file for it call /etc/killerapp/killerapp.conf, and I want to create my config file for it:

There is another thing you can do and I worked with someone today. He had a a script that was bash executable zippy thingy, so script plus payload. Due to versioning issues (frontend installed with os, backends with older Oracle linux) doing a "stack create package" to make an rpm out of them wasn't going to work. (Right, and then you're going to ask me how to do that. I'll answer that if you've actually read this far and ask me that question.) 

So we just dumped the actual scripts in contrib.

# cp myscript.sh /export/stack/contrib/default/1.0/x86_64/RPMS/

Dirty secret is that this can be gotten from the frontend during the install even though it's not an RPM. So yeah, accidentally awesome. 

<post>
cd /tmp
wget http://&Kickstart_PrivateAddress;/install/distributions/default/x86_64/RedHat/RPMS/myscript.sh

chmod 755 /tmp/myscript.sh
/tmp/myscript.sh
</post>