## Adding OS Pallets

If you need any software housed in the CentOS distribution, you'll want to add the full distribution as a pallet - along with the CentOS updates for that version.

## Adding an OS pallet

These commands work with all OSs, but CentOS is the example.

Download the full CentOS 7.6 ISOs from a CentOS mirror.

You can use:

[CentOS-7-x86_64-DVD-1810.iso](http://archive.kernel.org/centos-vault/7.6.1810/isos/x86_64/CentOS-7-x86_64-DVD-1810.iso)

but I usually use:

[x86_64/CentOS-7-x86_64-Everything-1810.iso](http://archive.kernel.org/centos-vault/7.6.1810/isos/x86_64/CentOS-7-x86_64-Everything-1810.iso)

Once they're downloaded, `scp` the ISOs to the frontend and add them. /export is usually the largest disk partition so I usually put them there.:



```
scp CentOS*.iso root@10.1.1.1:/export

ssh root@10.1.1.1

cd /export

# stack add pallet CentOS-7-x86_64-*.iso
```

List pallets:
```
# stack list pallet
NAME           VERSION      RELEASE ARCH   OS     BOXES
stacki         5.3          redhat7 x86_64 redhat default
os             7.4          redhat7 x86_64 redhat defaults
CentOS         7            redhat7 x86_64 redhat
```

There can be only one OS pallet for a given box. So enable the CentOS pallet and disable the "os" pallet.

Enable the CentOS pallet:
```
# stack enable pallet CentOS
```

Disable the OS pallet and list pallets to make sure:

```
# stack disable pallet os

# stack list pallet
NAME           VERSION      RELEASE ARCH   OS     BOXES
stacki         5.3          redhat7 x86_64 redhat default
os             7.4          redhat7 x86_64 redhat
CentOS         7            redhat7 x86_64 redhat default
```

You now have the full CentOS distribution on the frontend. Added as a pallet, it will be available to the backend nodes as a repository. See [About Repos](About-Repos) to understand how Stacki manages repositories from the frontend.

It is very likely that there have been updates to the CentOS version available on the ISO. We want to get those.

The easiest way is to do a `stack create mirror` of the updates repository from CentOS since that command automatically downloads the latest updated RPMS and turns them into an ISO file. (`stack create mirror` runs reposync under the hood.)

The following assumes you have internet access from the frontend, either directly or via a proxy.

Go to your largest directory and run the mirror command to see what the options are:

```
# cd /export

# stack create mirror
error - "url" or "repoid" parameter is required
[arch=string] [name=string] [newest=boolean] [quiet=boolean] [repoconfig=string] [repoid=string] [url=string] [urlonly=boolean] [version=string]
```

We can give it a url that points to a set of RPMS or we can use the repoid/repoconfig options if we have a repo file. And we do.

The CentOS*.repo files are all saved in /etc/yum.repos.d/save because the main repo is the /etc/yum.repos.d/stacki.repo, which contains all cart and pallet directories as repositories. (Again refer to the [Repos](About-Repos) docs for further details.) So we'll use the CentOS-Base.repo as our repoconfig file and the repoid in that file called "updates."

```root

# stack create mirror repoconfig=/etc/yum.repos.d/save/CentOS-Base.repo repoid=updates
```

This produces an ISO file in the /export/updates directory called *updates-5.0_20171128_b0ed4e3-redhat7.x86_64.disk1.iso.*

This contains the release name and version of the stacki pallet. You probably don't want that.

This is what we use as our standard: giving the name CentOS-Updates and the date we pulled the updates as the version, but you can use the version/release naming for your site.

```
# stack create mirror repoconfig=/etc/yum.repos.d/save/CentOS-Base.repo repoid=updates name=CentOS-Updates version=20171220
```

It's quiet by default, and on a slow connection it will look like it will take for-evah.

Make it not quiet:

```
# stack create mirror repoconfig=/etc/yum.repos.d/save/CentOS-Base.repo repoid=updates name=CentOS-Updates version=20171128 quiet=false
```

If you want to see what will be downloaded, throw the "urlonly=true" flag and you'll just get a list.

The CentOS updates repository contains all version of every update. So if an RPM gets an update to an update, there will be multiple versions with the same name. Except we default to mirror only the most recent of any given RPM so you really only get the updates.

So now we have an updates iso with a rational name. Add it and enable it:

```
# stack add pallet updates/CentOS-Updates-7.4_20171128-redhat7.x86_64.disk1.iso

# stack enable pallet CentOS-Updates

# stack list pallet
NAME           VERSION              RELEASE ARCH   OS     BOXES
os             7.4_20171128         redhat7 x86_64 redhat
stacki         5.3                  redhat7 x86_64 redhat default
CentOS         7                    redhat7 x86_64 redhat default
CentOS-Updates 7.6_20171128         redhat7 x86_64 redhat default
```

These pallets are in the yum repository for backend nodes.

At this point you can update your frontend: `yum update` and either update already installed nodes with:

```
# stack sync host repo a:backend

# stack run host command="yum clean all; yum -y update"
```

Or reinstall without "nukedisks" set to "True" which just refreshes the OS.

```
# stack set host boot a:backend action=install

# stack run host command="reboot"
```
