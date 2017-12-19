### Adding Configuration Scripts to Carts

Whatever you can do in Linux, you can do in a Cart across all your installs.

When a machine comes up, it should be exactly the way you want at first boot. Stacki should be used to bring machines to a known state. One of the ways to do that is run the scripts and start the services that need to be available during the install. It's part of the secret to scaling: offload as much work to the individual machines themselves.

#### Scripts

Scripts are similar to config files, except you might want to run them during installation or after first boot.

There are two ways to add/run scripts:
* Adding them in a file and then running them
* Running them in a `<stack:script> </stack:script>` tags.

##### Starting/enabling services

In CentOS/RHEL 7.x and SLES 12, systemd is the init script runner. If a service runs as a daemon, these can be enabled during installation and will start on first boot.

For example: Let's say we want to run a web-farm and httpd needs to be started on every machine. Let's make sure httpd is installed and gets started on every machine in our *site-custom* cart.


```
<stack:stack:

<!-- add httpd -->
<stack:package>httpd</stack:package>

<!-- enable httpd will autostart on first boot -->
<stack:script stack:stage="install-post">
systemctl enable httpd
</stack:script>

</stack:stack>
```

##### Add a script to be run during install.

You can run scripts to take care of configuration during the install phase.

They can be run as straight shell code or you can put them in a file and then run the file.

Let's say I want to add some administrative users and allow them to sudo without a tty.

```
<stack:script stack:stage="install-post">
<!-- just add them -->
groupadd -g 405 siteadmin
useradd -u 405 -g 405 siteadmin someperson1
useradd -u 406 -g 405 siteadmin someperson1

sed -i /"Defaults    requiretty"/\c"#Defaults    requiretty" /etc/sudoers

echo "%siteadmin ALL=(ALL) NOPASSWD: ALL" &gt; /etc/sudoers.d/siteadmin

</stack:script>
```

This just runs in bash in order. I could do this another way by adding it to a script in a stack:file tags and running the script:

```
<stack:script stack:stage="install-post">

<stack:file name="/tmp/addadmins.sh" perms="0755">
groupadd -g 405 siteadmin
useradd -u 405 -g 405 siteadmin someperson1
useradd -u 406 -g 405 siteadmin someperson1

sed -i /"Defaults    requiretty"/\c"#Defaults    requiretty" /etc/sudoers
</stack:file>

/tmp/addadmins.sh

<stack:file name="/etc/sudoers.d/siteadmin"
%siteadmin ALL=(ALL) NOPASSWD: ALL
</stack:admin>

</stack:script>
```

So we put the code of adding admins into /tmp/addadmins.sh with executable permissions and then we run it. I also pulled the "echo" into a file into file tags. That is more Stacki idiomatic.

If a file or directory does not exist in a file tag, the directory and the file will be created without having to do additional "mkdirs"


If your scripts need full network and services, then you can run them at first boot. Still using ```<stack:script>``` tags but changing the ```stack:stage``` in that tag.

```
<stack:script stack:stage="boot-post">
echo "Finished `date +'%H:%M %d-%b-%Y'`" &gt;&gt; /etc/motd
echo "finis=`date +'%s'`" &gt;&gt; /tmp/time.sh

<stack:file stack:name="/tmp/time.sh" stack:mode="append" stack:perms="755">
installed=`echo "$(((finis - built)/60))"`
echo "Installed in ${installed} minutes" &gt;&gt; /etc/motd
</stack:file>

/tmp/time.sh
</stack:script>
```

This script runs during first-boot *after* all the network and other services are up.

Note a few things:
* The "stack:stage" is now "boot-post" rather than "install-post"
* There is a mix of shell commands plus adding a file to be run.
* Echo some things into /etc/motd. Note the "date" commands, it's just shell.
* Append to a time.sh script that will do some math for me.
* Run the file.

This produces output that tell me how long it takes to install a backend node. This mix and matching of tags, tell the installer how to behave.

##### Run a different shell interpreter

Really whenever you create a set of `<stack:script>` tags, you're running with the bash interpreter. You can do more difficult scripts during installation by switching interpreters, python, perl, ksh, csh, tcsh, javascript,ruby,on and on and on.

Do it like this:

```
<stack:script stack:interpreter="/usr/bin/python">
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
</stack:script>
```

I'm setting up lldp, and I want to initialize the interfaces. I don't know what capabilities they have, so I'm just going to enable everything and whatever happens, happens. I could be more exact about this if I really wanted to. I'm using the 'interpreter="/usr/bin/python"' to tell the post tag to use python.

It's the equivalent of a shebang at the beginning of a python script file.
```
#!/usr/bin/python
```

So if you have perl scripts you've written or someone else has, use a perl interpreter line, and put the script in-between ```<stack:script>``` tags with `<stack:interpreter=/path/to/perl>```.

### Further Reading

We have touched the surface of what you can do to configure backend machines. See the [Stacki Universal XML](SUX) documentation for a more complete listing of Stacki UXML syntax. 
