![stacki logo](https://github.com/StackIQ/stacki/blob/master/logo.png?raw=true)

Welcome to **Stacki**.

Automation and consistency across Linux infrastructure is hard. Our goal is to make Linux installations of heterogeneous hardware across 10s to 1000s of machines fast, flexible, and absolutely consistent.

The Stacki default installation process will bring baremetal infrastructure (or VMs) to a ping and a prompt. The frontend machine has SSH password-less access at first boot, and the distribution on the frontend acts as the YUM repository for all backend machines. 

It is quick and easy to get started spinning up Linux servers with
Stacki, and advanced features let you go deeper into
customizing installations so they are better suited for your unique environment.


## What is it?

Stacki is a bare metal install tool that can take your servers from bare hardware (or virtual hardware) to working Linux, ready for you to install your applications.
Stacki does this at scale, so deploying 100 servers is no more complex than deploying one.
Advanced users can even have Stacki install their applications.
Stacki has a long [history](#origins), and is in use at some of the most demanding organizations in the world.

What it does is simple:

1. Configure RAID controllers and partitioning (both customizable).

2. Install OS.

3. Configure OS.

4. Configure networking.

5. Leave you to be productive, to focus on more interesting problems.

With Stacki, machines are disposable.
Everything is built from the ground up programmatically so recovering from disasters means just rebuilding your servers.

Stacki delivers certainty. If you're configuring individual machines on a daily basis without automation, you're losing. Our goal is to keep you off of your servers and away from the question "what state are my servers in?", because you'll always know.

Once your servers are installed with Stackidone, you can augment them with your favorite configuration toolset - be it Salt, Chef, Puppet, CFEngine, Ansible, or homegrown - so you don't have throw away work you've already done. 


## Origins

Long before devops and webscale we were building world class [supercomputers](http://www.sdsc.edu) made from simple Linux boxes.
The hardware was cheap, but the complexity at scale killed us.
So we helped create the [Rocks](http://www.rocksclusters.org) toolkit to automate the deployment of high performance computing clusters.
Along the way we, started [StackIQ](http://www.stackiq.com) to build upon the Rocks software and make it appropriate for the enterprise.
The lessons we've learned from large scale HPC and enterprise computing are now yours as part of Stacki.

### Open Source<a name="license"></a>

Stacki is released as open source with a combination of licenses.
StackIQ forked the Rocks project source code in 2010 and maintains the original copyright to this code.
As such, the two primary licenses are for [Stacki](Stacki-License) and [Rocks](Rocks-license) source,
both are based on the traditional BSD attribution license.
Stacki also includes several third party open source packages each with their own copyrights.
Details on these are found in the [source tree](https://github.com/StackIQ/stacki).


## Linux

Stacki supports Red Hat and its variants.
We generally develop on CentOS but we always test on RHEL to give you the choice for your base operating system.

## Applications

Every application from big data to cloud requires real electrons on real
silicon.
The following is a list of some of the applications we've installed for
clients both large and small:

* Big Data: Cloudera, Hortonworks, MapR, Pivotal, BigInsights, Spark, Storm, Cassandra, MongoDB, RabbitMQ, R, Mesos, Splunk
* Cloud: OpenStack (RHEL-OSP, communinity OpenStack, RDO), CloudStack, VMWare
* HPC: Torque, Slurm, MOAB, MPI, UGE/OGS/SGE, PBS, CUDA, LSF, PGI
* Good Stuff: CoreOS, ESXI, Puppet, Ansible, Chef, Salt, Ceph, CFEngine, GPFS, Intel Developer Tools, VirtualBox, Docker

If you can do it in Linux, Stacki can automate it and deploy it over thousands
of machines. 

