### Network Configuration for Backends

Stacki handles networking for frontends and backends which includes:
* Discovering all available network interfaces on initial install.
* Setting up all NIC interfaces with the correct mac/ip/hostname.
* Setting up bonding and vlans if configured.
* Includes config and setup for IB networks.

You should NOT be configuring NIC interfaces by hand or in a cart for either frontends or backends. If you are, then you're losing.

If you define networks in the database, it will get set-up correctly on the backends.

Configuration can be done during installation or after a node is installed.

### Network Configuration for the frontend.

Make sure you've created the network configuration for a frontend for any additional networks as per the [Network Configuration - Frontend](Network-Configuration-Frontend) docs.

### Using the new network.

The first installation of a backend node always discovers every NIC presented in the BIOS, whether it's actually wired or not. If it exists, Stacki finds.

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

I've got two on-board interfaces (em1,em2), one USB nic (enp0s29u1u2), and one Infiniband interface (ib0) on each of these nodes. I didn't have these listed in the database until after I had installed them. But now that I have them, I want to use them. (You could have add all of these from the command line with a `stack add host interface``` command, but man, that's work.)
