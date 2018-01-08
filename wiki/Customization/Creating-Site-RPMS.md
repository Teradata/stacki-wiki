### Creating an RPM

Stacki allows you to create a basic RPM for distribution in a cart repository with the ```stack create package``` command.

It's a basic RPM, it allows for files in only one subdirectory, but it allows for versioning and releases.

This enables you to package up a site application and provide it on every backend node.

We'll do an example:

I have a prometheus set-up I like so I'm going to deploy that. It sits in /opt/prometheus.

```
# ls /opt/prometheus/
bin  console_libraries  consoles  dashboards  etc  share
```

This is the command I'm going to use:

```
stack create package dir=/opt/prometheus name=site-prometheus prefix=/opt version=2.0.0  release=7.x rpmextra="Requires: iperf, AutoReqProv: no"
```

Let's unpack it:

Tell the command the directory to turn into an RPM. This would be the SOURCE for an RPM. This says: "tar up this directory and use it"

```
# stack create packages dir=/opt/prometheus
```

Give it a name:

```
# stack create package dir=/opt/prometheus name=site-prometheus
```

Tell it the top level prefeix this should live under:

```
# stack create package dir=/opt/prometheus name=site-prometheus prefix=/opt
```

All the above optiosn are required. Anything else we add, is not.

Give it a version. Default is the current Stacki version, which has a hash in it. Ick. I'm using 2.0.0 because that's the version of prometheus ~~I stole~~ I'm using.

```
# stack create package dir=/opt/prometheus name=site-prometheus prefix=/opt version=2.0.0
```

Add a release, in this case I'm using '7.x' so people who use it know it's built for RHEL/CentOS 7 variants. Default is '1'

```
# stack create package dir=/opt/prometheus name=site-prometheus prefix=/opt version=2.0.0 release=7.x
```

You don't have to add RPM extra options here. This is just to show you can. Comma delimited, make sure you know what you're doing.

```
# stack create package dir=/opt/prometheus name=site-prometheus prefix=/opt version=2.0.0  release=7.x rpmextra="Requires: iperf, AutoReqProv: no"
```

This will barf out a lot of Makefile stuff. At the end, in the current directory you are in, you should have this:

```
# ls
site-prometheus-2.0.0-7.x.x86_64.rpm
```

Now this can be added to any cart in the RPMS directory and installed by adding it to a set of package tags `<stack:package>site-prometheus</stack:package>` and installed on currently running nodes with:

```
# stack run host command="yum clean all; yum -y site-prometheus"
```
