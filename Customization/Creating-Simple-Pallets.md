---
layout: page
title: Creating Simple Pallets
permalink: /Creating-Simple-Pallets
---

There may come a point where it makes sense to create your own pallets. There are three types: RPM only, configuration only, and configuration + RPMS.

Pallets allow you to install and configure applications you have created or downloaded. It's a simple way to keep multiple versions or to do patching/upgrading.

Additionally, if your site-specific requirements are complex and can't be easily captured using [Carts](https://github.com/StackIQ/stacki/wiki/Carts), a site-specific pallet is one of the ways to capture all the required configuration and site-specific RPMS.

These commands work with RHEL as well. CentOS is the example.

RPM-only pallets are the simplest to create. We'll show you how to do that.

##### Fix the build environment part I

The default OS pallet is not the full CentOS distribution. You're going to need a couple packages that are only in the full version of CentOS. Download the full CentOS 6.7 ISOs from a CentOS [mirror](http://isoredirect.centos.org/centos/6/isos/x86_64/). I usually torrent the whole thing and put CentOS disk1 and disk2 on the frontend.

Once they're downloaded, scp the ISOs to the frontend and add them:

```
# stack add pallet CentOS-6.7-x86_64-bin-DVD*iso
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

We need to add the *genisoimage* RPM for the build environment to work:

```
# yum -y install genisoimage
```

Now you can make RPM pallets from the web.

##### RPM-only Pallet

Creating an RPM-only pallet is the same for both stacki 6 and 7. Only the URLs and repos are going to be different. This assumes your frontend has access to the internet. If not, put up a VirtualBox frontend on your desktop/laptop and create the pallets there and then put them on the real frontend.

###### Creating pallet from a path.
One very common thing I do is to grab the updates from CentOS for my particular CentOS version. We'll create a mirror of the updates two ways. The first is the simplest and most direct. You're going to use the "stack create mirror" command. 

"stack create mirror" does a reposync from a URL or a repoid AND creates an ISO from the downloaded RPMs, which makes it a pallet.

So let's build the command line to do this.

You'll cd to your largest partition, default partitioning makes /export or /state/partition1 the largest partition.
```
# cd /export
```

Let's see what our options are:
```
# stack create mirror

[root@stackitest ~]# stack create mirror
error - must supply a URL argument or a "repoid"
{path} [arch=string] [name=string] [newest=boolean] [repoconfig=string] [repoid=string] [urlonly=boolean] [version=string]
```
(You can add a "help" on the end of "stack create mirror" for more detail.)

Since we know our path is http://mirror.centos.org/centos-6/6.6/updates/x86_64/Packages/ we'll just use the path.
 
```
# stack create mirror http://mirror.centos.org/centos-6/6.6/updates/x86_64/Packages/
```

We only want the newest RPMs so we'll set newest to true.
```
# stack create mirror http://mirror.centos.org/centos-6/6.6/updates/x86_64/Packages/ newest=true
```

If you want to see what you're going to get you can set urlonly=true, and you'll get an RPM listing and no downloads:

```
# stack create mirror http://mirror.centos.org/centos-6/6.6/updates/x86_64/Packages/ newest=true urlonly=true
```

Default "name" is updates and default "version" is the version of the stacki pallet. So we'll change them to be descriptive. I usually set the version to the date I make the pull, and I'll set the name so you can see an example:
```
# stack create mirror http://mirror.centos.org/centos-6/6.6/updates/x86_64/Packages/ newest=true name=CentOS-updates version=`date +%m%d%Y`
```

And now you wait. Depending on your site bandwidth, this could be a while for very large repositories. This is probably a good time to go to lunch. 

Once the download finishes, you'll have an ISO appropriately named in the directory you ran this command in, just add and enable it.

```
# stack add pallet CentOS-updates-07282015-0.x86_64.disk1.iso
# stack enable pallet CentOS-Updates
```

###### Creating pallet from a repoid.

Sometimes there's an application you want to install, and a repoconfig file
exists for it.

For this example we'll use Datastax Cassandra.

Go to the [Cassandra](http://docs.datastax.com/en/cassandra/2.1/cassandra/install/installRHEL_t.html) install docs. You'll notice about half-way down they give you the repoconfig you'll need to get this from yum. 

Copy that and put it in a file. I've put it in /export/datastax.repo, only I've disabled it.
```
# cat /export/datastax.repo

[datastax]
name = DataStax Repo for Apache Cassandra
baseurl = http://rpm.datastax.com/community
enabled = 0
gpgcheck = 0
```

Let's do a few things:
* I'm going to feed the name of this file to "repoconfig" parameter to get all the needed Cassandra RPMs. 
* The version is "2.1" because that's this version of Cassandra from Datastax. 
* I only want the newest RPMs because who knows what people dump into their repositories so "newest=true". 
* The "repoid", in this case "datastax," tells "create mirror" the repo to pull from. Some repoconfigs might have more than one stanza. For example, if Datstax had included a [datastax-extras] or [datastax-updates], stanzas you could pull those RPMs by setting repoid to the correct name.
```
# stack create mirror name=datastax-cassandra version=2.1 repoconfig=/export/datastax.repo repoid=datastax newest=true
```

Now breathe. In/out. Long deep breaths. Or, hell, just go get another cup of coffee. When it's done you should see something like this:
```
root@stackitest export]# ls /export/datastax
datastax-cassandra-2.1-0.x86_64.disk1.iso  i386  noarch  roll-datastax-cassandra.xml  x86_64
```
Note, the directory is the name of the "repoid" and the newly created file is in this directory.

Do the pallet dance:

```
# stack add pallet /export/datastax/datastax-cassandra-2.1-0.x86_64.disk1.iso 
# stack enable pallet datastax-cassandra
```

Now you can use the Datastax Cassandra RPMs on the cluster. Use the extend-backend.xml to add the appropriate RPMs and configuration settings per the Datastax install document. 

Some things to be aware of: you can add the datastax.repo file to /etc/yum.repos.d and the same thing will work. In this case you do not have to supply the "repoconfig" parameter to the "stack create mirror" command.

So why did I do it this way? Well, from a management stand-point, I don't want someone enabling a repo in /etc/yum.repos.d I don't want enabled. I use the frontend as the fulcrum point to my cluster. I don't put any services on it other than installation and monitoring. All elements of an application are run on backend nodes because they are usually better protected (private network), and the application should keep running even if the Stacki frontend goes down. If I have a repo that may inadvertently be enabled, I may end up with an application on my frontend I don't want. In my mind it's good cluster hygiene, yes, a little paranoid and neurotic, buy hygiene nonetheless. It may be, however, you have limited machines and you don't want to waste the frontend, then use it. Rocks does it. StackIQ initially did it. It saves having to set up all the keys SSH access from a backend node acting as the frontend for an application to the rest of the cluster. Just know what you're getting. 

