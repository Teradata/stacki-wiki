# Stacki Overview

## Putting real electrons on real silicon.

Stacki is an extremly fast and scalable data center bare metal installer and is part of 
the Teradata family of open source projects - developed and supported by the 
Shared Services team at Teradata.

"Stacki" = Stack Installer

We install all your stack. 

And it's pronounced "Stack-ee" not "Stack-eye" or "Stuh-kai."

### Yeah, whatever - what is it?

Stacki is a CentOS/RHEL/Ubuntu/SLES bare metal install tool that takes servers from bare hardware (or virtual hardware) to working Linux, ready to install applications. It doesn't install images of OSs, it installs the OS with native kickstart, preseed or autoyast.

Stacki parallelizes at scale, so deploying 1000+ servers is no slower or complex than deploying one.

Advanced users can use Stacki to install applications (Hadoop, OpenStack, HPC, Docker, Kubernetes ad nauseum).

Stacki has a long [history](#origins) and is in use at places like Teradata, Verizon, and Ebay.

What it does is simple:

1. Install OS.
2. Configure OS.
3. Configure RAID controllers and partitioning (customizable - never touch a keyboard and monitor for RAID setup again)
4. Configure networking (Including multiple interfaces, multiple network types: IB, 10G, 1G)
5. Provides ower on to ping and a prompt with passwordless SSH access.

What it produces is complex:

1. One source of truth for the data center - a stacki frontend.
2. Disposable machines, just like VMs Everything is built from the ground up programmatically - recovering from disasters just means rebuilding your servers.
3. Doesn't dispose of data. After initial installation, data is preserved across reinstalls. Data drives are reformatted only by deliberate action. A reinstall is a refresh of the OS and/or application software while data on disk is preserved.
4. Certainty. If you're configuring individual machines on a daily basis without automation, you're losing. Stacki allows you to stop configuring individual servers and always know the state of your data center.
5. DevOps integration. Servers are installed with Stacki and can be augmented them with DevOps infrastructure - be it shell scripts, Salt, Chef, Puppet, CFEngine, Ansible, or homegrown. Don't throw away work already done.

### Origins

Stacki is a fork of Rocks, the original High Performance Computing project at UCSD.

Long before devops and webscale, scientists were building world class [supercomputers](http://www.sdsc.edu) made from simple Linux boxes. Hardware was cheap, but the complexity at scale killed us.
So we helped create the [Rocks](http://www.rocksclusters.org) toolkit to automate the deployment of high performance computing clusters.
Along the way, we started [StackIQ](http://www.stackiq.com) to build on the Rocks software and make it appropriate for the enterprise.
The lessons we've learned from large scale HPC and enterprise computing are yours as part of Stacki.

### Open Source<a name="license"></a>

Stacki is released as open source with a combination of licenses.

StackIQ forked the Rocks project source code in 2010 and maintains the original copyright to this code.
As such, the two primary licenses are for [Stacki](Stacki-License) and [Rocks](Rocks-License) source,
both are based on the traditional BSD attribution license.
Stacki also includes several third party open source packages each with their own copyrights.
Details on these are found in the [source tree](https://github.com/Teradata/stacki).


## Linux

Stacki supports Red Hat and its variants, Ubuntu, and SLES.
We generally develop on SLES since it is Teradata's focus, but we always test on CentOS/RHEL to give you the choice for your base operating system. We have also seen Oracle Linux and Scientific Linux deployed.

## Applications

Every application from big data to cloud requires real electrons on real
silicon.

The following is a list of some of the applications that stack is used to deploy.


* Big Data: Cloudera, Hortonworks, MapR, Pivotal, BigInsights, Spark, Storm, Cassandra, MongoDB, RabbitMQ, R, Mesos, Splunk
* Cloud: OpenStack (RHEL-OSP, community OpenStack, RDO), CloudStack
* HPC: Torque, Slurm, MOAB, MPI, UGE/OGS/SGE, PBS, CUDA, LSF, PGI
* Filesystems: Ceph, GPFS, GlusterFS
* Hardware: Intel, Supermicro, Dell, IBM, HP, Cisco UCS, white box
* Good Stuff: Puppet, Ansible, Chef, Salt, CFEngine, Intel Developer Tools, VirtualBox, Docker, Kubernetes

If you can do it in Linux, Stacki can automate it and deploy it over thousands
of machines.
