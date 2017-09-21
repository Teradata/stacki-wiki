## Prepare the Server

Stacki can either be built on an existing Stacki Frontend, or on the fresh install of a CentOS or SLES machine.  Ensure you have an adequate amount of space to build, somewhere on the order of 10GB.

### Frontend Server

If you are using a Stacki Frontend as your build host you will need to add an OS pallet to configure the local software repositories.  This is required as a default Stacki install will build a Frontend with only a minimal OS pallet missing many of the prerequisites for building Stacki.

#### CentOS Frontend

Download [CentOS 7.4](http://isoredirect.centos.org/centos/7/isos/x86_64/CentOS-7-x86_64-Everything-1708.iso).

```
# stack add pallet CentOS-7-x86_64-Everything-1708.iso
# stack enable pallet CentOS
# stack disable pallet os
```

#### SLES Frontend

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

Start with a fresh install of SLES 12, using the default desktop/workstation "system role".  If you do not have access to the remote SLES zypper repositories, you need to add the install ISO and the first SDK ISO as repos.

```
zypper ar iso:/?iso=/export/SLE-12-SP2-Server-DVD-x86_64-GM-DVD1.iso install_dvd
zypper ar iso:/?iso=/export/SLE-12-SP2-SDK-DVD-x86_64-GM-DVD1.iso sdk_dvd
```

## Grab the Source

Log into your build server and checkout the repository somewhere in /export (its a large repo).  Install `git`, if it isn't already on your system.

```
# mkdir /export/src
# cd /export/src
# git clone git@github.com:Teradata/stacki.git
```

*Note: These instructions assume you have commit access to the
[Teradata/stacki.git](https://github.com/Teradata/stacki) repository,
if you do not please
[fork](https://help.github.com/articles/fork-a-repo/) the repository
first, and then clone from your fork.*


## Bootstrap and Build

*Note: Make and our build system are very sensitive to time.  Ensure your build server's time is set correctly before starting these steps.*

```
# cd /export/src/stacki/centos (or sles)
# make bootstrap
```

This will complete and tell you to log out and log in again, follow the directions and then restart the bootstrap.  You can skip the log out/log in by running `source /etc/profile.d/stack-build.sh`.

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

