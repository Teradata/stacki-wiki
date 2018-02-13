## Backend Network Configuration

Stacki handles networking for frontends and backends which includes:

* Discovering all available network interfaces on initial install.
* Setting up all NIC interfaces with the correct mac/ip/hostname.
* Setting up bonding and vlans if configured.
* Includes config and setup for IB networks.

You should NOT be configuring NIC interfaces by hand or in a cart for either frontends or backends. If you are, then you're losing.

If you define networks in the database, it will get set-up correctly on the backends.

Configuration can be done during installation or after a node is installed.

## Network Configuration for the frontend.

Make sure you've created the network configuration on the frontend for any additional networks as per the [Network Configuration - Frontend](Network-Configuration-Frontend) docs.

## Using the new network.

The first installation of a backend node always discovers every NIC presented in the BIOS, whether it's actually wired or not. If it exists, Stacki finds it and adds it to the database.

This is why installing a minimal os is a great way to verify that you have the hardware you think you have.

When you supply a hosts spreadsheet, you're required to supply the mac/ip/hostname pairing for the database. It looks like this:

```
NAME,INTERFACE HOSTNAME,DEFAULT,APPLIANCE,RACK,RANK,IP,MAC,INTERFACE,NETWORK,CHANNEL,OPTIONS,VLAN,INSTALLACTION,OSACTION,GROUPS,BOX,COMMENT
backend-0-0,backend-0-0,True,backend,0,0,10.5.255.254,c8:1f:66:cb:e7:43,em1,private,,,,console,default,,default,
backend-0-1,backend-0-1,True,backend,0,1,10.5.255.253,c8:1f:66:cb:33:74,em1,private,,,,console,default,,default,
backend-0-2,backend-0-2,True,backend,0,2,10.5.255.252,c8:1f:66:cb:e5:7d,em1,private,,,,console,default,,default,
backend-0-3,backend-0-3,True,backend,0,3,10.5.255.251,c8:1f:66:cb:37:75,em1,private,,,,console,default,,default,
backend-0-4,backend-0-4,True,backend,0,4,10.5.255.250,c8:1f:66:cd:d3:c0,em1,private,,,,console,default,,default,
```

Cool, right? But you know there's more than one NIC, and you know you have to use them. So either you have to add additional lines for the other interfaces with the correct ip/macs/network info, or you can do it after all those are discovered during the initial install.

After I've installed these nodes the first time, this is what my host csv file looks like:

```
# stack report hostfile
NAME,INTERFACE HOSTNAME,DEFAULT,APPLIANCE,RACK,RANK,IP,MAC,INTERFACE,NETWORK,CHANNEL,OPTIONS,VLAN,INSTALLACTION,OSACTION,GROUPS,BOX,COMMENT
backend-0-0,backend-0-0,True,backend,0,0,10.5.255.254,c8:1f:66:cb:e7:43,em1,private,,,,console,default,,default,
backend-0-0,,,,,,,c8:1f:66:cb:e7:44,em2,,,,,,,,,
backend-0-0,,,,,,,00:06:88:0f:74:e4,enp0s29u1u2,,,,,,,,,
backend-0-0,,,,,,,80:00:02:08:fe:80:00:00:00:00:00:00:f4:52:14:03:00:7e:b9:f1,ib0,,,,,,,,,
backend-0-1,backend-0-1,True,backend,0,1,10.5.255.253,c8:1f:66:cb:33:74,em1,private,,,,console,default,,default,
backend-0-1,,,,,,,c8:1f:66:cb:33:75,em2,,,,,,,,,
backend-0-1,,,,,,,00:06:88:0f:74:32,enp0s29u1u2,,,,,,,,,
backend-0-1,,,,,,,80:00:02:08:fe:80:00:00:00:00:00:00:f4:52:14:03:00:7e:bf:41,ib0,,,,,,,,,
backend-0-2,backend-0-2,True,backend,0,2,10.5.255.252,c8:1f:66:cb:e5:7d,em1,private,,,,console,default,,default,
backend-0-2,,,,,,,c8:1f:66:cb:e5:7e,em2,,,,,,,,,
backend-0-2,,,,,,,d8:eb:97:b6:84:46,enp0s29u1u2,,,,,,,,,
backend-0-2,,,,,,,80:00:02:08:fe:80:00:00:00:00:00:00:f4:52:14:03:00:7e:c2:41,ib0,,,,,,,,,
backend-0-3,backend-0-3,True,backend,0,3,10.5.255.251,c8:1f:66:cb:37:75,em1,private,,,,console,default,,default,
backend-0-3,,,,,,,c8:1f:66:cb:37:76,em2,,,,,,,,,
backend-0-3,,,,,,,00:06:88:0f:74:d8,enp0s29u1u2,,,,,,,,,
backend-0-3,,,,,,,80:00:02:08:fe:80:00:00:00:00:00:00:f4:52:14:03:00:1e:e2:11,ib0,,,,,,,,,
backend-0-4,backend-0-4,True,backend,0,4,10.5.255.250,c8:1f:66:cd:d3:c0,em1,private,,,,console,default,,default,
backend-0-4,,,,,,,c8:1f:66:cd:d3:c1,em2,,,,,,,,,
backend-0-4,,,,,,,00:06:88:0f:74:d4,enp0s29u1u2,,,,,,,,,
backend-0-4,,,,,,,80:00:02:08:fe:80:00:00:00:00:00:00:f4:52:14:03:00:1e:dc:41,ib0,,,,,,,,,
```

