## Create Jumbo pallets

A "Jumbo Pallet" is a pallet that consists of combining the Stacki pallet with the OS pallet of your choice to install a frontend.

It's possible to add additional pallets, but the size grows and can easily be larger than a DVD or even a smallish USB can hold.

If you're going to create and use a jumbo pallet, it's advised to install the frontend via virtual media since this does not suffer from size issues.

This is only for a frontend so it contains the same OS that you want on the backends.

##  Create a Jumbo pallet

You're going to have to start with a stacki frontend. Follow the [Frontend Install New](Frontend-Install-New) but do it on a virtual machine. This gives you a minimal frontend and allows you to create additional pallets.

Once you have the frontend, copy the [stacki 5.0 pallet](http://teradata-stacki.s3.amazonaws.com/release/stacki/5.x/stacki-5.0_20171128_b0ed4e3-redhat7.x86_64.disk1.iso) to your frontend.

Then get whatever OS you want to use. In this example, we're using the rhel-server-7.4-x86_64-dvd.iso available from your RedHat subscription.

cd to the largest directory on the frontend, usually /export.
scp or wget your OS iso to /export.

```
# cd /export
# wget http://teradata-stacki.s3.amazonaws.com/release/stacki/5.x/stacki-5.0_20171128_b0ed4e3-redhat7.x86_64.disk1.iso
```

Create an iso with stacki-5.0_20171128_b0ed4e3-redhat7.x86_64.disk1.iso and rhel-server-7.4-x86_64-dvd.iso `stack create pallet` command.

Using defaults:

```
# stack create pallet stacki-5.0_20171128_b0ed4e3-redhat7.x86_64.disk1.iso rhel-server-7.4-x86_64-dvd.iso
```

You should see this:
```
Building stacki+RHEL-5.0_20171128_b0ed4e3-redhat7.x86_64 ...
	copying stacki
	copying RHEL
Copying RHEL 7.4-redhat7 pallet ...Pallet is 4626.0MB
Building ISO image for disk1
isohybrid: Warning: more than 1024 cylinders: 4634
isohybrid: Not all BIOSes will be able to boot this device
```
And you'll see we have an stacki+RHEL-5.0_20171128_b0ed4e3-redhat7.x86_64.disk1.iso pallet.

```
# ls
isos                            stack
repos                           stacki-5.0_20171128_b0ed4e3-redhat7.x86_64.disk1.iso
rhel-server-7.4-x86_64-dvd.iso  stacki+RHEL-5.0_20171128_b0ed4e3-redhat7.x86_64.disk1.iso
site-pallet
```

This pallet can be used in a [Frontend Install - New](Frontend-Install-New) instead of the stackios pallet to produce a frontend that will have RHEL as it's base OS.

There are options to the 'stack create pallet' that allow you to name (rather than the stacki+whatever*.iso) the pallet or version it.

## Another example

This time we'll added the updates to CentOS 7.4 and the extras and name and version it. The CentOS-Updates and CentOS-Extras pallets were built with `stack create mirror` as per the following commands. (See the [Adding OS Pallets](Adding-OS-Pallets) for enlightenment.)

```
# stack create mirror repoconfig=CentOS-Base.repo repoid=updates name=CentOS-Updates version=20171228
# mv updates/CentOS-Updates-20171228-redhat7.x86_64.disk1.iso ../centos/
# stack create mirror repoconfig=CentOS-Base.repo repoid=extras name=CentOS-Extras version=20171228
# mv extras/CentOS-Extras-20171228-redhat7.x86_64.disk1.iso /export/centos/
```

Now we're going to build a biiiggggggg ISO.
```
# cd /export/centos

# ls
CentOS-7-x86_64-Everything-1708.iso
CentOS-Extras-20171228-redhat7.x86_64.disk1.iso
CentOS-Updates-20171228-redhat7.x86_64.disk1.iso
stacki-5.0_20171128_b0ed4e3-redhat7.x86_64.disk1.iso
```

Just do it already:

```
# stack create pallet *.iso name=stackicentall release=7.4 version=20171228
```

This takes a bit.

Output shows:

```
Building stackicentall-20171228-7.4.x86_64 ...
	copying CentOS
Copying CentOS 7-redhat7 pallet ...
	copying CentOS-Extras
	copying CentOS-Updates
	copying stacki
Pallet is 11013.8MB
Building ISO image for disk1
isohybrid: Warning: more than 1024 cylinders: 11030
isohybrid: Not all BIOSes will be able to boot this device
```

And size wise:
````
# ls -l stackicentall-20171228-7.4.x86_64.disk1.iso
-rw-r--r-- 1 root root 11565793280 Dec 28 15:56 stackicentall-20171228-7.4.x86_64.disk1.iso

# du -sh stackicentall-20171228-7.4.x86_64.disk1.iso
```

That could fit on a USB.

And now you have a very large stacki+OS pallet you can install a new frontend with via virtual media.

**Note:** We can no longer produce and host jumbo isos as we have done in the past. We are an open source project and don't have the right to distribute proprietary OSs (RHEL/Oracle) with Stacki.
