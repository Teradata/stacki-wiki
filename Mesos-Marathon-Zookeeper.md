This is an example of deploying Mesos/Marathon/Zookeeper using attributes vs. using appliances. You will:
* Download the Mesos, Marathon, and Zookeeper repositories. (We'll throw in the updates for free.)
* Define attributes (key/value pairs) to segment roles within the Mesos cluster.
* Configure extend-base.xml to deploy a Mesos, Zookeeper, and Marathon master using the attributes.
* Configure extend-base.xml to deploy Mesos slaves. 

This document was initially started from a user question on the Stacki User list. There are number of ways to flay the cluster beast. A pallet is one of them. A pallet is good if you know you're going to be deploying the same configuration to multiple clusters that may not have connectivity to your initial frontend. It comes packaged as an ISO so it's easier to pass around to data centers rather than rsync files.

Generally, with a first time install, I don't want to do a pallet because I don't know the full configuration tweaking I will have to do in order to get what I want. So I'm going to do configuration and installation at it's most basic level using an extend-base.xml in the site-profiles directory.  Well sort of basic, I'm actually going to cheat a little because I'm going to pull the Mesosphere, Zookeeper, and Marathon RPMs down as a pallet. You'll see what I mean in a minute.

I'm doing this on VirtualBox, a stacki-1.0 frontend and 5 backend nodes. 

% Mirror Mesos and all that stuff.

% Install the repo
# rpm -Uvh http://repos.mesosphere.io/el/6/noarch/RPMS/mesosphere-el-repo-6-2.noarch.rpm

% Disable it
# yum-config-manager --disable mesosphere
(I'm disabling it because I'm just going to get the RPMs as a pallet, this way it's not in my yum cache.)

% Mirror it
# cd /export

(There are two repoids in the mesosphere.repo file. I'll get them both because, hey, why not.)

# stack create mirror repoid=mesosphere newest=true
# stack create mirror repoid=mesosphere-noarch newest=true

% Add them as pallets

# stack add pallet mesosphere/mesosphere-1.0-0.x86_64.disk1.iso mesosphere-noarch/mesosphere-noarch-1.0-0.x86_64.disk1.iso

% Enable them

# stack enable pallet mesosphere mesosphere-noarch

You also need Zookeeper. We’ll get that from the cloudera-cdh4 because we know that works with CentOS/RedHat 6.6.

wget http://archive.cloudera.com/cdh4/one-click-install/redhat/6/x86_64/cloudera-cdh-4-0.x86_64.rpm
rpm -ivh cloudera-cdh-4-0.x86_64.rpm
cd /export
stack create mirror repoid=cloudera-cdh4 newest=true urlonly=true # to see what you’re getting
stack create mirror repoid=cloudera-cdh4 newest=true # to get it
breathe/coffee/exercise/doughnut
when it’s done
stack add pallet cloudera-cdh4/cloudera*.iso
stack enable pallet cloudera-cdh4
stack create distribution

% Create distribution

# stack create distribution

Now the meso/marathon/chronos rpms should be available to all nodes. But I want to make a distinction between masters and slaves, and I need to populate /usr/etc/mesos/masters and /usr/etc/mesos/slaves files, and I don't want to do that by hand. 

There are two approaches. In Greg's response to Michael, he recommended appliances. Mesos is ripe for that kind of logical construct, but I'll go the other way and just use attributes from the database, i.e. key/value pairs. 

I also have to decide if I want to involve the frontend. There is an advantage here because the frontend is the only machine that has full passwordless ssh access to every other machine. But the disadvantage is, if you lose the frontend, what happens to the cluster?*

In this instance I'm going to bypass using the frontend in the mesos cluster, because, well, I can. If you want to control the cluster from the frontend, please see the appendix below.

 
We’ll need to create some key/value pairs to use in the extend-backend.xml to configure the cluster, some will be global and some host level. Remember, key/values go in order of G(lobal) A(ppliance) and H(host). Last one wins. 

% Define two arbitrary key/value pairs, one for slave, one for masters

(The first two are global attrs set to false, which is default.)
# stack set attr attr=is_mesos_master value=false
# stack set attr attr=is_mesos_slave value=false

(Now set the host level attribute to true for the required role.)
# stack set host attr backend-0-0 attr=is_mesos_master  value=true
# stack set host attr backend-0-[1-4] attr=is_mesos_slave  value=true

So backend-0-[1-4] will be slaves, and backend-0-0 is a master.

Like any good mathematical proof, we’ll erase all the work I got to get to the following steps and just present the solution. It looks like magic, it’s not.

I based this basic configuration off of here:

http://manfrix.blogspot.com/2015/02/apache-mesos-when-all-becomes-one.html

Which was all kinds of awesome because the Mesos and Marathon docs just don’t really help much.

So we need a couple of other key/value pairs we’re going to use:

# stack add attr attr=zookeeper_ip value=10.1.255.254 # defaulting to the master ip.
# stack add attr attr=mesos_cluster_name value=MesosCluster # Really imaginative right?

Now set-up our extend-backend.xml to install mesos and add themselves to the appropriate file on the frontend.

These are the contents of my extend-base.xml. (I know, I said extend-backend.xml but it turns out if you want to have your code be the absolute last thing to run for a backend node (and I usually do, will go to great lengths to assure that it does), you should extend the base.xml and not the backend.xml. The rest of the engineering team will probably yell at me. It’s okay, I have a thick skin and it never lasts long because I’m so damn adorable.) 

so this is from my /export/stack/site-profiles/default/1.0/nodes/extend-base.xml

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

But lets go through it:

The fun starts here:

<!— everything has to have mesos so we’ll put it everywhere —>
<package>mesos</package>

<!— only the mesos master needs marathon and zookeeper, we can do more complex
setup with zookeeper, but for now we’ll just put it on the master —>
<package cond="is_mesos_master">marathon</package>
<package cond="is_mesos_master">zookeeper-server</package>

Post tags:

If the is_mesos_master evaluates to “True” we’re going to do the following:

<post cond="is_mesos_master">
<!— get rid of the mesos.slave —>
mv /etc/init/mesos-slave.conf /etc/init/mesos-slave.conf.disabled

<!— set the master ip the <file></file> tags essentially wrap the syntax everyone uses everywhere
cat >> somefile << EOF
stuff
EOF
—>
<!— &hostaddr; maps to the installing node's ip address in the same way &hostname; maps to the 
installing nodes hostname. We’ve defined those for you, because we’re awesome like that. (No really,
we needed a shortcut, you just get to benefit.) —>

<file name="/etc/mesos-master/ip">
&hostaddr;
</file>

<!— give the cluster a name and call it from the key/value pair we defined
use the xml entity tag syntax to do this —>
<file name="/etc/mesos-master/cluster">
&mesos_cluster_name;
</file>
<!— initialize zookeeper and make sure it starts at boot —>
service zookeeper-server init
echo 1 &gt; /var/lib/zookeeper/myid

chkconfig zookeeper-server on
</post>

The slave post config:
Same stuff, only do this is is_mesos_slave evalutes to True.

<post cond="is_mesos_slave">
<!— dont’ start a master here —>
mv /etc/init/mesos-master.conf /etc/init/mesos-master.conf.disabled

<!— make sure my slave ip is in the right file —>
<file name="/etc/mesos-slave/ip">
&hostaddr;
</file>
</post>

This is for both the master and the slave so we don’t put a conditional on it:

<post>
<!— set where the zookeeper runs currently is the mesos master too —>
<file name="/etc/mesos/zk">
zk://&zookeeper_ip;:2181/mesos
</file>
</post>

Check it:
xmllint extend-base.xml

You should only see Entity errors because the parser doesn’t resolve key/value pairs. 

So now that you have your extend-base. xml recreate the distribution:
# stack create distribution

Test the profile:
# stack list host profile backend-0-0 
should not give you errors.

set your nodes to install
# stack set host backend action=install
reboot ‘em to install ‘em
# stack run host backend “reboot"

Breathe/coffee/exercise/doughnut

When you come back from the above, you should be able to go to http://masternodeip:5050 and you’ll have a mesos cluster. Should be a few slaves, there should be a marathon framework under “Frameworks"

This is a basic Mesos install. There are lots of knobs to twiddle, you can reflect that the extend-base.xml by expanding that.

If you would really like to see this with appliances rather than key/value pairs. I'm happy to do that, just let me know. 

If you want to control the cluster from the frontend, Mesos supplies some scripts for that in /usr/sbin.

On the frontend, install mesos:

# yum -y install mesos

Disable both the master and the slave configuration as in the above extend-base.xml so it doesn’t start on boot. 

Now you can use
/usr/sbin/mesos-start-cluster.sh
/usr/sbin/mesos-start-masters.sh
/usr/sbin/mesos-start-slaves.sh
/usr/sbin/mesos-stop-cluster.sh
/usr/sbin/mesos-stop-masters.sh
/usr/sbin/mesos-stop-slaves.sh

To manage the cluster/master/slaves. 

But to do that you need to create /usr/etc/mesos/masters and /usr/etc/mesos/slaves. Here’s a basic python script that does it, using the Stacki api. Not pretty but works.

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



It’s also possible to make the frontend the master or a slave by setting it’s key/value pair for the roll, in general I don’t recommend that. Let the frontend do what the frontend does and leave the rest to do it’s thing. 

Footnotes:

* Okay, here is a whole different discussion. Do you involve the frontend in the cluster? The main advantage to doing so is password-less ssh access everywhere. The main disadvantage is the frontend is part of the application. We have been of two minds on this in the past 15+ years. Keep the function of the frontend to deployment, central management, and monitoring and put applications up with any master server and it's backend nodes to run your application. If the stacki frontend disappears, the application still runs, but then you have to configure SSH access from the master application server to the other backend nodes. Not difficult but has to be accommodated. Otherwise, use the frontend as the application master node and live with the fact that it is. I like to think of the frontend as the fulcrum from which you lift application infrastructure. But it's also easier to have the frontend to be part of the application because of it's access. Your call. 
