## Adding networks

An initial installation defaults to having one network defined as "private." This is the network the frontend and the backend machines speak to each other on. Think of it as the "management network" which, apparently, is a thing.

You can have one network. You can have many. You can serve dhcp for multiple subnets or one. Lots of variations, all get configured along a similar theme: spreadsheets or command line.

To use a network on backend nodes, you have to define it on the frontend. Make sure your network infrastructure is connected for any additional networks.

To see how you use a defined network on the frontend for backend nodes, go to the [Backend Network Configuration](Backend-Network-Configuration) docs.

> **Note:** The switch on the "private" network has to be have the ports set to Port Fast or have Spanning Tree off. If you're getting TFTP timeouts, the switch parts are likely not configured correctly.

### Command line

Networks on the command line are easy so I don't always use a spreadsheet. If you have a complicated network topology, a network spreadsheet helps a lot. If you have to replicate network setup across multiple clusters, use a spreadsheet.

Adding a second installation network

```
# stack list network
NETWORK ADDRESS  MASK        GATEWAY   MTU  ZONE  DNS   PXE
private 10.5.0.0 255.255.0.0 10.5.1.10 1500 local False True
```

I have one network, "private" which is the communication network for the backends to the frontend. You got this by default during the installation of the frontend.

Imma gonna add another network which is my "corporate" network.

```
# stack add network corporate address=10.2.0.0 mask=255.255.0.0 gateway=10.2.2.201 pxe=true zone=corporate dns=false
```

Now list:

```
# stack list network
NETWORK    ADDRESS  MASK        GATEWAY      MTU   ZONE       DNS   PXE
private:   10.1.0.0 255.255.0.0 192.168.16.1 1500  local      True  True
corporate: 10.2.0.0 255.255.0.0 10.2.2.201   1500  corporate  False True
```

Machines can now have interfaces on one or both networks.

### Spreadsheet - simple example

Sometimes I'm just lazy and I would rather edit than type out the command for adding a network. So I do this:

```
# stack report networkfile > nets.csv
```

> **Note:** Most of the spreadsheets commands have a "report" that will generate a CSV from the current values in the database.

```
# cat nets.csv
NETWORK,ADDRESS,MASK,GATEWAY,MTU,ZONE,DNS,PXE
private,10.5.0.0,255.255.0.0,10.5.1.10,1500,local,False,True
```

Now I'm just gonna 'vi' into nets.csv and edit it with my "corporate" network information:

```
# vi nets.csv
NETWORK,ADDRESS,MASK,GATEWAY,MTU,ZONE,DNS,PXE
private,10.5.0.0,255.255.0.0,10.5.1.10,1500,local,False,True
```

Copy line:

```
NETWORK,ADDRESS,MASK,GATEWAY,MTU,ZONE,DNS,PXE
private,10.5.0.0,255.255.0.0,10.5.1.10,1500,local,False,True
private,10.5.0.0,255.255.0.0,10.5.1.10,1500,local,False,True
```

Edit line:
```
NETWORK,ADDRESS,MASK,GATEWAY,MTU,ZONE,DNS,PXE
private,10.5.0.0,255.255.0.0,10.5.1.10,1500,local,False,True
corporate,10.2.0.0,255.255.0.0,10.2.2.201,1500,corporate,False,True
```

Save the file and dump it back in:

```
# stack load networkfile file=nets.csv
/export/stack/spreadsheets/RCS/nets.csv,v  <--  /export/stack/spreadsheets/nets.csv
initial revision: 1.1
done
/export/stack/spreadsheets/RCS/nets.csv,v  -->  /export/stack/spreadsheets/nets.csv
revision 1.1 (locked)
done
```

RCS shows me where it's saved and that I'm "done" which is good.

Verify:
```
# stack list network
NETWORK   ADDRESS  MASK        GATEWAY    MTU  ZONE      DNS   PXE
corporate 10.2.0.0 255.255.0.0 10.2.2.201 1500 corporate False True
private   10.5.0.0 255.255.0.0 10.5.1.10  1500 local     False True
```

