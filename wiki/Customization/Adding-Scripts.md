### Adding configuration scripts to carts

Whatever you can do in a shell, you can do during install.

Our assumption is that when a machine comes up, it should be exactly the way you want at first boot. This way you're certain your stuff is going to run once you hit the install/reinstall button because you've already done the hard configuration scripting to make it so.

Which means you probably don't want to recreate all of that work just because you've started using a new tool. You've already figured it out, you don't want to do it again, and you probably can't remember why you do some of the things you do in those scripts. We'll discuss how to modify a cart to:
* Not lose work you've already done.
* Put your already existing config files or scripts where they belong: on the installing node.

We'll deal with two types of files: configuration files and scripts that have to run.

##### Configuration files




### Apache example continued.

In the [Adding RPMS](Adding-RPMS) section, we started configuring an*apache* cart as an example -- we'll continue to use it here.

Go to the *nodes* directory of your cart:

```
# cd /export/stack/carts/apache/nodes
```

Edit *cart-apache-backend.xml*.

We are most concerned with what goes on between the:

  ```<stack:script stack:stage="install-post"> </stack:script>``` tags.

Remember, this runs during the post-install configuration. It maps to the %post stanza in kickstart.

So in a script tag with the stage set to "install-post" we are going to add a file to the /etc/httpd/conf.d/http.conf file.

```
<stack:script stack:stage="install-post">

<stack:file stack:name="/etc/httpd/conf.d/site-http.conf">

</stack:file>

</stack:script>
```


### Other options
But if you need to make it executable, you can set the permissions:

```
<post>
<file name="/full/path/of/file.conf" perms="0755">
Contents
</file>
</post>
```

And, if you need to change owner/group:

```
<post>
<file name="/full/path/of/file.conf" perms="0660" owner="bob:jobob">
Contents
</file>
</post>
```

(Default perms are 0644, i.e. rw-r--r-- for the numerically challenged.)

If you want to append to a file:

```
<post>
<file name="/full/path/of/file.conf" perms="0400" owner="bob:jobob" mode="append">
Contents
</file>
</post>
```
(You can use all/some/none of those options.)

This will drop the file on the node on the path you've indicated.

Here's a real example:

```
<post>
<file name="/etc/security/limits.d/90-nproc.conf">
# Default limit for number of user's processes to prevent
# accidental fork bombs.
# See rhbz #432903 for reasoning.

*          soft    nproc     64000
</file>
</post>
```

Ok, back to the *file* tag -- here is a more complicated example:

