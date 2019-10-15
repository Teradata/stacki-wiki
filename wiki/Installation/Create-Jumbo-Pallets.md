## Create Jumbo pallets

A "Jumbo Pallet" is a pallet that consists of combining the Stacki pallet with the OS pallet of your choice to install a frontend.

It's possible to add additional pallets, but the size grows and can easily be larger than a DVD or even a smallish USB can hold.

If you're going to create and use a jumbo pallet, it's advised to install the frontend via virtual media since this does not suffer from size issues.

This is only for a frontend so it contains the same OS that you want on the backends.

##  Create a Jumbo pallet

You're going to have to start with a stacki frontend. Follow the [Frontend Install New](Frontend-Install-New) but do it on a virtual machine. This gives you a minimal frontend and allows you to create additional pallets.

Once you have the frontend, copy the [stacki 5.4 pallet](https://github.com/Teradata/stacki/releases/download/stacki-5.4/stacki-5.4-redhat7.x86_64.disk1.iso) to your frontend.

Then get whatever OS you want to use. In this example, we're using the rhel-server-7.4-x86_64-dvd.iso available from your RedHat subscription.

cd to the largest directory on the frontend, usually /export.
scp or wget your OS iso to /export.

```
# cd /export
# wget https://github.com/Teradata/stacki/releases/download/stacki-5.4/stacki-5.4-redhat7.x86_64.disk1.iso
# wget http://archive.kernel.org/centos-vault/7.6.1810/isos/x86_64/CentOS-7-x86_64-DVD-1810.iso
```

Create an iso with with both the Stacki and CentOS inside, using defaults:

```
# stack create pallet stacki-5.4-redhat7.x86_64.disk1.iso CentOS-7-x86_64-DVD-1810.iso
```

You should see this:
```
Building stacki+CentOS-5.4_20191004_a246ab2-redhat7.x86_64 ...
	copying stacki
	copying CentOS
Copying CentOS 7-redhat7 pallet ...
Pallet is 4951.3MB
Building ISO image for disk1
```
And you'll see we have a stacki+CentOS-5.4_20191004_a246ab2-redhat7.x86_64.disk1.iso pallet.

```
# ls *.iso
CentOS-7-x86_64-DVD-1810.iso                 stacki+CentOS-5.4_20191004_a246ab2-redhat7.x86_64.disk1.iso
stacki-5.4-redhat7.x86_64.disk1.iso
```

This pallet can be used in a [Frontend Install - New](Frontend-Install-New) instead of the stackios pallet to produce a frontend that will have Centos 7.6 as it's base OS.

There are options to the 'stack create pallet' that allow you to name (rather than the stacki+whatever*.iso) the pallet or version it.