You'll note that we are answering PXE requests on either network. If we want to have additional interfaces for backend nodes, but are not installing on those interfaces then use the `stack set network pxe "networkname" pxe=False` command.

```stack set network help``` to see other network related commands.

### Spreadsheet - more advanced example.

I have a bunch of networks for the lab cluster. I use this file whenever I put up a new frontend on a VM for testing. It has a little more advanced topology:

This is my networks file:
```
# cat nets.csv
NETWORK,ADDRESS,MASK,GATEWAY,MTU,ZONE,DNS,PXE
ipmi,10.1.2.0,255.255.255.0,10.1.0.100,1500,ipmi,False,False
private,10.5.0.0,255.255.0.0,10.5.1.10,1500,local,True,True
public,192.168.0.0,255.255.0.0,192.168.10.1,1500,jkloud.com,False,False
vland,172.16.20.0,255.255.255.0,172.16.20.1,1500,vland,True,False
```

Observe some things:
* Only vland and private provide DNS.
* My subnets are defined as /16. This is due to the lab network topology.
* I have an ipmi subnet to talk to my BMCs from the frontend network.

I dump it into the database like this:
```
# stack load networkfile file=nets.csv
/export/stack/spreadsheets/RCS/nets.csv,v  <--  /export/stack/spreadsheets/nets.csv
new revision: 1.2; previous revision: 1.1
done
/export/stack/spreadsheets/RCS/nets.csv,v  -->  /export/stack/spreadsheets/nets.csv
revision 1.2 (locked)
done
```

We get the saved message. I can now use these networks on the backend and frontend.


#### Frontend NICs

**tl;dr** for this section:

```
Edit fe.csv to set-up NICs from network file you added.
# stack load hostfile file=fe.csv
# stack report host interface a:frontend | stack report script | bash
# stack report host network a:frontend | stack report script | bash
# stack report host resolv a:frontend  | stack report script  | bash
# systemctl restart network

Or

# reboot
```

This is the **tl** part of the **tl;dr**

I want to take advantage of these networks to set-up my frontend to talk on all of these networks. So I reach for a spreadsheet:

```
NAME,INTERFACE HOSTNAME,DEFAULT,APPLIANCE,RACK,RANK,IP,MAC,INTERFACE,NETWORK,CHANNEL,OPTIONS,VLAN,INSTALLACTION,OSACTION,GROUPS,BOX,COMMENT
stacki-50,stacki-50,,frontend,0,0,10.5.1.1,08:00:27:95:f6:f3,enp0s3,private,,,,default,default,,default,
stacki-50,,True,,,,192.168.5.1,08:00:27:e9:19:1a,enp0s8,public,,,,,,,,
stacki-50,,,,,,10.1.2.100,,enp0s3:1,ipmi,,,,,,,
stacki-50,,,,,,172.16.20.1,,enp0s3:32,vland,,,32,,,,
```

My host is "stacki-50" on a VirtualBox VM. By dumping in this spreadsheet file and then syncing the network, I'll get all my interfaces set-up for the defined network topology.

Pay attention to a few things:
* Only the private NIC has to most of the fields filled out. You can generate this before editing by doing a `# stack report hostfile > fe.csv` to kickstart your CSV file creation process.
* I've set enp0s8 on the public subnet as my "default" interface. This means I can get out to the interwebzz. Usually, the private interface "enp0s3" is the default.
* I have created two virtual interfaces: enp0s3:1 and enp0s3:32 because I want to access my ipmi network on enp0s3:1 and a VLAN that's tagged with id 32.

So lets dump it in:

```
# stack load hostfile file=fe.csv
Loading Spreadsheet
Configuring Database
	Add Host
	Add Host Interface
Setting Bootaction to OS
	       Sync Config
	       	       Sync DNS
	       	       Sync Host
	       	       Sync DHCP
	       	       Sync Host Repo
	       Sync Host Config
	       	       Sync Host Boot
/export/stack/spreadsheets/RCS/fe.csv,v  <--  /export/stack/spreadsheets/fe.csv
new revision: 1.2; previous revision: 1.1
done
/export/stack/spreadsheets/RCS/fe.csv,v  -->  /export/stack/spreadsheets/fe.csv
revision 1.2 (locked)
done
```

