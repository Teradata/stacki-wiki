## Install nodes via spreadsheet

### Things to check
1. Node network cables are plugged in.
2. Nodes are cabled to the same network as the frontend _private_ interface.
3. Nodes are set to PXE first.
4. Nodes have a system disk.
5. Node is not a laptop.  

### Spreadsheet

You can specify all the information about a host before installation in a CSV (Comma Separated Value) file.
The advantage of using CSV files, is that it gives fine-grained control over the configuration of the cluster. You also don't piss-off your networking and security teams.

The disadvantage is you have to know the MAC addresses prior to installing backend nodes. If you didn't get a listing from the vendor, you'll have to harvest them with IPMI or use your, or someone else's, eyeballs.

The Host CSV file needs to have the following columns:
**Please Note:** Headings have changed since 4.0. This is for 5.0.

1. **Name**: A hostname. (Required)
1. **Interface Hostname**:
1. **Default**: True for interface to be the default gateway/route.
1. **Appliance**. The appliance name for the host (e.g. backend).
1. **Rack**. The rack number for the host.
1. **Rank**. The position in the rack for the host.
1. **IP**. Network address.
1. **MAC**. Ethernet address.
1. **Interface**. Ethernet device name (e.g. em1).
1. **Network**. Network name for the interface (e.g. private).
1. **Channel**: For bonding
1. **Options**: For additional network options in ifcfg files (i.e. bonding)
1. **VLAN**: Vlan id.
1. **Installaction**. Defaults to "default" mapped to a bootaction in "stack list bootaction" - Replaces "RUNACTION"
1. **Osaction**: Defaults to "default"
1. **Groups**: Ad hoc collections of hosts.
1. **Box**: Default box is "default" See [Boxes](Boxes)
1. **Comment**: Communicate with your friends!

A simple, basic spreadsheet is shown below.

    NAME,INTERFACE HOSTNAME,DEFAULT,APPLIANCE,RACK,RANK,IP,MAC,INTERFACE,NETWORK,CHANNEL,OPTIONS,VLAN,INSTALLACTION,OSACTION,GROUPS,BOX,COMMENT
    backend-0-0,backend-0-0,True,backend,0,0,10.11.1.254,c8:1f:66:cb:e7:43,em1,private,,,,default,default,,default,
    backend-0-1,backend-0-1,True,backend,0,1,10.11.1.253,c8:1f:66:cb:33:74,em1,private,,,,default,default,,default,
    backend-0-2,backend-0-2,True,backend,0,2,10.11.1.252,c8:1f:66:cb:e5:7d,em1,private,,,,default,default,,default,
    backend-0-3,backend-0-3,True,backend,0,3,10.11.1.251,c8:1f:66:cb:37:75,em1,private,,,,default,default,,default,
    backend-0-4,backend-0-4,True,backend,0,4,10.11.1.250,c8:1f:66:cd:d3:c0,em1,private,,,,default,default,,default,

Once the CSV file is created and copied to the frontend it can be
loaded by root.

```
# stack load hostfile file=hostfile.csv
```

You can verify the data was correctly loaded be listing the host
information from the configuration database.

```
HOST        RACK RANK APPLIANCE OS     BOX     ENVIRONMENT OSACTION INSTALLACTION STATUS COMMENT
centos      0    0    frontend  redhat default ----------- default  default       up
backend-0-0 0    0    backend   redhat default ----------- default  default       ------
backend-0-1 0    1    backend   redhat default ----------- default  default       ------
backend-0-2 0    2    backend   redhat default ----------- default  default       ------
backend-0-3 0    3    backend   redhat default ----------- default  default       ------
backend-0-4 0    4    backend   redhat default ----------- default  default       ------
```

By default number of CPUs on every backend node is set to 1.
This value will be updated automatically once a backend node
is installed.

Every time a backend node boots, it will send a PXE request to the
frontend. The frontend will tell the backend node to either boot its OS or to
install. The default boot action is always _os_ as you can see below.

```
# stack list host boot
HOST        ACTION NUKEDISKS NUKECONTROLLER
centos      ------ False     False
backend-0-0 os     False     False
backend-0-1 os     False     False
backend-0-2 os     False     False
backend-0-3 os     False     False
backend-0-4 os     False     False
```

