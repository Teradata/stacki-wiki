If you already have access to a Stacki Frontend you can use it as your build host.
This will be the quickest method to get started since all the Stacki required services are already configured and running.
It is also possible to build Stacki on a freshly installed server.

## Grab the Source

Log into your Frontend and checkout the repository somewhere in /export (its a large repo).

```
# mkdir /export/src
# cd /export/src
# git clone git@github.com:Teradata/stacki.git
```

These instructions assume you have commit access to the
[Teradata/stacki.git](https://github.com/Teradata/stacki) repository,
if you do not please
[fork](https://help.github.com/articles/fork-a-repo/) the repository
first, and then clone from your fork.

## Prepare the Server

### Frontend Server

If you are using a Stacki Frontend as your build host you will need to
add an OS pallet to configure the local software repositories.  This
is required as a default Stacki install will build a Frontend with
only a minimal OS pallet missing many of the prerequisites for
building Stacki.

#### CentOS

Download [CentOS 7.4](http://isoredirect.centos.org/centos/7/isos/x86_64/CentOS-7-x86_64-Everything-1708.iso).

```
# stack add pallet CentOS-7-x86_64-Everything-1708.iso
# stack enable pallet CentOS
# stack disable pallet os
```

#### SLES

```
# ?
```


### Freshly Installed Server

#### CentOS

Start with a fresh install of [CentOS
7.4](http://isoredirect.centos.org/centos/7/isos/x86_64/CentOS-7-x86_64-Everything-1708.iso)
using the default "minimal" package selection. You should also
configure the network to have access to remote yum repositories.

#### SLES

?


## Bootstrap and Build

```
# cd /export/src/stacki/centos (or sles)
# make bootstrap
```

This will complete and tell you to log out and log in again, follow the directions and then restart the bootstrap.

```
# cd /export/src/stacki/centos (or sles)
# make bootstrap
# make
# make manifest-check
```

This should leave you with a .iso file in the build directory, and the
manifest-check should report all the packages were built.



## Contribute Code

If you've made changes that you want to share with all of Stacki [send us a pull request](https://github.com/Teradata/stacki/pulls).

