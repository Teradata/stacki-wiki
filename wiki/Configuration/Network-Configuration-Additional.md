## Additional Network Configuration

### DNS

The Stacki frontend can serve DNS or not. It can serve it for some networks and not others. When you installed the frontend, you added nameservers.

If all your backends and frontends have hostnames served by your site DNS, you should be putting your site DNS servers in as the nameservers.

If you don't have site nameservers, the frontend can act as the named server. Set any network you want to resolve to DNS True. You can also set the "zone" which is the domainname part of the FQDN.

So for example in my two networks: "corporate" and "private" I'll set the frontend to serve DNS.

```
# stack set network dns private dns=True
# stack set network dns corporate dns=True
```

Assuming the frontend was designated as a nameserver, I will now have fqdns served by the frontend. So if I ssh to "backend-0-0.corporate", I should get to an IP address on the backend (assuming you set this up) mapping to backend-0-0.corporate on the 10.2.0.0 subnet. Same thing with the private.

#### Adding additional hosts to DNS

If you want to add additional hosts/domains for DNS that is served by the Stacki frontend. Edit new entries in /var/named/named.local.

Sync your changes by doing:

`stack sync config`

And the Stacki frontend DNS will answer host queries for the domain aded.

Don't do this if you have site DNS servers or you've never edited a DNS file.

Editing DNS entries is rarely needed.

### Managing /etc/hosts

`stack sync config` updates and manages the /etc/hosts file. Do not edit it. If you wish to add additional site-related hosts you can add those entires to /etc/hosts.local.  

A `stack sync config` will then append these to the /etc/hosts file that is managed by Stacki.

Example:

```
# cat /etc/hosts
#
# WARNING: This file is generated do not edit.
#
# Contents last written on 01/05/18 10:06:11 AM by Stacki.
#

#  Site additions go in /etc/hosts.local

127.0.0.1	localhost.localdomain	localhost

10.5.1.1	stacki-50.local
10.1.2.100	stacki-50.ipmi
172.16.20.1	stacki-50.vland
192.168.5.1	stacki-50.jkloud.com stacki-50
10.5.255.254	backend-0-0.local backend-0-0
10.5.255.253	backend-0-1.local backend-0-1
10.5.255.252	backend-0-2.local backend-0-2
10.5.255.251	backend-0-3.local backend-0-3
10.5.255.250	backend-0-4.local backend-0-4
```

Add host:
```
[root@stacki-50 src]# vi /etc/hosts.local
10.18.15.3 ansible-tower.corporate ansible-tower
````

Sync it:
```
[root@stacki-50 src]# stack sync config
Sync Config
	       Sync DNS
	       Sync Host
	       Sync DHCP
	       Sync Host Repo
```

Verify:

```
# cat /etc/hosts
#
# WARNING: This file is generated do not edit.
#
# Contents last written on 01/08/18 13:01:38 PM by Stacki.
#

#  Site additions go in /etc/hosts.local

127.0.0.1	localhost.localdomain	localhost

10.5.1.1	stacki-50.local
10.1.2.100	stacki-50.ipmi
172.16.20.1	stacki-50.vland
192.168.5.1	stacki-50.jkloud.com stacki-50
10.5.255.254	backend-0-0.local backend-0-0
10.5.255.253	backend-0-1.local backend-0-1
10.5.255.252	backend-0-2.local backend-0-2
10.5.255.251	backend-0-3.local backend-0-3
10.5.255.250	backend-0-4.local backend-0-4

# Imported from /etc/hosts.local

10.18.15.3 ansible-tower.corporate ansible-tower
```       
##### Syncing hosts to backend nodes

If you don't want to use DNS, or you have an application that requires an /etc/hosts with all the hosts in the cluster, sync /etc/hosts to the backends.

Set the sync.hosts attribute:
```
stack set attr attr=sync.hosts value=True
```
Install the machines. /etc/hosts will now have all the hosts managed by stacki, including any hosts you may have put in /etc/hosts.local.

### MTU

If you don't know what this is about, skip to the next section.

We come from the HPC space. Yearrrrrrs in the HPC space. We've never seen the use of jumbo frames or MTU have a positive effect on a cluster.

But, we get it, someone asked for it. Or some stupid Hadoop distro has decided they need jumbo frames, and you have to give it to them.

Easy, either in your networks csv file change the MTU field to the desired MTU (probably 9000, right?) or `stack set network mtu networkname> mtu=9000`.

Any network interface of a backend host with an IP address on that network, will automatically get the desired MTU. Nothing else to do.


### Bonding, VLAN, Bridging, and virtual interfaces

We like bonding. Whether it be mini-golf or cow-tipping, we are all about team-building exercises. (No, we're not, I'm kidding. If the sense of shared work you do together isn't team-building enough - _no_  amount of white-water rafting is going to make you a better team.)

I digress. Bonding for network interfaces is supported both on the command line and in a spreadsheet. Set-up can be done after the install and executed with 'stack sync host network' or a reinstall can be done after bonding configuration.

The proper ifcfg files are written with the bonding set-up - it's just typical Linux.

The same thing is true of different VLANs, bridge interfaces, and virtual interfaces. If you have the wacky network config, we can probably enact it. We once helped someone creat multiple virtual interfaces against an bonded and bridged set of nics with multiple VLANs. It was a telco. They're crazy.

Please see the [Example CSV Files](Example-CSV-Files) for details and inspiration.