In order to install a backend you will need to switch the boot action
to _install_ and then reboot.

```
# stack set host boot a:backend action=install
	       Sync Host Boot
```

```
# stack list host boot
HOST        ACTION  NUKEDISKS NUKECONTROLLER
centos      ------- False     False
backend-0-0 install False     False
backend-0-1 install False     False
backend-0-2 install False     False
backend-0-3 install False     False
backend-0-4 install False     False
```

The very first install, you must set "nukedisks" to true. This is no brownfield installer. We want complete control - including partitioning which is [another discussion](Partitioning)

```
# stack set host attr a:backend attr=nukedisks value=True
```
Verify:

```
# stack list host boot
HOST        ACTION  NUKEDISKS NUKECONTROLLER
centos      ------- False     False
backend-0-0 install True      False
backend-0-1 install True      False
backend-0-2 install True      False
backend-0-3 install True      False
backend-0-4 install True      False
```

**Note:** You do NOT have to set "nukecontroller" at this point, especially if you are happy with the current hardware RAID controller configuration or your machines don't have hardware RAID controllers in the LSI family. If these machines are brand new, have LSI controllers, and you want to set them up, look at the [Storage Controller](Storage-Controller) configuration on how to set that up.


Now power up the backend machines.
The backend machines will first boot into the Stacki installer,
install the OS, set its boot action back to _os_ and reboot.

You should be able to get status messages for the install by watching the output of
"stack list host."

```
# watch -n 5 "stack list host"
Every 5.0s: stack list host                                                                                                                          Thu Dec 14 18:00:34 2017

HOST        RACK RANK APPLIANCE OS     BOX     ENVIRONMENT OSACTION INSTALLACTION STATUS                           COMMENT
centos      0    0    frontend  redhat default ----------- default  default	  up
backend-0-0 0    0    backend   redhat default ----------- default  console	  install profile.cgi profile sent
backend-0-1 0    1    backend   redhat default ----------- default  console	  install profile.cgi profile sent
backend-0-2 0    2    backend   redhat default ----------- default  console	  install profile.cgi profile sent
backend-0-3 0    3    backend   redhat default ----------- default  console	  install profile.cgi profile sent
backend-0-4 0    4    backend   redhat default ----------- default  console	  install profile.cgi profile sent
```

When the machines are "up" in the status column, you should be able to password-less ssh to them.

You can also use the parallel command runner to get to all the nodes from the frontend:

```
# stack run host command="uptime"
```

Very few people want the default settings you currently have, so now go to [Customization](Customization) to build out your environment.

Customization is an iterative process. You will be re-installing your machines over and over until you're happy and you've got it right.

### Re-Installation

Getting a machine to have a) known good state, b) a refresh of the os, or c) a complete reinstall including data disks, you'll want to reinstall.

Stacki manages the PXE boot of all of backend nodes. When a node has been installed, Stacki tells the PXE request to boot from local disk.

If you want to reinstall, use the stack command line to tell it what to do the next time the machine reboots.

We call "telling the node what to do on next reboot," "setting the boot action.""

This is how you do it:

To re-install a machine you change the boot
action back to _install_, for example:

```
# stack set host boot backend-0-0 action=install
```

The next time you boot _backend-0-0_, it will rebuild itself.
But a rebuild, by default, will only reformat the swap, ```/var```, and ```/``` partitions. This means all data in ```/export```, or any other data disks you've partitioned is maintained across re-installations.

The install/reinstall also sets the boot action back to "os" which means "boot from local disk." It requires no human intervention.

If you want to completely reformat all data on the backend during the
re-install, you need to set an Attribute for the given host before
you reboot the server.

```
# stack set host attr a:backend-0-0 attr=nukedisks value=true
```

To do all backend hosts at once, give the appliance name:

```
# stack set host boot a:backend action=install
# stack set host attr a:backend attr=nukedisks value=true
# stack run host backend command=reboot
```

After the backend re-installs, it will automaticaly reset the value of the
attribute to _false_ so the next time you re-install, it will do the default and only reformat the ```/var``` and ```/``` partitions.

Very few people want the default settings you currently have, so now go to [Customization](Customization) to build out your environment.
