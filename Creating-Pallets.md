There may come a point where it makes sense to create your own pallets. There are three types: RPM only, configuration only, and configuration + RPMS.

Pallets allow you to install and configure applications you have created or downloaded. It's a simple way to keep multiple versions or to do patching/upgrading.

Additionally, if your site-specific requirements are complex and can't be easily captured using the "extend/replace" methods found in the [Extend Backend Nodes](https://github.com/StackIQ/stacki/wiki/Extend-Backend-Nodes) documentation, a site-specific pallet is one of the ways to capture all the required configuration and site-specific RPMS.

These commands work with RHEL as well. CentOS is the example. But, really, why are you paying Red Hat?

RPM-only pallets are the simplest to create. We'll show you how to do that. However, there are a few pieces missing from the current stacki-1.0-I release we'll have to add. These changes will not be needed in the next release. 

##### Fix the build environment part I

The default OS pallet is not the full CentOS distribution. You're going to need a couple packages that are only in the full version of CentOS. Download the full CentOS 6.6 ISO(s) from a CentOS 6.6 [mirror](http://isoredirect.centos.org/centos/6/isos/x86_64/). I usually torrent the whole thing and put CentOS disk1 and disk2 on the frontend. Dis1 is probably sufficient though.

Either way, once they're downloaded, scp the ISOs to the frontend (/export should be the biggest partition, that' where I usually dump mine), and add it/them:

```
# stack add pallet CentOS-6.6-x86_64-bin-DVD*iso
```

List pallets:
```
# stack list pallet
```

Enable the CentOS pallet:
```
# stack enable pallet CentOS
```

Disable the OS pallet (because it's minimal CentOS and now we want the whole thing)
```
# stack disable pallet os
```

Create the distribution:
```
# stack create distribution
```

Again we need to add a couple RPMs for the build environment to work, so now we can add them to yum since the "create distribution" creates a central repository for all RPMs in all pallets in the distribution. You won't have to do this at the next release. 

Add genisoimage
```
# yum -y install genisoimage
```

Now you can make RPM pallets from the web.

##### RPM-only Pallet

Creating an RPM-only pallet is the same for both stacki 6 and 7. Only the URLs and repos are going to be different. 

One very common thing I do is to grab the updates from CentOS for my particular CentOS version.