I've got two on-board interfaces (em1,em2), one USB nic (enp0s29u1u2), and one Infiniband interface (ib0) on each of these nodes. I didn't have these listed in the database until after I had installed them. But now that I have them, I want to use them. (You could have add all of these from the command line with a `stack add host interface` command, but man, that's work.)

So I'll use my host spreadsheet as per above.

Create a CSV file for only the backends. We've handled the frontend NIC config previously.

```
# stack report hostfile a:backend > hosts.csv
```

Now I can open hosts.csv and edit it to have interfaces with the IP addressing scheme I want, dump it back into the database, and then reinstall or sync the network. (If you have good eyes, use 'vi' or 'emacs'. If you're a real admin, you'll use 'vi'. If you like to stay sane, use Excel or Google Sheets and save your eyesight and sanity. Save it as CSV and dump it back in with the 'stack load hostfile' command.)

I just threw a bunch of things at you so let's do a somewhat complicated example. Rarely will your network be this complex - we have Fortune 100 companies who do everything on a single corporate network. But we also have Fortune 100 companies whose network topology borders on the Gordian[^1]

These are my networks from the [frontend networking docs.](Networking-Configuration-Frontend)

```
# stack report networkfile
NETWORK,ADDRESS,MASK,GATEWAY,MTU,ZONE,DNS,PXE
ipmi,10.1.2.0,255.255.255.0,10.1.0.100,1500,ipmi,False,False
private,10.5.0.0,255.255.0.0,10.5.1.10,1500,local,True,True
public,192.168.0.0,255.255.0.0,192.168.10.1,1500,jkloud.com,False,False
vland,172.16.20.0,255.255.255.0,172.16.20.1,1500,vland,True,False
```

I've taken care of the frontend NICs prior to this. Please see the [Frontend Network Configuration](Network-Configuration-Frontend) "Spreadsheet - more advanced example" section.

## Configuring the backend NICs.

I'm going to edit my hosts.csv. It should now look like this after an **_extensive_** Excel editing session.

I'm doing bonding of two nics:

```
NAME,INTERFACE HOSTNAME,DEFAULT,APPLIANCE,RACK,RANK,IP,MAC,INTERFACE,NETWORK,CHANNEL,OPTIONS,VLAN,INSTALLACTION,OSACTION,GROUPS,BOX
backend-0-0,backend-0-0,,backend,0,0,172.16.20.254,,bond0,vland,,"bonding-opts=""mode=0 primary=em2""",,console,default,,default
backend-0-0,backend-0-0,True,,,,10.12.255.254,c8:1f:66:cb:e7:43,em1,private,,,,,,,
backend-0-0,backend-0-0,,,,,,c8:1f:66:cb:e7:44,em2,,bond0,,,,,,
backend-0-0,backend-0-0,,,,,,00:06:88:0f:74:e4,enp0s29u1u2,,bond0,,,,,,
backend-0-0,,,,,,,80:00:02:08:fe:80:00:00:00:00:00:00:f4:52:14:03:00:7e:b9:f1,ib0,,,,,,,,
backend-0-1,backend-0-1,,backend,0,1,172.16.20.253,,bond0,vland,,"bonding-opts=""mode=0 primary=em2""",,console,default,,default
backend-0-1,backend-0-1,True,,,,10.12.255.253,c8:1f:66:cb:33:74,em1,private,,,,,,,
backend-0-1,backend-0-1,,,,,,c8:1f:66:cb:33:75,em2,,bond0,,,,,,
backend-0-1,backend-0-1,,,,,,00:06:88:0f:74:32,enp0s29u1u2,,bond0,,,,,,
backend-0-1,,,,,,,80:00:02:08:fe:80:00:00:00:00:00:00:f4:52:14:03:00:7e:bf:41,ib0,,,,,,,,
backend-0-2,backend-0-2,,backend,0,2,172.16.20.252,,bond0,vland,,"bonding-opts=""mode=0 primary=em2""",,console,default,,default
backend-0-2,backend-0-2,True,,,,10.12.255.252,c8:1f:66:cb:e5:7d,em1,private,,,,,,,
backend-0-2,backend-0-2,,,,,,c8:1f:66:cb:e5:7e,em2,,bond0,,,,,,
backend-0-2,backend-0-2,,,,,,d8:eb:97:b6:84:46,enp0s29u1u2,,bond0,,,,,,
backend-0-2,,,,,,,80:00:02:08:fe:80:00:00:00:00:00:00:f4:52:14:03:00:7e:c2:41,ib0,,,,,,,,
backend-0-3,backend-0-3,,backend,0,3,172.16.20.251,,bond0,vland,,"bonding-opts=""mode=0 primary=em2""",,console,default,,default
backend-0-3,backend-0-3,True,,,,10.12.255.251,c8:1f:66:cb:37:75,em1,private,,,,,,,
backend-0-3,backend-0-3,,,,,,c8:1f:66:cb:37:76,em2,,bond0,,,,,,
backend-0-3,backend-0-3,,,,,,00:06:88:0f:74:d8,enp0s29u1u2,,bond0,,,,,,
backend-0-3,,,,,,,80:00:02:08:fe:80:00:00:00:00:00:00:f4:52:14:03:00:1e:e2:11,ib0,,,,,,,,
backend-0-4,backend-0-4,,backend,0,4,172.16.20.250,,bond0,vland,,"bonding-opts=""mode=0 primary=em2""",,console,default,,default
backend-0-4,backend-0-4,True,,,,10.12.255.250,c8:1f:66:cd:d3:c0,em1,private,,,,,,,
backend-0-4,backend-0-4,,,,,,c8:1f:66:cd:d3:c1,em2,,bond0,,,,,,
backend-0-4,backend-0-4,,,,,,00:06:88:0f:74:d4,enp0s29u1u2,,bond0,,,,,,
backend-0-4,,,,,,,80:00:02:08:fe:80:00:00:00:00:00:00:f4:52:14:03:00:1e:dc:41,ib0,,,,,,,,
```


This is what I have:
* My vland networks is on bond0 made up of em2 and enp0s29u1u2
* My private network is still on em1, and is just my management network.
* Infiniband is not configured.

Now remember, this is not the network configuration on the currently installed hosts. This represents what you want to have.

There are two ways to get this network configuration on the backends.

### Command line

```
# stack sync host network a:backend
```

That's it. By default this SSHs (in parallel) to the backends and rewrites the configuration files for the interfaces, network, and resolv. It then restarts the network. (To not restart the network, set "restart=false" on the above command.)

Now everything should be bonded and on the correct network.

### Reinstall

Certainty, it's a beautiful thing. Syncing is good for "right now this minute" and not having to reinstall. If you want certainty, reinstall the backends.

```
# stack set host boot a:backend action=install

# stack run host command="reboot"

Breathe.
```

Nodes should come up with the proper networking. By not setting "nukedisks" to "true," you're just refreshing the OS and other configs. Partitioning and data disks will remain untouched.

> **Note:** There are a lot of spreadsheet examples for setting up a host files for bonding, vlanning, bridging, etc. in /opt/stack/share/examples/spreadsheets/.


[^1]: There is an observation to be made here. The clients with the most complex network topologies also tend to be the clients with the most complex partitioning schemes. Nobody needs 21 partitions on an LVM volume. No.One.