```
<post>
<file name="/etc/security/limits.conf">
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
</file>
</post>
````

Note the "&lt;![CDATA[ ]]>" construction. It allows you to run a script or create a config file with special characters (special to the XML parser anyway) without having to work out XML entity issues. Issues that can fubar your kickstart file. Use it if in doubt, and if you have scripts with redirection or init-style scripts, this is a valuable tool to have to use work you've done wholesale.

The CDATA contruction looks like this:

```
<post>
<![CDATA[
whole bunch of stuff I don't want to escape
]]>
</post>
```

##### Scripts

Scripts are similar to config files, except you might want to run them during installation or after first boot.

There are two ways to add/run scripts:
* Adding them in a file and then running them
* Running them in a `<post> </post>` tags.

##### Add a script to be run

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
mkdir -p /full/path/of/script

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

Notice the \&gt;. The >, <, and & are not interpreted by the XML parser so to use them in kickstart file you need to use the entities: \&gt; \&lt; \&amp;

But what if you have a big script that has a bunch of characters that don't escape easily?

Again you can use the <![CDATA[ ]]> construction to bypass having to escape anything.

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

This is a more complex example. Note that only the script part of sethadoopenv.sh is contained in the <![CDATA[ ]]> construction.

```
<post cond="has_mapr">
<file name="/etc/profile.d/sethadoopenv.sh">
export HADOOP_HOME=/opt/mapr/hadoop/hadoop-0.20.2
export SQOOP_HOME=/opt/mapr/sqoop/sqoop-1.4.4
export MAHOUT_HOME=/opt/mapr/mahout/mahout-0.8
export HBASE_HOME=/opt/mapr/hbase/hbase-0.94.9
export HIVE_HOME=/opt/mapr/hive/hive-0.11
export PIG_HOME=/opt/mapr/pig/pig-0.11
export PIG_CLASSPATH=$HADOOP_HOME/conf
export PATH=$PATH:$HADOOP_HOME/bin:$MAHOUT_HOME/bin:$SQOOP_HOME/bin:$HBASE_HOME/bin:$HIVE_HOME/bin:$PIG_HOME/bin
export CLASSPATH=$HADOOP_HOME/conf
export PIG_OPTS="-Dhbase.zookeeper.property.clientPort=5181 -Dhbase.zookeeper.quorum=&mapr.zookeeper.servers;"
<![CDATA[
LOGNAME=`whoami`
if [ $LOGNAME == root ]
then
        break
else
        if [[ -f ~/.my_queue && `cat ~/.my_queue | grep [a-z] |wc -l` -gt 0 ]] &&  [[ $(echo  "`date +%s` - `stat -L --format %Y ~/.my_queue`" | bc) -lt 86400 ]];
        then
                export MY_QUEUE=`cat ~/.my_queue`;
                echo -e "\n Using Existing Queue Info";
        else
                `$HADOOP_HOME/bin/hadoop queue -showacls 2> /dev/null | grep -v "default" | grep submit-job | awk '{print $1}' | head -1 > ~/.my_queue`;
                export MY_QUEUE=`cat ~/.my_queue`;
                echo -e "\n Creating Queue Info";
        fi
        if [ "`echo ${MY_QUEUE:-null}`" == "null" ];then
                echo -e "\n ! Error : Unable to set MY_QUEUE; Please check if you are a member of any queue other than \"default\"";
        else
                echo -e "\n Defined MY_QUEUE=$MY_QUEUE\n";
        fi
fi
]]>
</file>
</post>
```

Also note, the cond="has_mapr" in the opening post tag of the example. I've defined an attribute (key-value pair) called "has_mapr" as True. If a machine has this attribute set to True, then the script will be put on the machine. If it doesn't have "has_mapr" set to true, then this doesn't make it into the XML.

If your scripts need full network and services, then you can run them at first boot:

after all your `<post> </post>` tags you can do:
```
<boot order="post">
/full/path/of/script/dothis.sh
</boot>
```
The output of that will be in /root/rocks-post.log after an install.

Here is an example where we call a legacy script from Cobbler.

```
<boot order="post">
cd /opt/cobbler/config_ldap_mysite/
./main.sh
</boot>
```

**Remember**: `<boot> </boot>` go after all `<post> </post>` tags. Not in-between them.

##### Run a script in the `<post> </post>` tags.

Really whenever you create a set of `<post> </post>` tags, you're running with the bash interpreter. You can do more difficult scripts during installation by switching interpreters, python, perl, ksh, csh, tcsh, javascript,ruby,on and on and on.

Do it like this:

```
<post interpreter="/usr/bin/python">
import os

tlvs = ["portDesc", "sysName", "sysDesc", "sysCap",
	"mngAddr", "macPhyCfg", "powerMdi", "linkAgg",
	"MTU", "LLDP-MED", "medCap", "medPolicy",
	"medLoc", "medPower", "medHwRev", "medFwRev",
	"medSwRev", "medSerNum", "medManuf", "medModel",
	"medAssetID", "CIN-DCBX", "CEE-DCBX", "evbCfg",
	"vdp", "IEEE-DCBX", "ETS-CFG", "ETS-REC",
	"PFC", "APP", "PVID", "PPVID", "vlanName",
	"ProtoID", "vidUsage", "mgmtVID", "linkAggr", "uPoE"]

lldp='/usr/sbin/lldptool'

def setLLDP(iface):
	os.system("%s -L -i %s adminStatus=rxtx" % (lldp,iface))
	os.system("%s -i %s -T -V chassisID " % (lldp,iface) +
		"subtype=CHASSIS_ID_NETWORK_ADDRESS")
	for tlv in tlvs:
		cmd = "%s -T -i %s -V %s " % (lldp,iface,tlv)
		cmd += "-c enableTx=yes &gt;&gt; /root/lldp.log 2&gt;&amp;1"
		os.system(cmd)

ifaces = os.listdir("/sys/class/net")
ifaces.remove('lo')
for iface in ifaces:
	setLLDP(iface)
</post>
```

I'm setting up lldp, and I want to initialize the interfaces. I don't know what capabilities they have, so I'm just going to enable everything and whatever happens, happens. I could be more exact about this if I really wanted to. I'm using the 'interpreter="/usr/bin/python"' to tell the post tag to use python.

It's the equivalent of this:
```
#!/usr/bin/python
```

in a regular python script. So if you have perl scripts you've written or someone else has, use a perl interpreter line, and put the script in-between ```<post> </post>``` tags.

### Further Reading

We have touched the surface of what you can do to configure backend machines. See the [Stacki Universal XML](SUX) documentation for a more complete listing of cart XML syntax. There are further examples at someplace to be named.
