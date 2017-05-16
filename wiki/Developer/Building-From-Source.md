Once you build your first Stacki frontend you can now start working with the source code.
All development on Stacki is assumed to be done on a Stacki Frontend that you have root access on.
This page walks you through the steps required to start developing on the code.

## Checkout Repository

Log into your Frontend and checkout the repository somewhere in /export (its a large repo).

```
# mkdir /export/src
# cd /export/src
# git clone git@github.com:StackIQ/stacki.git
```

If you have an existing repository, you should also pull the latest code from the develop branch.

These instructions assume you have commit access to the Stacki/stacki.git repository, if you do not
please [fork](https://help.github.com/articles/fork-a-repo/) the repository first,
and then clone from your fork.

```
# cd /export/src/stacki
# git pull
```

## Setup Yum for CentOS and Updates

Building Stacki requires several packages not included in the base install of the frontend, so we
must configure yum to have access to the complete and updated CentOS packages.  The easiest way to do this is to grab the [latest CentOS "Everything" ISO](http://isoredirect.centos.org/centos/7/isos/x86_64/CentOS-7-x86_64-Everything-1611.iso), and the [latest CentOS-Updates pallet](http://stacki.s3.amazonaws.com/public/os/centos/7/CentOS-Updates-7.3_20170503-7.x.x86_64.disk1.iso) provided by Stacki.

Add and enable the pallets:

```
# stack add pallet CentOS-7-x86_64-Everything-1611.iso
# stack add pallet CentOS-Updates-7.3_20170503-7.x.x86_64.disk1.iso
# stack enable pallet CentOS CentOS-Updates
```

## Bootstrap the Pallet

Now with access to any missing RPMs we can prepare to compile the entire Stacki pallet by bootstrapping it.  This will take a long time.

```
# cd /export/src/stacki
# make bootstrap
# exit
```

Note the ```exit``` command which will log you out of the hosts.
Now when you log back in your environment will be setup correctly to compile Stacki.

## Build the Pallet

```
# cd /export/src/stacki
# make
```

This will take a long time, there is a lot of software to build.
When done you can verify the build with:

```
# make manifest-check
```

This will report any packages that failed to build.

## Contribute Code

If you've made changes that you want to share with all of Stacki [send us a pull request](https://github.com/StackIQ/stacki/pulls).

