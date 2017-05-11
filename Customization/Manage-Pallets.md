Adding a pallet expands the range of software available to backend machines. Newer versions of the OS (6.6 vs. 6.5), different distributions (e.g. Red Hat instead of CentOS), updated OS packages, application packages with a yum repository etc. can all be added as a pallet. Once a pallet is added and enabled, a backend machine can have the desired RPMS installed with either yum or install/reinstall of the machine. 

## Cheat Sheet
If you like to get your hands dirty damn the consquences, here are the raw commands for adding a pallet. Otherwise, read the rest.

On the frontend:

```
# stack list pallet
# cd /export
# wget http://mirror.umd.edu/centos/6.6/isos/x86_64/CentOS-6.6-x86_64-bin-DVD1.iso
```

(Just get the ISO on the frontend in some way or another.)
  
```
# stack add pallet CentOS-6.6-x86_64-bin-DVD1.iso
```

If an OS pallet of a different version exists, disable the older pallet (otherwise just enable the new pallet):

```
# stack disable pallet CentOS version=6.5
# stack enable pallet CentOS version=6.6
```

Reinstall all backend machines:

```
# stack set host boot backend action=install
# stack run host backend command=reboot
```

## Adding a pallet from an existing ISO:

Let's presume we have a Stacki frontend with just two pallets: stacki and os. The stacki pallet and an OS pallet are the minimal pallets that will make up any given box. (See "Adding Boxes" in the sidebar for further discussion of boxes.)

List the pallets you currently have:

```
# stack list pallet
```

Which returns output like:

```
NAME    VERSION RELEASE ARCH   OS     BOXES  
os:     6.7     6.x     x86_64 redhat default
stacki: 3.0     6.x     x86_64 redhat default
```

Download the CentOS 6.7 DVD 1 and 2 ISOs to the frontend.

Add the CentOS DVDs as pallets:

```
# stack add pallet CentOS-6.7-x86_64-bin-DVD1.iso
# stack add pallet CentOS-6.7-x86_64-bin-DVD2.iso
```

Enable new CentOS pallet and disable the old os pallet:

```
# stack enable pallet CentOS
# stack disable pallet os
```

And now we see stacki and CentOS are associated with the default box and the
os pallet is not associated with any box.

```
# stack list pallet
NAME    VERSION RELEASE ARCH   OS     BOXES  
os:     6.7     6.x     x86_64 redhat -------
stacki: 3.0     6.x     x86_64 redhat default
CentOS: 6.7     ------- x86_64 redhat default
```

The next time a backend machine is installed, it will have the entire set of
RPMs from the standard CentOS 6.7 repository at its disposal.

