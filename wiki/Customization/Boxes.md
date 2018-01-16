## Boxes

Stacki enables you to create a **box** which is a composition of pallets
and (optionally) carts.

The contents of a box is the entire set of RPMs and configuration scripts that are available to a backend host when it installs.

The _default_ box consists of the _stacki_ and _os_ pallets (and no carts).
The _os_ pallet is a stripped down version of CentOS.

These two pallets are the minimum pallets required to install a backend host.

Backend hosts are assigned the _default_ box automatically.

Different backend hosts can be assigned to different boxes which gives you
a great deal of latitude when deciding what software stacks should go on which backend hosts.

A few examples of the utility of boxes:

* **Adding a different OS**
  If you want the basic functionality Stacki provides but also have to add RHEL or Oracle or something wacky like Scientific Linux, create a new box and the stacki pallet plus the new OS pallet. Backend nodes assigned to the new box will be installed with RHEL (Or Oracle or you get the idea.)

* **Maintaining different versions of the OS**:
  If you want CentOS 7.3 on one set of backend hosts and CentOS 7.4 on another set of backend hosts to test an upgrade.
  You can download the 7.4 CentOS ISOs, add them to the frontend (with `stack add pallet`), create a new box with the stacki and CentOS 7.4 pallets, then assign
  backend hosts to the new box.

* **Maintaining updates**:
  Pallets can be created by mirroring any publicly available repo (or
  subscribed repo if using RHEL).
  Adding an _updates_ pallet to any box will make the updated RPMs available
  to hosts via yum/zypper/apt-get.

* **Maintaining dev/test/production environments**:
  Again, having created dev, test,
  and production boxes with the appropriate pallets,
  assign machines to each of those boxes.
  Install/reinstall the machines.
  When you want to promote machines to a new environment,
  reassign the machine's box and reinstall.

## Create a new box

This example will create a new box that incorporates RHEL 7.4 instead of
CentOS 7.4.
Then we'll assign machines to the new box.

List pallets and boxes:

```
# stack list pallet
NAME   VERSION              RELEASE ARCH   OS     BOXES
os     7.4_20171128         redhat7 x86_64 redhat
stacki 5.0_20171128_b0ed4e3 redhat7 x86_64 redhat default
CentOS 7                    redhat7 x86_64 redhat default
```

`stack list pallet` shows the pallets available and `stack list box` shows which box contains which pallet:

```
[root@stacki-50 isos]# stack list box
NAME    OS     PALLETS                                              CARTS
default redhat stacki-5.0_20171128_b0ed4e3-redhat7 CentOS-7-redhat7
```


In the above output, the _default_ box contains two pallets (_stacki_
version 5.0_20171128_b0ed4e3 and _CentOS_ version 7.4) and it contains no
carts.

But we really, really want RHEL 7.4 because we like giving an 800lb gorilla money.

Add RHEL 7.4 (downloaded from your handy RHEL subscription) to the list of available pallets:

```
# stack add pallet rhel-server-7.4-x86_64-dvd.iso
Copying RHEL 7.4-redhat7 pallet ...
```

And now the output of `stack list pallet` shows:

```
# stack list pallet
NAME           VERSION              RELEASE ARCH   OS     BOXES
os             7.4_20171128         redhat7 x86_64 redhat
stacki         5.0_20171128_b0ed4e3 redhat7 x86_64 redhat default
CentOS         7                    redhat7 x86_64 redhat default
RHEL           7.4                  redhat7 x86_64 redhat
```

The _RHEL_ pallet is not associated with any box.

We'll add a new box and call it _rhel74_:

```
# stack add box rhel74
```
(rhel74 because what happens when rhel75 comes out?)

Now `stack list box` shows the new box _rhel74_ with no pallets and no carts
associated with it:

```
NAME    OS     PALLETS                                                CARTS
default redhat stacki-5.0_20171128_b0ed4e3-redhat7 CentOS-7-redhat7
rhel74   redhat ----------------------------------------------------------------------------------------
```

Let's associate the _RHEL_ and _stacki_ pallets with the _rhel74_ box:

