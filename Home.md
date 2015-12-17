![stacki logo](https://github.com/StackIQ/stacki/blob/master/logo.png?raw=true)

Welcome to **Stacki**.

Automation and consistency across Linux infrastructure is hard. Our goal is to make Linux installations of heterogeneous hardware across 10s to 1000s of machines fast, flexible, and absolutely consistent.

The Stacki default installation process will bring bare metal infrastructure (or VMs) to a ping and a prompt. The frontend machine has password-less SSH access to the backend machines on first boot, and the repositories on the frontend act as YUM repositories for all backend machines. All machines will be at the latest kernel and RPM revisions of the OS and installed applications.

Stacki initial installations are relatively fast and simple, but may not completely reflect site-specific desired state. Configuration can be layered on using advanced features to customize local environments. The speed of installation/reinstallation Stacki provides allows convergence to a known/desired configuration of resources that reflect local needs. Deployed across the infrastructure, you've just made the complex simple and repeatable for existing or new infrastructure.

## What is it?

Stacki is a CentOS/RHEL bare metal install tool that can take your servers from bare hardware (or virtual hardware) to working Linux, ready to install applications.
Stacki does this at scale, so deploying 1000+ servers is no more complex than deploying one.
Advanced users can use Stacki to install applications (Hadoop, OpenStack, HPC etc.).
Stacki has a long [history](#origins), and is in use at some of the most demanding organizations in the world.

What it does is simple:

1. Configure RAID controllers and partitioning (both customizable).  
(This means you never have to touch a monitor and keyboard to customize the RAID configuration on machines, not even once. Set-up the RAID controller configuration via spreadsheet, ingest it, and install. The RAID will be configured on first installation with no human interaction required.)

2. Install OS.

3. Configure OS.

4. Configure networking  
(These include configuring multiple network interfaces, multiple network types: IB, 10G, 1G, and authenticated SSH password-less access at boot.)

5. Leave you to be productive, to focus on more interesting problems.

With Stacki, machines are disposable.
Everything is built from the ground up programmatically so recovering from disasters just means rebuilding your servers. 

Machines are disposable but data is not. After the initial installation, data is preserved across reinstalls. Data drives are reformatted only by deliberate action. A reinstall is a refresh of the OS and/or application software while data on disk is preserved. 

Stacki delivers certainty. If you're configuring individual machines on a daily basis without automation, you're losing. Our goal is to keep you from having to configure individual servers and always knowing the answer to: "What state are my servers in?"

Once your servers are installed with Stacki, augment them with your favorite configuration toolset - be it shell scripts, Salt, Chef, Puppet, CFEngine, Ansible, or homegrown - you don't have throw away work already done. (Although, once you see what it can do, some of that post-install configuration management may be easily replaced during installation.) 

## Origins

Long before devops and webscale, we were building world class [supercomputers](http://www.sdsc.edu) made from simple Linux boxes.
The hardware was cheap, but the complexity at scale killed us.
So we helped create the [Rocks](http://www.rocksclusters.org) toolkit to automate the deployment of high performance computing clusters.
Along the way, we started [StackIQ](http://www.stackiq.com) to build on the Rocks software and make it appropriate for the enterprise.
The lessons we've learned from large scale HPC and enterprise computing are yours as part of Stacki.

### Open Source<a name="license"></a>

Stacki is released as open source with a combination of licenses.
StackIQ forked the Rocks project source code in 2010 and maintains the original copyright to this code.
As such, the two primary licenses are for [Stacki](Stacki-License) and [Rocks](Rocks-license) source,
both are based on the traditional BSD attribution license.
Stacki also includes several third party open source packages each with their own copyrights.
Details on these are found in the [source tree](https://github.com/StackIQ/stacki).


## Linux

Stacki supports Red Hat and its variants.
We generally develop on CentOS but we always test on RHEL to give you the choice for your base operating system. We have also seen Oracle Linux and Scientific Linux deployed.

## Applications

Every application from big data to cloud requires real electrons on real
silicon.
The following is a list of some of the applications we've installed for
clients both large and small:

* Big Data: Cloudera, Hortonworks, MapR, Pivotal, BigInsights, Spark, Storm, Cassandra, MongoDB, RabbitMQ, R, Mesos, Splunk
* Cloud: OpenStack (RHEL-OSP, community OpenStack, RDO), CloudStack
* HPC: Torque, Slurm, MOAB, MPI, UGE/OGS/SGE, PBS, CUDA, LSF, PGI
* Filesystems: Ceph, GPFS, GlusterFS
* Hardware: Intel, Supermicro, Dell, IBM, HP, Cisco UCS, white box
* Good Stuff: Puppet, Ansible, Chef, Salt, CFEngine, Intel Developer Tools, VirtualBox, Docker

If you can do it in Linux, Stacki can automate it and deploy it over thousands
of machines. 

