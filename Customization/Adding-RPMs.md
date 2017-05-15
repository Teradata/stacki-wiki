---
layout: page
title: Adding RPMs
permalink: /Adding-RPMs
---

One of the easiest ways to add functionality and customization is to add RPMs to the distribution. There are couple ways to do this - this is the no-brainer, gottagetitworkingrightnow, easy way.

(If you want a bunch of RPMs and they live in a repository somewhere, go to [Creating Simple Pallets](https://github.com/StackIQ/stacki/wiki/Creating-Simple-(Package-based)-Pallets))

##### Adding RPMs

Download the RPM for the application you want.

Add the RPM(s) to:

/export/stack/contrib/default/1.0/x86_64/RPMS/

And then do:
```
# stack create distribution
```

If you want to add them on the fly, i.e. you don't want to reinstall your machines then do:
```
# stack run host "yum clean all && yum -y install <rpmname>" \*
```

on the backend nodes. 

They're also available during installs if you add the name of the package to package tags in the extend-backend.xml.

So in /export/stack/site-profiles/default/1.0/nodes/extend-backend.xml
```
<package>myrpmname</package>
```
_Before_ any `<post> </post>` tags.

##### Example

We frequently have people who want to add machines to an already existing Hadoop cluster elsewhere in their organization. All they want is the Cloudera/Ambari/Hadoopy-thingy agent added to the machines that they've installed with the right partition and storage set-up. 

So do something like this:

% Download the RPM for the application you want.

(We're using Cloudera 5 in this example because that's what's in my browser history already.)

Go to:

http://archive.cloudera.com/cm5/redhat/6/x86_64/cm/5/RPMS/x86_64/

Copy the link address. (Right click?) on cloudera-manager-agent-5.4.5-1.cm545.p0.5.el6.x86_64.rpm.

% On the frontend:
```
# cd /export/stack/contrib/default/1.0/x86_64/RPMS/
# wget http://archive.cloudera.com/cm5/redhat/6/x86_64/cm/5/RPMS/x86_64/cloudera-manager-agent-5.4.5-1.cm545.p0.5.el6.x86_64.rpm
```

% Recreate the distribution
```
# stack create distribution
```

Now it's available. 

% To install it immediately:
```
# stack run host "yum clean all && yum -y install cloudera-manager-agent"
```

% To add it on install/reinstall. 

Add it to /export/stack/site-profiles/default/1.0/nodes/extend-backend.xml:

Before any `<post> </post>` tags, add a package tag:
```
<package>cloudera-manager-agent</package>
```

% Recreate the distribution to get the changes to extend-backend.xml
```
# stack create distribution
```

% Install/reinstall machines. 
```
# stack set host boot backend action=install
# stack run host "reboot"
```

\* Please note the RPM name is usually the text before any versions of the full package name. So cloudera-manager-agent-5.4.5-1.cm545.p0.5.el6.x86_64.rpm is "cloudera-manager-agent." If you don't know the correct name, do any of the following:
```
# yum info cloudera-manager-scm*
(Or, on the file you downloaded)
# rpm -qpl cloudera-manager-agent* 
# rpm -qp --qf  %{NAME} cloudera-manager-agent-5.4.5-1.cm545.p0.5.el6.x86_64.rpm **
```

** Old guy command.