We do a lot of checking, valid IPs, valid MACs, to make sure you don't shoot yourself in the foot.

Now I want to activate these NICs. There is a `stack sync host network <hostname>` command, but it only runs on hosts where the attribute "managed" is "True."[^1] For the frontend, this attribute is "False" so syncing the network won't work.

But there is another way. The "sync host network" command is actually a chained series of commands that render XML snippets of kickstart to shell code.

Watch:
```
#  stack report host interface stacki-50
<stack:file stack:name="/etc/sysconfig/network-scripts/ifcfg-enp0s3">
DEVICE=enp0s3
MACADDR=08:00:27:95:f6:f3
IPADDR=10.5.1.1
NETMASK=255.255.0.0
BOOTPROTO=static
ONBOOT=yes
MTU=1500
</stack:file>
<stack:file stack:name="/etc/sysconfig/network-scripts/ifcfg-enp0s3:1">
DEVICE=enp0s3:1
IPADDR=10.1.2.100
NETMASK=255.255.255.0
BOOTPROTO=static
ONBOOT=yes
MTU=1500
</stack:file>
<stack:file stack:name="/etc/sysconfig/network-scripts/ifcfg-enp0s3:32">
DEVICE=enp0s3:32
IPADDR=172.16.20.1
NETMASK=255.255.255.0
BOOTPROTO=static
VLAN=yes
ONBOOT=yes
MTU=1500
</stack:file>
<stack:file stack:name="/etc/sysconfig/network-scripts/ifcfg-enp0s8">
DEVICE=enp0s8
MACADDR=08:00:27:e9:19:1a
IPADDR=192.168.5.1
NETMASK=255.255.0.0
BOOTPROTO=static
ONBOOT=yes
MTU=1500
</stack:file>
<stack:file stack:name="/etc/udev/rules.d/70-persistent-net.rules">
SUBSYSTEM=="net", ACTION=="add", DRIVERS=="?*", ATTR{address}=="08:00:27:95:f6:f3", ATTR{type}=="1", KERNEL=="eth*", NAME="enp0s3"

SUBSYSTEM=="net", ACTION=="add", DRIVERS=="?*", ATTR{address}=="None", ATTR{type}=="1", KERNEL=="eth*", NAME="enp0s3:1"

SUBSYSTEM=="net", ACTION=="add", DRIVERS=="?*", ATTR{address}=="None", ATTR{type}=="1", KERNEL=="eth*", NAME="enp0s3:32"

SUBSYSTEM=="net", ACTION=="add", DRIVERS=="?*", ATTR{address}=="08:00:27:e9:19:1a", ATTR{type}=="1", KERNEL=="eth*", NAME="enp0s8"


</stack:file>
```
That's a kickstart snippet. Let's make it shell:

