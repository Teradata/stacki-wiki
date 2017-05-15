---
layout: page
title: Boxes
permalink: /Boxes
---

Stacki enables you to create a **box** which is a composition of pallets
and (optionally) carts.
The contents of a box is the entire set of RPMs and configuration scripts that
are available to a backend host when it installs.

The _default_ box consists of the _stacki_ and _os_ pallets (and no carts).
The _os_ pallet is a stripped down version of CentOS.
These two pallets are the minimum pallets required to install a backend host.
Backend hosts are assigned the _default_ box automatically.

Different backend hosts can be assigned to different boxes which gives you
a great deal of latitude when deciding what software stacks should go on which
backend hosts.

A few examples of the utility of boxes:

* **Maintaining different versions of the OS**:
  If you want CentOS 6.6 on one set of backend hosts and CentOS 6.7 on another
  set of backend hosts.
  You can download the 6.7 CentOS ISOs, add them to the frontend (with `stack
  add pallet`), create a new box with the CentOS 6.7 pallet, then assign
  backend hosts to the new box.

* **Maintaining updates**:
  Pallets can be created by mirroring any publicly available repo (or
  subscribed repo if using RHEL).
  Adding an _updates_ pallet to any box will make the updated RPMs
  to hosts via yum.

* **Maintaining dev/test/production environments**:
  Again, having created dev, test,
  and production boxes with the appropriate pallets,
  assign machines to each of those boxes.
  Install/reinstall the machines.
  When you want to promote machines to a new environment,
  reassign the machine's box and reinstall.

## Create a new box

This example will create a new box that incorporates RHEL 6.7 instead of
CentOS 6.7.
Then we'll then assign a machine to the new box.

List boxes:

```
# stack list box
```

Which returns:

```
NAME     OS     PALLETS                   CARTS
default: redhat stacki-3.0-6.x CentOS-6.7 -----
```

In the above output, the _default_ box contains two pallets (_stacki_
version _3.0-6.x_ and _CentOS_ version _6.7_) and it contains no
carts (denoted by `-----`).

Let's look at all the available pallets:

```
# stack list pallet
```

Which outputs:

```
NAME    VERSION RELEASE ARCH   OS     BOXES  
os:     6.7     6.x     x86_64 redhat -------
stacki: 3.0     6.x     x86_64 redhat default
CentOS: 6.7     ------- x86_64 redhat default
```

We see we have _CentOS_ version _6.7_ avaiable.
Now we'll add RHEL 6.7 to the list of available pallets:

```
# stack add pallet rhel-server-6.7-x86_64-dvd.iso
```

And now the output of `stack list pallet` shows:

```
NAME    VERSION RELEASE ARCH   OS     BOXES  
os:     6.7     6.x     x86_64 redhat -------
stacki: 3.0     6.x     x86_64 redhat default
CentOS: 6.7     ------- x86_64 redhat default
RHEL:   6.7     ------- x86_64 redhat -------
```

The _RHEL_ pallet is not associated with any box.

We'll add a new box and call it _dev_:

```
# stack add box dev
```

Now `stack list box` shows the new box _dev_ with no pallets and no carts
associated with it:

```
NAME     OS     PALLETS                   CARTS
default: redhat stacki-3.0-6.x CentOS-6.7 -----
dev:     redhat ------------------------- -----
```

Let's associate the _RHEL_ and _stacki_ pallets with the _dev_ box:

```
# stack enable pallet RHEL box=dev
# stack enable pallet stacki box=dev
```

And now `stack list box` shows:

```
NAME     OS     PALLETS                   CARTS
default: redhat stacki-3.0-6.x CentOS-6.7 -----
dev:     redhat stacki-3.0-6.x RHEL-6.7   -----
```

We see that the _dev_ box contains the _RHEL_ and _stacki_ pallets.

Now let's assign a backend host to the _dev_ box.
First, let's look at what the backend hosts are currently set to:

```
# stack list host
HOST     RACK RANK CPUS APPLIANCE BOX     RUNACTION INSTALLACTION
node203: 0    0    1    frontend  default os        install     
node214: 0    22   2    backend   default os        install    
node213: 0    23   2    backend   default os        install   
```

We see that backend hosts _node213_ and _node214_ are both associated with
the _default_ box.

Let's associate _node214_ with the new _dev_ box:

```
# stack set host box node214 box=dev
```

Now `stack list host` shows that _node214_ is associated with the _dev_ box:

```
HOST     RACK RANK CPUS APPLIANCE BOX     RUNACTION INSTALLACTION
node203: 0    0    1    frontend  default os        install     
node214: 0    22   2    backend   dev     os        install    
node213: 0    23   2    backend   default os        install   
```

The next time _node214_ is installed, it will have the packages from the
_RHEL_ pallet (repository) at its disposal rather than the _CentOS_ packages.


## Removing a Box

To remove a box, do the following:

Reset the backend nodes to a valid box:

```
# stack set host box node214 box=default
```

Remove the box _dev_ and verify it is gone:

```
# stack remove box dev
# stack list box
```

Which shows that we only now have the _default_ box defined:

```
NAME     OS     PALLETS                   CARTS
default: redhat stacki-3.0-6.x CentOS-6.7 -----
```

