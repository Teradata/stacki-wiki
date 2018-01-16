## Stacki Repos


The Stacki frontend acts as the yum/zypper/ubuntu repository for all packages you might want on a system.

For instance, the /etc/yum.repos.d/stacki.repo for a set of boxes/pallets on this stacki frontend:

```
# stack list pallet
NAME              VERSION              RELEASE ARCH   OS     BOXES
os                7.4_20171128         redhat7 x86_64 redhat
stacki            5.0_20171128_b0ed4e3 redhat7 x86_64 redhat default rhel74 kaiser
CentOS            7                    redhat7 x86_64 redhat default kaiser
RHEL              7.4                  redhat7 x86_64 redhat rhel74
CentOS-Extras     20171228             redhat7 x86_64 redhat default
CentOS-Updates    20171228             redhat7 x86_64 redhat default
CentOS-Extras     20180104             redhat7 x86_64 redhat kaiser
CentOS-Updates    20180104             redhat7 x86_64 redhat kaiser
stacki-prometheus 2.0.0                7.x     x86_64 redhat default kaiser
epel              20180104             redhat7 x86_64 redhat default kaiser
```

looks like this:

```
# cat /etc/yum.repos.d/stacki.repo
[stacki-5.0_20171128_b0ed4e3-redhat7]
name=stacki 5.0_20171128_b0ed4e3 redhat7
baseurl=http://10.5.1.1/install/pallets/stacki/5.0_20171128_b0ed4e3/redhat7/redhat/x86_64
assumeyes=1
gpgcheck=0
[CentOS-7-redhat7]
name=CentOS 7 redhat7
baseurl=http://10.5.1.1/install/pallets/CentOS/7/redhat7/redhat/x86_64
assumeyes=1
gpgcheck=0
[CentOS-Extras-20171228-redhat7]
name=CentOS-Extras 20171228 redhat7
baseurl=http://10.5.1.1/install/pallets/CentOS-Extras/20171228/redhat7/redhat/x86_64
assumeyes=1
gpgcheck=0
[CentOS-Updates-20171228-redhat7]
name=CentOS-Updates 20171228 redhat7
baseurl=http://10.5.1.1/install/pallets/CentOS-Updates/20171228/redhat7/redhat/x86_64
assumeyes=1
gpgcheck=0
[stacki-prometheus-2.0.0-7.x]
name=stacki-prometheus 2.0.0 7.x
baseurl=http://10.5.1.1/install/pallets/stacki-prometheus/2.0.0/7.x/redhat/x86_64
assumeyes=1
gpgcheck=0
[epel-20180104-redhat7]
name=epel 20180104 redhat7
baseurl=http://10.5.1.1/install/pallets/epel/20180104/redhat7/redhat/x86_64
assumeyes=1
gpgcheck=0
[site-custom-cart]
name=site-custom cart
baseurl=http://10.5.1.1/install/carts/site-custom
assumeyes=1
gpgcheck=0
```

The stacki.repo file gets replicated to the backends and is the repository for any RPMS you may wish to have. Adding additional repositories (like epel or extras) should be done by following the [Adding Software Pallets](Adding-Software-Pallets) guide. This allows easy versioning, updates, etc, without having to have every machine open to the world.

You'll note, that carts are also part of this repository, so packages can be aded in carts and be part of the repository of all the things.

To sync a repository to backends, if you add a new cart  for example, then:

```stack sync host repo a:backend```

and the packages you've added will now be available via yum/zypper/apt-get.