```
#  stack report host interface stacki-50 | stack report script
#! /bin/bash

DO_PACKAGES=1
DO_INSTALL_POST=1
DO_BOOT_PRE=0
DO_BOOT_POST=1


function stack_install_post_1 {
if [ ! -e /etc/sysconfig/network-scripts ]; then mkdir -p /etc/sysconfig/network-scripts; fi

if [ -e /opt/stack/bin/rcs ]; then
	if [ ! -f /etc/sysconfig/network-scripts/RCS/ifcfg-enp0s3,v ]; then
		if [ ! -f /etc/sysconfig/network-scripts/ifcfg-enp0s3 ]; then
			touch /etc/sysconfig/network-scripts/ifcfg-enp0s3
		fi
		if [ ! -d /etc/sysconfig/network-scripts/RCS ]; then
			mkdir -m 700 /etc/sysconfig/network-scripts/RCS
			chown 0:0 /etc/sysconfig/network-scripts/RCS
		fi
		echo "original" | /opt/stack/bin/ci -q /etc/sysconfig/network-scripts/ifcfg-enp0s3
		/opt/stack/bin/rcs -noriginal: /etc/sysconfig/network-scripts/ifcfg-enp0s3
		/opt/stack/bin/co -q -f -l /etc/sysconfig/network-scripts/ifcfg-enp0s3
	fi
fi
cat > /etc/sysconfig/network-scripts/ifcfg-enp0s3 << 'EOF'
DEVICE=enp0s3
MACADDR=08:00:27:95:f6:f3
IPADDR=10.5.1.1
NETMASK=255.255.0.0
BOOTPROTO=static
ONBOOT=yes
MTU=1500
EOF

if [ ! -e /etc/sysconfig/network-scripts ]; then mkdir -p /etc/sysconfig/network-scripts; fi

if [ -e /opt/stack/bin/rcs ]; then
	if [ ! -f /etc/sysconfig/network-scripts/RCS/ifcfg-enp0s3:1,v ]; then
		if [ ! -f /etc/sysconfig/network-scripts/ifcfg-enp0s3:1 ]; then
			touch /etc/sysconfig/network-scripts/ifcfg-enp0s3:1
		fi
		if [ ! -d /etc/sysconfig/network-scripts/RCS ]; then
			mkdir -m 700 /etc/sysconfig/network-scripts/RCS
			chown 0:0 /etc/sysconfig/network-scripts/RCS
		fi
		echo "original" | /opt/stack/bin/ci -q /etc/sysconfig/network-scripts/ifcfg-enp0s3:1
		/opt/stack/bin/rcs -noriginal: /etc/sysconfig/network-scripts/ifcfg-enp0s3:1
		/opt/stack/bin/co -q -f -l /etc/sysconfig/network-scripts/ifcfg-enp0s3:1
	fi
fi
cat > /etc/sysconfig/network-scripts/ifcfg-enp0s3:1 << 'EOF'
DEVICE=enp0s3:1
IPADDR=10.1.2.100
NETMASK=255.255.255.0
BOOTPROTO=static
ONBOOT=yes
MTU=1500
EOF

if [ ! -e /etc/sysconfig/network-scripts ]; then mkdir -p /etc/sysconfig/network-scripts; fi

if [ -e /opt/stack/bin/rcs ]; then
	if [ ! -f /etc/sysconfig/network-scripts/RCS/ifcfg-enp0s3:32,v ]; then
		if [ ! -f /etc/sysconfig/network-scripts/ifcfg-enp0s3:32 ]; then
			touch /etc/sysconfig/network-scripts/ifcfg-enp0s3:32
		fi
		if [ ! -d /etc/sysconfig/network-scripts/RCS ]; then
			mkdir -m 700 /etc/sysconfig/network-scripts/RCS
			chown 0:0 /etc/sysconfig/network-scripts/RCS
		fi
		echo "original" | /opt/stack/bin/ci -q /etc/sysconfig/network-scripts/ifcfg-enp0s3:32
		/opt/stack/bin/rcs -noriginal: /etc/sysconfig/network-scripts/ifcfg-enp0s3:32
		/opt/stack/bin/co -q -f -l /etc/sysconfig/network-scripts/ifcfg-enp0s3:32
	fi
fi
cat > /etc/sysconfig/network-scripts/ifcfg-enp0s3:32 << 'EOF'
DEVICE=enp0s3:32
IPADDR=172.16.20.1
NETMASK=255.255.255.0
BOOTPROTO=static
VLAN=yes
ONBOOT=yes
MTU=1500
EOF

if [ ! -e /etc/sysconfig/network-scripts ]; then mkdir -p /etc/sysconfig/network-scripts; fi

if [ -e /opt/stack/bin/rcs ]; then
	if [ ! -f /etc/sysconfig/network-scripts/RCS/ifcfg-enp0s8,v ]; then
		if [ ! -f /etc/sysconfig/network-scripts/ifcfg-enp0s8 ]; then
			touch /etc/sysconfig/network-scripts/ifcfg-enp0s8
		fi
		if [ ! -d /etc/sysconfig/network-scripts/RCS ]; then
			mkdir -m 700 /etc/sysconfig/network-scripts/RCS
			chown 0:0 /etc/sysconfig/network-scripts/RCS
		fi
		echo "original" | /opt/stack/bin/ci -q /etc/sysconfig/network-scripts/ifcfg-enp0s8
		/opt/stack/bin/rcs -noriginal: /etc/sysconfig/network-scripts/ifcfg-enp0s8
		/opt/stack/bin/co -q -f -l /etc/sysconfig/network-scripts/ifcfg-enp0s8
	fi
fi
cat > /etc/sysconfig/network-scripts/ifcfg-enp0s8 << 'EOF'
DEVICE=enp0s8
MACADDR=08:00:27:e9:19:1a
IPADDR=192.168.5.1
NETMASK=255.255.0.0
BOOTPROTO=static
ONBOOT=yes
MTU=1500
EOF

if [ ! -e /etc/udev/rules.d ]; then mkdir -p /etc/udev/rules.d; fi

if [ -e /opt/stack/bin/rcs ]; then
	if [ ! -f /etc/udev/rules.d/RCS/70-persistent-net.rules,v ]; then
		if [ ! -f /etc/udev/rules.d/70-persistent-net.rules ]; then
			touch /etc/udev/rules.d/70-persistent-net.rules
		fi
		if [ ! -d /etc/udev/rules.d/RCS ]; then
			mkdir -m 700 /etc/udev/rules.d/RCS
			chown 0:0 /etc/udev/rules.d/RCS
		fi
		echo "original" | /opt/stack/bin/ci -q /etc/udev/rules.d/70-persistent-net.rules
		/opt/stack/bin/rcs -noriginal: /etc/udev/rules.d/70-persistent-net.rules
		/opt/stack/bin/co -q -f -l /etc/udev/rules.d/70-persistent-net.rules
	fi
fi
cat > /etc/udev/rules.d/70-persistent-net.rules << 'EOF'
SUBSYSTEM=="net", ACTION=="add", DRIVERS=="?*", ATTR{address}=="08:00:27:95:f6:f3", ATTR{type}=="1", KERNEL=="eth*", NAME="enp0s3"

SUBSYSTEM=="net", ACTION=="add", DRIVERS=="?*", ATTR{address}=="None", ATTR{type}=="1", KERNEL=="eth*", NAME="enp0s3:1"

SUBSYSTEM=="net", ACTION=="add", DRIVERS=="?*", ATTR{address}=="None", ATTR{type}=="1", KERNEL=="eth*", NAME="enp0s3:32"

SUBSYSTEM=="net", ACTION=="add", DRIVERS=="?*", ATTR{address}=="08:00:27:e9:19:1a", ATTR{type}=="1", KERNEL=="eth*", NAME="enp0s8"


EOF
}


function stack_boot_pre_rcsEnd {
if [ -e /opt/stack/bin/rcs ]; then
	if [ -f /etc/sysconfig/network-scripts/ifcfg-enp0s3 ]; then
		echo "stack" | /opt/stack/bin/ci -q /etc/sysconfig/network-scripts/ifcfg-enp0s3
		/opt/stack/bin/rcs -Nstack: /etc/sysconfig/network-scripts/ifcfg-enp0s3
		/opt/stack/bin/co -q -f -l /etc/sysconfig/network-scripts/ifcfg-enp0s3
	fi
fi


if [ -e /opt/stack/bin/rcs ]; then
	if [ -f /etc/sysconfig/network-scripts/ifcfg-enp0s3:1 ]; then
		echo "stack" | /opt/stack/bin/ci -q /etc/sysconfig/network-scripts/ifcfg-enp0s3:1
		/opt/stack/bin/rcs -Nstack: /etc/sysconfig/network-scripts/ifcfg-enp0s3:1
		/opt/stack/bin/co -q -f -l /etc/sysconfig/network-scripts/ifcfg-enp0s3:1
	fi
fi


if [ -e /opt/stack/bin/rcs ]; then
	if [ -f /etc/sysconfig/network-scripts/ifcfg-enp0s3:32 ]; then
		echo "stack" | /opt/stack/bin/ci -q /etc/sysconfig/network-scripts/ifcfg-enp0s3:32
		/opt/stack/bin/rcs -Nstack: /etc/sysconfig/network-scripts/ifcfg-enp0s3:32
		/opt/stack/bin/co -q -f -l /etc/sysconfig/network-scripts/ifcfg-enp0s3:32
	fi
fi


if [ -e /opt/stack/bin/rcs ]; then
	if [ -f /etc/sysconfig/network-scripts/ifcfg-enp0s8 ]; then
		echo "stack" | /opt/stack/bin/ci -q /etc/sysconfig/network-scripts/ifcfg-enp0s8
		/opt/stack/bin/rcs -Nstack: /etc/sysconfig/network-scripts/ifcfg-enp0s8
		/opt/stack/bin/co -q -f -l /etc/sysconfig/network-scripts/ifcfg-enp0s8
	fi
fi


if [ -e /opt/stack/bin/rcs ]; then
	if [ -f /etc/udev/rules.d/70-persistent-net.rules ]; then
		echo "stack" | /opt/stack/bin/ci -q /etc/udev/rules.d/70-persistent-net.rules
		/opt/stack/bin/rcs -Nstack: /etc/udev/rules.d/70-persistent-net.rules
		/opt/stack/bin/co -q -f -l /etc/udev/rules.d/70-persistent-net.rules
	fi
fi
}


if [ $DO_INSTALL_POST -eq 1 ]; then
	stack_install_post_1
fi

if [ $DO_BOOT_PRE -eq 1 ]; then
	stack_boot_pre_rcsEnd
fi
```