```
# stack enable pallet stacki RHEL box=rhel74
Cleaning repos: CentOS-7-redhat7 stacki-5.0_20171128_b0ed4e3-redhat7
Cleaning up everything
Maybe you want: rm -rf /var/cache/yum, to also free up space taken by orphaned data from disabled or removed repos
```
(That stuff after the command is due to RedHat's loquaciousness problem, not Stacki's.)

List the pallets and see that _stacki_ is associated with two boxes, and _RHEL_ with only our default box.

```
[root@stacki50 doc]# stack list pallet
NAME           VERSION              RELEASE ARCH   OS     BOXES
os             7.4_20171128         redhat7 x86_64 redhat
stacki         5.0_20171128_b0ed4e3 redhat7 x86_64 redhat default rhel74
CentOS         7                    redhat7 x86_64 redhat default
RHEL           7.4                  redhat7 x86_64 redhat rhel74
```

And now `stack list box` shows:

```
# stack list box
NAME    OS     PALLETS                                              CARTS
default redhat stacki-5.0_20171128_b0ed4e3-redhat7 CentOS-7-redhat7
rhel74   redhat stacki-5.0_20171128_b0ed4e3-redhat7 RHEL-7.4-redhat7
```

We see that the _rhel74_ box contains the _RHEL_ and _stacki_ pallets.

Now let's assign a backend host to the _rhel74_ box.


First, let's look at what the backend hosts are currently set to:

```
# stack list host
HOST        RACK RANK APPLIANCE OS     BOX     ENVIRONMENT OSACTION INSTALLACTION STATUS COMMENT
stacki-50   0    0    frontend  redhat default ----------- default  default       up
backend-0-0 0    0    backend   redhat default ----------- default  console       up
backend-0-1 0    1    backend   redhat default ----------- default  console       up
backend-0-2 0    2    backend   redhat default ----------- default  console       up
backend-0-3 0    3    backend   redhat default ----------- default  console       up
backend-0-4 0    4    backend   redhat default ----------- default  console       up
```

We see all backend hosts are associated with the _default_ box.

Let's associate backend-0-0 through backend-0-2 to the _rhel74_ box:

```
# stack set host box backend-0-[0-2] box=rhel74
```

Now `stack list host` shows backend-0-0, backend-0-1, and backend-0-2 are associated with the _rhel74_ box:

```
# stack list host
HOST        RACK RANK APPLIANCE OS     BOX     ENVIRONMENT OSACTION INSTALLACTION STATUS COMMENT
stacki-50   0    0    frontend  redhat default ----------- default  default       up
backend-0-0 0    0    backend   redhat rhel74  ----------- default  console       up
backend-0-1 0    1    backend   redhat rhel74  ----------- default  console       up
backend-0-2 0    2    backend   redhat rhel74  ----------- default  console       up
backend-0-3 0    3    backend   redhat default ----------- default  console       up
backend-0-4 0    4    backend   redhat default ----------- default  console       up
```

To get those nodes onto RHEL 7.4, they need to be reinstalled. Once they are, they'll be RHEL 7.4 machines not CentOS.

So do the reinstall dance:

```
# stack set host boot backend-0-[0-2] action=install
# stack run host backend-0-[0-2] command="reboot"
```

We can verify after a re-install:

```
# stack run host command="cat /etc/redhat-release"
HOST        OUTPUT
backend-0-0 Red Hat Enterprise Linux Server release 7.4 (Maipo)
backend-0-1 Red Hat Enterprise Linux Server release 7.4 (Maipo)
backend-0-2 Red Hat Enterprise Linux Server release 7.4 (Maipo)
backend-0-3 CentOS Linux release 7.4.1708 (Core)
backend-0-4 CentOS Linux release 7.4.1708 (Core)
```

You subscribed those, right?

## Removing a Box

To remove a box, do the following:

Reset the backend nodes to a valid box:

```
# stack set host box backend-0-[0-2] box=default
```

Remove the box _rhel74_ and verify it is gone:

```
# stack remove box rhel74
# stack list box
```

Which shows that we only now have the _default_ box defined:

```
# stack list box
NAME    OS     PALLETS                                              CARTS
default redhat stacki-5.0_20171128_b0ed4e3-redhat7 CentOS-7-redhat7
```
