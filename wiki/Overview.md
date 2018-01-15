## Stacki Overview

### Putting real electrons on real silicon since 199....a long time.

"Stacki" = Stack Installer

We install all your stack.

And it's pronounced "Stack-ee" not "Stack-eye" or "Stuh-kai."

### Yeah, whatever - what is it?

Stacki is a CentOS/RHEL/Ubuntu/SLES bare metal install tool that takes servers from bare hardware (or virtual hardware) to working Linux, ready to install applications. It doesn't install images of OSs, it installs the OS with native kickstart, preseed or autoyast.

Stacki parallelizes at scale - deploying 1000+ servers is no slower or complex than deploying one.

Advanced users can use Stacki to install applications (Hadoop, OpenStack, HPC, Docker, Kubernetes...ad nauseum).

Stacki has a long [history](History) and is in use at places like Teradata, Verizon, Salesforce, and Ebay.

What it does is simple:

1. Install OS.
2. Configure OS.
3. Configure RAID controllers and partitioning (customizable - never touch a keyboard and monitor for RAID setup again)
4. Configure networking (Including multiple interfaces, multiple network types: IB, 10G, 1G)
5. Provides ower on to ping and a prompt with passwordless SSH access.

What it produces is complex:

1. One source of truth for your data center - a stacki frontend.
2. Disposable machines, just like VMs Everything is built from the ground up programmatically - recovering from disasters just means rebuilding your servers.
3. Doesn't dispose of data. After initial installation, data is preserved across reinstalls. Data drives are reformatted only by deliberate action. A reinstall is a refresh of the OS and/or application software while data on disk is preserved.
4. Certainty. If you're configuring individual machines on a daily basis without automation, you're losing. Stacki allows you to stop configuring individual servers and always know the state of your data center.
5. DevOps integration. Servers are installed with Stacki and can be augmented with DevOps infrastructure - be it shell scripts, Salt, Chef, Puppet, CFEngine, Ansible, or homegrown. Don't throw away work already done.

## Linux

Stacki supports Red Hat and its variants, also Ubuntu and SLES.
We generally develop on SLES since it is Teradata's focus, but we always test on CentOS/RHEL to give you the choice for your base operating system. We have also seen Oracle Linux and Scientific Linux deployed.

## Applications

The following is a list of some of the applications that Stacki is used to deploy:

* Big Data: Cloudera, Hortonworks, MapR, Pivotal, BigInsights, Spark, Storm, Cassandra, MongoDB, RabbitMQ, R, Mesos, Splunk
* Cloud: OpenStack (RHEL-OSP, community OpenStack, RDO), CloudStack
* HPC: Torque, Slurm, MOAB, MPI, UGE/OGS/SGE, PBS, CUDA, LSF, PGI
* Filesystems: Ceph, GPFS, GlusterFS
* Hardware: Intel, Supermicro, Dell, IBM, HP, Cisco UCS, white box
* Good Stuff: Puppet, Ansible, Chef, Salt, CFEngine, Intel Developer Tools, VirtualBox, Docker, Kubernetes

If you can do it in Linux, Stacki can automate it and deploy it over hundreds of machines.

### Does Stacki fit?

Look, Stacki isn't needed by everyone for everything. We're focused on installing clusters fast and at scale as part of the iterated data center.

If you:
* Install a small number of machines. (Five, five is a small number.)
* Install machines once and then forget about them. (Unicorns)
* Don't reinstall to get a known good state. (You don't like certainty.)
* Don't provision/re-provision and marshal resources based on client need.
* Already have configuration DevOps tools in place that does most of the work.
* Are doing straight HPC ([Rocks](https://rocksclusters.org) is probably still best for that.)
* Time is of no essence for you.

Then we might not be what you need. Take a look at:
* [Cobbler](https://cobbler.github.io/)
* [Spacewalk](https://spacewalkproject.github.io/)
* [MaaS](https://maas.io/)
* [Rocks](https://www.rocksclusters.org) for HPC.
* [Satellite](https://access.redhat.com/products/red-hat-satellite)
