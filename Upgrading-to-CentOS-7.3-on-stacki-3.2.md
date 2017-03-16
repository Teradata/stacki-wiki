<h2>Upgrading to CentOS 7.3 on Stacki-3.2</h2>

<h3>tl;dr</h3>
I highly recommend doing this in your largest partition which should be /export or /state/partition1. Technically these should be the same directory.

* Download [CentOS 7.3 Everything DVD](http://isoredirect.centos.org/centos/7/isos/x86_64/CentOS-7-x86_64-Everything-1611.iso)
* Download [CentOS 7.3 Updates ISO](https://s3.amazonaws.com/stacki/public/os/centos/7/CentOS-Updates-7.3-7.x.x86_64.disk1.iso)
* Do **The Fix** below, first, before you do anything else.

```
# stack add pallet CentOS-7-x86_64-Everything-1611.iso CentOS-Updates-7.3-7.x.x86_64.disk1.iso

breathe or whatever

# stack enable pallet CentOS CentOS-Updates
# stack disable pallet os
# yum update -y
# mkdir /export/repos
# mv /etc/yum.repos.d/CentOS* /export/repos
# reboot

when up:
# chmod 755 /root 
(Don't ask why, this is the tl;dr you lazy bum.)
```
* Install nodes.

Or:

* If you already have nodes and just want to update: 

```
# stack run host command="yum -y update && reboot"
```

If updates are too old for you, update your updates.
```
# stack create mirror name=CentOS-Updates newest=true repoconfig=/export/repos/CentOS-Base.repo repoid=updates version=7.3
```
Then do the **add pallet** to **reboot** again.

<h3> ! tl;dr </h3>

Are you sure you want to do this?

No. Are you really sure you want to do this?

Because stacki-4.0 is about a month away, and you don't have to do anything to get 7.3 on that. And it will be better.

No?

Okay. Fine. 

If Pontius Pilate<sup name="a1">[1](#f1)</sup> has any genetic material left 2000+ years later, I'm claiming it's in me. Because I'll give you the instructions on how to do this, but then I'm washing my hands of you.

To be fair, I'm currently doing this on every stacki-os-3.2 frontend I install to do testing. So, it works. I don't know if there are long-term consequences - you get to find that out. 

And I'll give you the gentle version first, which doesn't include your frontend. 

Download the [CentOS 7.3 Everything DVD](http://isoredirect.centos.org/centos/7/isos/x86_64/CentOS-7-x86_64-Everything-1611.iso). You know you want to. There's no reason not to since you've come this far.

You can also get it from us [here.](https://s3.amazonaws.com/stacki/public/os/centos/7/CentOS-7-x86_64-Everything-1611.iso)

Get updates from us [here](https://s3.amazonaws.com/stacki/public/os/centos/7/CentOS-Updates-7.3-7.x.x86_64.disk1.iso). These are recent as a of 3/15/2017. If you want to update your updates, see Updating Your Updates below.

Before you do anything after you've downloaded, do **The Fix**.

<h3>The Fix</h3>
Before you do a <b>stack add pallet</b>, there's something you should know and something you should fix. CentOS/RedHat changed the disc information on their isos, which causes the <b>add pallet</b> command to read the CentOS-7.3 iso as BaseOS, which is a bald-faced lie, and we don't lie here anymore because all of our salespeople are gone and we don't remember how. 

This means we're gonna fix it, and by "we" I mean "you." Which means you're going to have to write some python code. You, yes, you, have to open up an editor and get your fingers on. Do the following:

```
# cd /opt/stack/lib/python2.6/site-packages/stack/commands/add/pallet

[root@stackdock pallet]# ls
imp_foreign_redhat.py   imp_mounted_redhat.py  imp_mount_redhat.pyc  imp_native_redhat.pyc  imp_umount_redhat.pyc  __init__.pyc
imp_foreign_redhat.pyc  imp_mount_redhat.py    imp_native_redhat.py  imp_umount_redhat.py   __init__.py

```

The file we care about is "imp_foreign_redhat.py." Open this in your favorite editor. I use **vi** because everything else is unmitigated garbage. Go to line 128. (Double-starred for instructive purposes.)

```
# vi imp_foreign_redhat.py


                        if key == 'family':
                                if value == 'Red Hat Enterprise Linux':
                                        name = 'RHEL'
                                **elif value == 'CentOS':**
                                        name = 'CentOS'
```

Change line 128 to be this:

```

                        if key == 'family':
                                if value == 'Red Hat Enterprise Linux':
                                        name = 'RHEL'
                                **elif 'CentOS' in value:**
                                        name = 'CentOS'
```

Save it, write it, now you should be good to finish the rest. 

Do the following on a large partition, wherever you've downloaded the ISOs to.

```
# stack add pallet CentOS-7-x86_64-Everything-1611.iso CentOS-Updates-7.3-7.x.x86_64.disk1.iso

breathe or whatever

# stack enable pallet CentOS CentOS-Updates
# stack disable pallet os
```

If you are not going to update your frontend, then stop here and reinstall your nodes or update them with:

```
# stack run host command="yum -y update && chmod 755 /root && reboot"
```
You want the new kernel right? You gotta reboot to get it. I hope it works. You could always try it on one machine first before you do all 328, which is what I would do, but then hey, I'm not you.

If you're going to upgrade your frontend, cross fingers, then do the following before installing or updating machines:

```
# yum update -y
# mkdir /export/repos
# mv /etc/yum.repos.d/CentOS* /export/repos
# reboot

when up:
# chmod 755 /root 
```

The moving the of CentOS repo files is needed so the stacki.repo is used. Otherwise yum gets confused.

The chmod on /root is necessary because the update to 7.3 changes the perms to 555, which makes it so the backend nodes don't get the id_rsa.pub in their authorized_keys files, which breaks SSH. Considered generally bad by everyone.

With the frontend upgraded, rebooted, and chmoded:

Install nodes. I assume you know how to do this. If you don't want to lose data, don't throw the "nukedisks" flag. You'll essentially get the a refreshed OS.

Or:

If you already have nodes and just want to update: 

```
# stack run host command="yum -y update && chmod 755 && reboot"
```

If updates are too old for you, update your updates.
```
# stack create mirror name=CentOS-Updates newest=true repoconfig=/export/repos/CentOS-Base.repo repoid=updates version=7.3
```
Then do the **add pallet** to **reboot** again.


<h3>Updating the Updates</h3>
There are two ways to get the Updates from that repository. Download it from us here.

Or do a ```stack create mirror``` command. That's a little more complicated, so let's add an actual html header for it.

<h3>Mirroring CentOS 7 updates.</h3>

If you've updated your frontend, this is easy. The centos-release rpm was updated and they dropped a bunch of repo files in /etc/yum.repos.d. You want to use those to get the updates, but you also want them out of the way of your stacki.repo in that directory.

So:
```
# mkdir /export/repos
# mv /etc/yum.repos.d/CentOS* /export/repos
```
Now we can make the mirror:
```
# stack create mirror name=CentOS-Updates newest=true repoconfig=/export/repos/CentOS-Base.repo repoid=updates version=7.3
```
This will be saved in the current directory in the updates dir. Just add the ISO file from the ./updates directory. Then it's just as above: add, enable, yum update, chmod, reboot or update nodes.

If you don't update your frontend then you need to update the centos-release rpm.

```
# updatedb

# locate centos-release | grep rpm
/state/partition1/stack/pallets/CentOS/7/redhat/x86_64/Packages/centos-release-7-3.1611.el7.centos.x86_64.rpm
/state/partition1/stack/pallets/os/7.2/redhat/x86_64/RPMS/centos-release-7-2.1511.el7.centos.2.10.x86_64.rpm
```

add the 7.3 one:

```
rpm -ivh --force /state/partition1/stack/pallets/CentOS/7/redhat/x86_64/Packages/centos-release-7-3.1611.el7.centos.x86_64.rpm
```

Now you can move the repo files and create the mirror.

Now you have an updated 7.3. Aren't you happy?

<h6>Footnotes</h6>

<sup name="f1">[1](#a1)</sup> 25 points for Classical Reference.