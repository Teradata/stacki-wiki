## Discover Nodes

### Things to check
1. Node network cables are plugged in.
2. Nodes are cabled to the same network as the frontend _private_ interface.
3. Nodes are set to PXE first.
4. Nodes have a system disk.
5. Node is not a laptop.  

### Discovery

In Discovery mode the frontend will listen for any host requesting a
DHCP address and will respond with an address from its managed private
network.

The DHCP response will also be a PXE response that will tell the
server to install/re-install itself.

Does this sound scary? Good, it is. It is also a great method to
quickly add new backend nodes, provided you are on an isolated private
network. It's not a good method if you don't control the private network.

Check with your networking group. If they say "no" ("Hell no!", "Seriously?", and "Not in your lifetime" are all versions of "no.") or promiscuous DHCP on a subnet  causes you nightmares, go back and use the [Spreadsheeet](Backend-Install-Spreadsheet) procedure instead.

If you're testing (Virtual Box/VMWare) and control the network environment, Discovery works great.

To start discovery mode, log into the frontend as root and run the following:

```
# discover-nodes
```

(There are a bunch of options listed in "discover-nodes -h". You'll want to look at those if you don't want the default host naming scheme.)

This will bring up a screen that shows a list of appliances available
for installation.

![insert-ethers-1](images/insert-ethers/insert-ethers-1.png)

By default only the _Backend_ appliance will be listed.
Press _OK_ to continue and then turn on the machine you want
installed.

![insert-ethers-2](images/insert-ethers/insert-ethers-2.png)

Once the backend node sends out a PXE request, the frontend captures the request and adds it to the Stacki database.

The default ordering for "insert-ethers" assigns the name to:
_appliance_-_rack_-_rank_. Where "rank" is assigned in the order
a backend node is discovered.

If the server did not PXE boot, go back and verify the BIOS boot order.

![insert-ethers-4](images/insert-ethers/insert-ethers-4.png)

Once the backend node downloads its Kickstart file, a '*' will appear next to the hostname assigned to the new backend node.

![insert-ethers-5](images/insert-ethers/insert-ethers-5.png)

Continue to turn on any other machines you want installed and hit _F8_
when done to quit "discover-nodes."

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
