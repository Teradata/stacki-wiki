![stacki logo](https://github.com/StackIQ/stacki/blob/master/logo.png?raw=true)

Welcome to **Stacki**.

Our goal is to make fast, repeatable, and adaptable Linux installations not only possible, but easy.

It is quick and easy to get started spinning up Linux servers with
Stacki, and advanced features let you go deeper and deeper into
customizing installations so they are better suited for your unique environment.


## What is it?

Stacki is a bare metal install tool that can take your server from bare hardware (or virtual hardware) to working Linux, ready for you to install your applications.
Stacki does this at scale, so deploying 100 servers is no more complex (and barely slower) than deploying one.
Advanced users can even have Stacki install their applications.
Stacki has a long [history](#origins), and is in use at some of the most demanding organizations in the world.
The commercial version of Stacki is used by Fortune 500 companies to maintain their cloud and big data clusters, so it has definitely seen its share of production use.

What it does is simple:

1. Configure RAID controllers and partitioning (both customizable).

2. Install OS.

3. Configure OS.

4. Configure networking.

5. Leave you to be productive, to focus on more interesting problems.

With Stacki, you cam make machines disposable.
Everything is built from the ground up programmatically so recovering from disasters means just rebuilding the infrastructure.

Stacki delivers certainty. If you're configuring individual machines on a daily basis without automation, you're losing. Our goal is to keep you off of your servers and away from the question "what state are my servers in?", because you'll always know.

Once Stacki is done, you can augment it with your favorite configuration toolset - be it Salt, Chef, Puppet, CFEngine, Ansible, or homegrown - so you don't have throw away work you've already done. 


## Origins

Long before devops and webscale we were building world class [supercomputers](http://www.sdsc.edu) made from simple Linux boxes.
The hardware was cheap, but the complexity at scale killed us.
So we helped create the [Rocks](http://www.rocksclusters.org) toolkit to automate the deployment of high performance computing clusters.
Along the way we, co-founders, developers, and users of Rocks, started [StackIQ](http://www.stackiq.com) to build upon the Rocks software and make it appropriate for the enterprise.
The lessons we've learned from large scale HPC and enterprise computing are now yours as part of Stacki.

### Open Source<a name="license"></a>

Stacki is released as open source with a combination of licenses.
StackiQ forked the Rocks project source code in 2010 and maintains the original copyright to this code.
As such the two primary licenses are for [Stacki](Stacki-License) and [Rocks](Rocks-license) source,
both are based on the traditional BSD attribution license.
Stacki also includes several third party open source packages each with their own copyrights.
Details on these are found in the [source tree](https://github.com/StackiQ/stacki).


## Linux

Stacki supports RedHat and its variants.
We generally develop on CentOS but we always test on RHEL to give you the choice of platform

## Applications

Every application from big data to cloud requires real electrons on real silicon. This is a short list of what we've used Stacki to install for clients large and small. If you can do it in Linux, Stacki can automate it over 1000s of machines. 

* Big Data: Cloudera, Hortonworks, MapR, Pivotal, BigInsights, Spark, Storm, Cassandra, MongoDB, RabbitMQ, R, Mesos
* Cloud: OpenStack, CloudStack, VMWare
* HPC: Torque, Slurm, MOAB, MPI, UGE/OGS/SGE, PBS, CUDA, LSF, PGI
* Misc: CoreOS, ESXI, Puppet, Ansible, Chef, Salt, Ceph, CFEngine, GPFS, Intel Developer Tools, VirtualBox