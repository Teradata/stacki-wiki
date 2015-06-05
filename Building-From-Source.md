Once you build your first Stacki Frontend you can now start working with the source code.
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

```
# cd /export/src/stacki
# git pull
```

## Setup Yum for CentOS and Updates

Building Stacki requires several packages not included in the base install of the Frontend, so we
must configure yum to have access to the complete and updated CentOS packages.
Create the following two files:

```
# cat /etc/yum.repos.d/centos.repo
[centos]
name=centos
baseurl=http://mirror.lax.hugeserver.com/centos/6/os/x86_64
assumeyes=1
```

```
# cat /etc/yum.repos.d/updates.repo 
[updates]
name=updates
baseurl=http://mirror.lax.hugeserver.com/centos/6/updates/x86_64
assumeyes=1
```

After these files are in place clean out the yum cache with:

```
yum clean all
```

## Bootstrap the Pallet

Now with access to any missing RPMs we can prepare to compile the entire Stacki pallet by bootstrapping it.

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

This will take a long time, there is a log of software to build.
When done you can verify the build with:

```
# make manifest-check
```

This will report any packages that failed to build.