Now let's actually run it and restart the network:

```
#  stack report host interface stacki-50 | stack report script | bash
RCS file: /etc/sysconfig/network-scripts/RCS/ifcfg-enp0s3:1,v
done
RCS file: /etc/sysconfig/network-scripts/RCS/ifcfg-enp0s3:32,v
done

# systemctl restart network
```

Which should give us:

```
# ifconfig | grep en
enp0s3: flags=4163<UP,BROADCAST,RUNNING,MULTICAST>  mtu 1500
        inet6 fe80::a00:27ff:fe95:f6f3  prefixlen 64  scopeid 0x20<link>
        ether 08:00:27:95:f6:f3  txqueuelen 1000  (Ethernet)
enp0s3:1: flags=4163<UP,BROADCAST,RUNNING,MULTICAST>  mtu 1500
        ether 08:00:27:95:f6:f3  txqueuelen 1000  (Ethernet)
enp0s3:32: flags=4163<UP,BROADCAST,RUNNING,MULTICAST>  mtu 1500
        ether 08:00:27:95:f6:f3  txqueuelen 1000  (Ethernet)
enp0s8: flags=4163<UP,BROADCAST,RUNNING,MULTICAST>  mtu 1500
        inet6 fe80::a00:27ff:fee9:191a  prefixlen 64  scopeid 0x20<link>
        ether 08:00:27:e9:19:1a  txqueuelen 1000  (Ethernet)
        inet6 ::1  prefixlen 128  scopeid 0x10<host>
        loop  txqueuelen 1  (Local Loopback)
```

You'll also have to do the network for the frontend:

```
# stack report host network a:frontend
<stack:file stack:name="/etc/sysconfig/network">
NETWORKING=yes
HOSTNAME=stacki-50.jkloud.com
GATEWAY=192.168.10.1
</stack:file>
<stack:file stack:name="/etc/hostname">
stacki-50.jkloud.com
</stack:file>
```

And the resolv:

```
[root@stacki-50 ~]# stack report host resolv a:frontend
<stack:file stack:name="/etc/resolv.conf">
search jkloud.com ipmi local vland
nameserver 10.5.1.1
nameserver 10.5.1.1
nameserver 8.8.8.8
</stack:file>
```

But do it for real:

```
# stack report host network a:frontend | stack report script | bash
# stack report host resolv a:frontend | stack report script | bash
# systemctl restart network

Or

# reboot
```

Our frontend should now be able to communicate will all these networks.

Syncing the network configuration on backend nodes is much simpler.

In [Backend Network Configuration](Network-Configuration-Backend) we'll extend this example to include backend network set-up.

[^1]: For further discussion of attributes, please see [Using Attributes](Using-Attributes)
