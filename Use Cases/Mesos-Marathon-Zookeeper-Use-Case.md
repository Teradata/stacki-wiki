---
layout: page
title: Mesos Marathon Zookeeper Use Case
permalink: /Mesos-Marathon-Zookeeper-Use-Case
---

This is an example of deploying Mesos/Marathon/Zookeeper using attributes vs. using appliances. You will:
* Download the Mesos, Marathon, and Zookeeper repositories. (We'll throw in the CentOS updates for free.)
* Define attributes (key/value pairs) to segment roles within the Mesos cluster.
* Configure extend-base.xml to deploy a Mesos, Zookeeper, and Marathon master using the attributes.
* Configure extend-base.xml to deploy Mesos slaves. 

This document was initially started from a user question on the Stacki User list. There are number of ways to flay the cluster beast. A pallet is one of them. A pallet is good if you know you're going to be deploying the same application and configuration to multiple clusters that may not have connectivity to your initial frontend. It comes packaged as an ISO so it's easier to pass around to data centers rather than rsync files. Pallets, however, take longer to develop and require knowledge of Makefiles and other such shtuff. Not everyone has that experience so the method I'll explain here is pretty accessible to everyone.

Generally, with a first time install, I don't want to do a pallet because I don't know the full configuration tweaking I will have to do in order to get what I want. So I'm going to do configuration and installation at it's most basic level using an extend-base.xml in the site-profiles directory.  Well sort of basic, I'm actually going to cheat a little because I'm going to pull the Mesosphere, Zookeeper, and Marathon RPMs down as pallets. You'll see what I mean in a minute.This sort of configuration and testing is really the first step in creating a pallet. Once you have a configuration you're pretty sure abstracts to various usage models, creating a pallet is a good thing to do. This configuration only takes into account the backend. If there are set-up steps required on the frontend, you'll have to do that by hand. A pallet would take care of both server (i.e. frontend and backend set-up).

I'm doing this on VirtualBox with a stacki-1.0 frontend and 5 backend nodes. 

##### Get full CentOS and updates

I replace my "os" pallet with the full CentOS DVD1 and DVD2 and then I mirror the updates. Do that, you'll be happier. I know I'll be happier, so if you don't do it for you, do it for me.

% Download the CentOS DVD1 and DVD1 (I don't have to actually show you how to do that do I?)
(Put them in /export. It's probably the largest partition. If you chose "Automatic" for partitioning, it is the larges partition.)

% Add/enable them and disable "os" pallet
```
# stack add pallet CentOS*.iso
# stack enable pallet CentOS
# stack disable pallet os
```

% Get the updates
(Just in case, do a "yum -y install genisoimage" to make sure you have it.)
```
# yum -y install genisoimage
```

% Now mirror
```
# stack create mirror http://vault.centos.org/6.6/updates/x86_64/Packages/ newest=yes version=<date?>
(It's going to take awhile. "version=" should be something that makes sense to you. I use dates, some people use names.)
# breathe/coffee/wake boarding/doughnuts (lots of doughnuts for this one)
(Add it)
# stack add pallet updates*.iso
(Enable it)
# stack enable pallet updates
```


##### Mirror Mesos/Zookeeper/Marathon and all that stuff.

% Install the repo
```
# rpm -Uvh http://repos.mesosphere.io/el/6/noarch/RPMS/mesosphere-el-repo-6-2.noarch.rpm
```

% Disable it
```
# yum-config-manager --disable mesosphere
```
(I'm disabling it because I'm just going to get the RPMs as a pallet, this way it's not in my yum repo until I add it as a pallet or my yum cache.)

% Mirror it
```
# cd /export
(There are two repoids in the mesosphere.repo file. I'll get them both because, hey, why not.)
# stack create mirror repoid=mesosphere newest=true
# stack create mirror repoid=mesosphere-noarch newest=true
```

% Add them as pallets
```
# stack add pallet mesosphere/mesosphere-1.0-0.x86_64.disk1.iso mesosphere-noarch/mesosphere-noarch-1.0-0.x86_64.disk1.iso
```

% Enable them
```
# stack enable pallet mesosphere mesosphere-noarch
```

% Get Zookeeper. 
(We’ll get that from the cloudera-cdh4 because we know that works with CentOS/RedHat 6.6.)
```
# wget http://archive.cloudera.com/cdh4/one-click-install/redhat/6/x86_64/cloudera-cdh-4-0.x86_64.rpm
# rpm -ivh cloudera-cdh-4-0.x86_64.rpm
```

% Mirror Zookeeper
```
# cd /export
(To see what you’re getting without actually downloading.)
# stack create mirror repoid=cloudera-cdh4 newest=true urlonly=true
(To actually download.)
# stack create mirror repoid=cloudera-cdh4 newest=true
# breathe/coffee/tai chi/doughnuts (Max probably 2 unless you eat fast then 3.)
```

% Add the pallets when it’s done
```
# stack add pallet cloudera-cdh4/cloudera*.iso
# stack enable pallet cloudera-cdh4
```

% Get Marathon
```
You already have it. It's in the Mesosphere repo.
```


Now the meso/marathon/chronos rpms should be available to all nodes. But I want to make a distinction between masters and slaves.

There are two approaches. In Greg's response to Michael, he recommended appliances. Mesos is ripe for that kind of logical construct, but I'll go the other way and just use attributes from the database, i.e. key/value pairs because I want it up and working with a minimal understanding of the app. I'll get more experience and can reflect that in better configuration later, something I'll more likely use in a pallet.

I also have to decide if I want to involve the frontend. There is an advantage here because the frontend is the only machine that has full password-less ssh access to every other machine. (You can configure another machine for full password-less access but it's a more advanced set-up.) But the disadvantage is: if you lose the frontend, what happens to the cluster? HPC typically uses the frontend as a login/job submission host and batch manager so with those applications, using the frontend as an integral part of the cluster can make sense. In the past 4-5 years, we've moved away from that model, and view the frontend as the fulcrum for lifting applications into the cluster. It does the heavy lifting at install time, but is tertiary to the running of the actual application. However, if you're short on machines, you may not want to leave an available one out. Only you can decide. 

In this instance I'm going to bypass using the frontend in the Mesos cluster, because, well, I can. If you want to control the cluster from the frontend, there is some info at the end of this article. If you want to include the frontend as a Mesos master or slave, ping me on the Stacki users list, and I/we can help with that. 

Onward: We’ll need to create some key/value pairs to use in the extend-backend.xml to configure the cluster, some will be global and some host level. Remember, key/values go in order of G(lobal) A(ppliance) and H(host). Last one wins. 

% Define two arbitrary key/value pairs, one for slave, one for masters

(The first two are global attrs set to false, which is default.)
```
# stack set attr attr=is_mesos_master value=false
# stack set attr attr=is_mesos_slave value=false
```

(Now set the host level attribute to true for the required role.)
```
# stack set host attr backend-0-0 attr=is_mesos_master  value=true
# stack set host attr backend-0-[1-4] attr=is_mesos_slave  value=true
```
So backend-0-[1-4] will be slaves, and backend-0-0 is a master.

Like any good mathematical proof, we’ll erase all the work I did to get to the following steps and just present the solution. It looks like magic, it’s not. It's a lot of duckduckgoing and stackoverflowing (and yes, I'm coining those words) because I found the actual Mesos and Marathon docs a little opaque when it came to RHEL/CentOS. (Can someone please explain Ubuntu to me? I've used it; I just don't get it.)

I based this basic configuration off of this [blogpost](http://manfrix.blogspot.com/2015/02/apache-mesos-when-all-becomes-one.html) by Daniel Yeap. Basically it gets Mesos up and running, nothing fancy. Fancy is later.

This was all kinds of awesome because the Mesos and Marathon docs just don’t really help much.

So we need a couple of other key/value pairs we’re going to use:
```
(I'm defaulting to the master ip here.)
# stack add attr attr=zookeeper_ip value=10.1.255.254 
(I wracked my imagination for this one.)
# stack add attr attr=mesos_cluster_name value=MesosCluster
```

##### Set-up the extend-backend.xml to install Mesos/Marathon/Zookeeper.

Following are the contents of my extend-base.xml. (I know, I said extend-backend.xml but it turns out if you want to have your code be the absolute last thing to run for a backend node [and I usually do, will go to great lengths to assure that it does], you should extend the base.xml and not the backend.xml. The rest of the engineering team will probably yell at me. It’s okay, I have a thick skin and it never lasts long because I’m so damn adorable.) 

So this is from my /export/stack/site-profiles/default/1.0/nodes/extend-base.xml:

```xml
<?xml version="1.0" standalone="no"?>

<kickstart>

<description>
</description>

<package>mesos</package>
<package cond="is_mesos_master">marathon</package>
<package cond="is_mesos_master">zookeeper-server</package>


<post cond="is_mesos_master">
mv /etc/init/mesos-slave.conf /etc/init/mesos-slave.conf.disabled

<file name="/etc/mesos-master/ip">
&hostaddr;
</file>

<file name="/etc/mesos-master/cluster">
&mesos_cluster_name;
</file>

service zookeeper-server init
echo 1 &gt; /var/lib/zookeeper/myid

chkconfig zookeeper-server on
</post>

<post cond="is_mesos_slave">
mv /etc/init/mesos-master.conf /etc/init/mesos-master.conf.disabled

<file name="/etc/mesos-slave/ip">
&hostaddr;
</file>
</post>

<post>
<file name="/etc/mesos/zk">
zk://&zookeeper_ip;:2181/mesos
</file>
</post>

</kickstart>
```

But lets go through it:

The fun starts at the package tags:

(Everything has to have the Mesos so we’ll put it everywhere.)
```xml
<package>mesos</package>
```

(Only the mesos master needs marathon and zookeeper, we can do more complex
setup with zookeeper, but for now we’ll just put it on the Mesos master. 
The "cond=" says only add this package if the "is_mesos_master" value is true so these rpms won't be on the slaves.

```xml
<package cond="is_mesos_master">marathon</package>
<package cond="is_mesos_master">zookeeper-server</package>
```

% Now the <post></post> tags which map to the %post part of a kickstart file.

If the is_mesos_master evaluates to “True” we’re going to do the following:
```xml
<post cond="is_mesos_master">
<!— get rid of the mesos.slave —>
mv /etc/init/mesos-slave.conf /etc/init/mesos-slave.conf.disabled
```

(Set the master ip. The <file></file> tags essentially wrap the syntax everyone uses everywhere):
```
cat >> somefile << EOF
stuff
EOF
```

(The &hostaddr; entity maps to the installing node's ip address in the same way &hostname; maps to the 
installing node's hostname. We’ve defined those for you, because we’re awesome like that. [No sorry, really,
we needed a shortcut, you just get to benefit.])
```xml
<file name="/etc/mesos-master/ip">
&hostaddr;
</file>
```

(Give the cluster a name and call it from the key/value pair we defined
use the xml entity tag syntax to do this)
```xml
<file name="/etc/mesos-master/cluster">
&mesos_cluster_name;
</file>
```

(Initialize zookeeper and make sure it starts at boot.)
```xml
service zookeeper-server init
echo 1 &gt; /var/lib/zookeeper/myid
chkconfig zookeeper-server on
</post>
```

The slave post config:
Same stuff, only do this if is_mesos_slave evalutes to True.
```xml
<post cond="is_mesos_slave">
<!— dont’ start a master here —>
mv /etc/init/mesos-master.conf /etc/init/mesos-master.conf.disabled

<!— make sure my slave ip is in the right file —>
<file name="/etc/mesos-slave/ip">
&hostaddr;
</file>
</post>
```

The following is for both the master and the slave so we don’t put a conditional on it:
```xml
<post>
<!— set where the zookeeper runs currently is the mesos master too —>
<file name="/etc/mesos/zk">
zk://&zookeeper_ip;:2181/mesos
</file>
</post>
```

This way we can use one file and a set of attributes to create different roles within the cluster. An appliance based configuration would have separate xml files for each type of appliance (say, mesos-master and mesos-slave). The xml files would only contain kickstart configuration for only those roles. Doing it the way I'm showing you gives you one file for all configuration, but it can get really big and really confusing very fast.

If I were to put this in a pallet, I would create appliances and configuration for each individual roles. However, I would do that once I've fleshed out those functions in the manner this document demonstrates.

Okay, more:

% Check your extend-base.xml for errors.
```
# xmllint extend-base.xml
```

You should only see Entity errors because the parser doesn’t resolve key/value pairs. Parsing errors or syntax errors need to be fixed.

Test the profile:
```
# stack list host profile backend-0-0 
```
Which should not give you errors. It's usually something vomitous if it does error out. If you see this:
```xml
cat >> /etc/sysconfig/stack-post << '__EOF__'

rm -f /tmp/ks-script*

__EOF__

]]>
</section>
</profile>
```

as final output. You're likely good. If your compute nodes stall at the "Choose A Language" screen, something is wrong with your xml. No, really, something is wrong with your xml. 

% Set your nodes to install
```
# stack set host backend action=install
```

% Reboot ‘em to install ‘em
```
# stack run host backend “reboot"
# breathe/coffee/tai chi/doughnuts
```

When you come back from the above, you should be able to go to http://masternodeip:5050 and you’ll have a mesos cluster. Should be a few slaves, there should be a marathon framework under “Frameworks."

This is a basic Mesos install. There are lots of knobs to twiddle, you can reflect that in the extend-base.xml by expanding that. If you're hard-coding something in your xml configuration, consider an attribute. 

If you would really like to see this with appliances rather than key/value pairs. I'm happy to do that, just let me know. 

##### Control Mesos from the frontend

If you want to control the cluster from the frontend, Mesos supplies some scripts for that in /usr/sbin.

% On the frontend, install mesos:
```
# yum -y install mesos
```

% Disable both the master and the slave configuration as in the above extend-base.xml so it doesn’t start on boot. 

Now you can use:
```
/usr/sbin/mesos-start-cluster.sh
/usr/sbin/mesos-start-masters.sh
/usr/sbin/mesos-start-slaves.sh
/usr/sbin/mesos-stop-cluster.sh
/usr/sbin/mesos-stop-masters.sh
/usr/sbin/mesos-stop-slaves.sh
```

To manage the cluster/master/slaves. 

But to do that you need to create /usr/etc/mesos/masters and /usr/etc/mesos/slaves. Here’s a basic python script that does it, using the Stacki api. Not pretty but works and gives you a small idea of the kind of thing you can do as standalone scripts or within kickstart to get information you need.

```python
#!/opt/stack/bin/python

import stack.api
import os

sfile = open('/usr/etc/mesos/slaves', 'w+')
mfile  = open('/usr/etc/mesos/masters', 'w+')
masters = stack.api.Call('list.host.attr',['backend','attr=is_mesos_master'])
slaves = stack.api.Call('list.host.attr',['backend','attr=is_mesos_slave'])
for s in slaves:
    if s['value'] in [ 'True', 'true']:
        sfile.write('%s\n' % s['host'])
for m in masters:
    if m['value'] in [ 'True', 'true']:
        mfile.write('%s\n' % m['host'])
```


It’s also possible to make the frontend the master or a slave by setting it’s key/value pair for the is_mesos_master or is_mesos_slave to true for the role you want it to play. In general I don’t recommend that. Let the frontend do what the frontend does and leave the rest to do it’s thing. But I get it if you're low on machines. 

Please post questions to the list. If there is more info you think you need here, Use the List. 
