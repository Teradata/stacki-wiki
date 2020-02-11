## Prepare the Server

Stacki can be built using a tool called `iso-builder`, on an existing Stacki Frontend, or on the fresh install of a CentOS or SLES machine.  Ensure you have an adequate amount of space to build, somewhere on the order of 10GB.

### Iso Builder

The `iso-builder` tool uses Vagrant to spin up a VM and build the ISO file inside based on the local copy of the source code.

Assuming you have Vagrant installed, with either Virtualbox or Libvirt/KVM, simply change into the `tools/iso-builder` directory. Then run:
```
PLATFORM=redhat7 vagrant up
```

This will bring up a VM and build the pallet, which will end up in the root of the project. The build process currently takes about 45 minutes.

You can then run `vagrant destroy -f` to clean up the iso-builder VM.

Further information about `iso-builder` came be found at: https://github.com/Teradata/stacki/tree/master/tools/iso-builder

### Frontend Server

If you are using a Stacki Frontend as your build host you will need to add an OS pallet to configure the local software repositories.  This is required as a default Stacki install will build a Frontend with only a minimal OS pallet missing many of the prerequisites for building Stacki.

#### CentOS Frontend

Download [CentOS 7.6](http://archive.kernel.org/centos-vault/7.6.1810/isos/x86_64/CentOS-7-x86_64-Everything-1810.iso).

```
# stack add pallet CentOS-7-x86_64-Everything-1810.iso
# stack enable pallet CentOS
# stack disable pallet os
```

#### SLES Frontend

```
# ?
```


### Freshly Installed Server

#### CentOS

Start with a fresh install of [CentOS 7.6](http://archive.kernel.org/centos-vault/7.6.1810/isos/x86_64/CentOS-7-x86_64-Everything-1810.iso) using the default "minimal" package selection. You should also configure the network to have access to remote yum repositories.

#### SLES

##### 12SP3

Start with a fresh install of SLES 12, using the default desktop/workstation "system role".  If you do not have access to the remote SLES zypper repositories, you need to add the install ISO and the first SDK ISO as repos.

```
zypper ar iso:/?iso=/export/SLE-12-SP3-Server-DVD-x86_64-GM-DVD1.iso install_dvd
zypper ar iso:/?iso=/export/SLE-12-SP3-SDK-DVD-x86_64-GM-DVD1.iso sdk_dvd
```

##### 11SP3

Start with a fresh install of SLES 11, using the default package set. By default you will not be connected to external repositories and you must add the install ISO and SDK ISO as repos.

```
zypper ar iso:/?iso=/export/SLES-11-SP3-DVD-x86_64-GM-DVD1.iso install_dvd
zypper ar iso:/?iso=/export/SLE-11-SP3-SDK-DVD-x86_64-GM-DVD1.iso sdk_dvd
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
# cd /export/src/stacki/
# make bootstrap
```

This will complete quickly and tell you to log out and log in again, follow the directions and then restart the bootstrap.  You can skip the log out/log in by running `source /etc/profile.d/stack-build.sh`.

```
# make bootstrap
# make
# make manifest-check
```

This should leave you with a .iso file in the ./build-stacki-$BRANCH_NAME directory, and the
manifest-check should report all the packages were built.



## Contribute Code

If you've made changes that you want to share with all of Stacki [send us a pull request](https://github.com/Teradata/stacki/pulls).

