.. include:: macros.rst

************
Introduction
************

|stackiq|_ software is used to provision and manage |linux| systems.
From a single management host users can rapidly provision fully
configured |linux| servers.  
Once provisioned |stackiq| provides a management portal for system
monitoring and management.
Central to the software is a database that stores the complete state
of your machines, 
capturing what is truly unique to your infrastructure.
Additionally |stackiq| provides turn-key solutions for |bigdata|,
|cloud|, and |hpc|, 
saving time and training to deploy complete systems in hours instead of weeks.

The software is based on the |opensource| |rocks|_ cluster
distribution [#rocks_license]_,
which is widely known in the HPC community for its easy
of use and flexibility.




Clusters
========

|stackiq| views everything as a cluster.
Clusters have traditionally been thought of as homogeneous
servers - each configured identically.
However, even in |hpc| this has never been the common case.
Systems have always had heterogeneity at some level of hardware, 
and multiple software roles for different sets of machine in the cluster.
|stackiq| embraces this view while removing assumptions of any
homogeneity of both hardware and software for sets of |linux| servers.

We define a cluster is a set of machines (typically called |compute|
nodes) on the same network subnet all centrally managed by a single
|stackiq| |frontend| management host. 
This is illustrated in the :ref:`figure-cluster-architecture` figure. 

.. _figure-cluster-architecture:
.. figure:: images/cluster-architecture.png

	Simplified Cluster Architecture


All servers managed by the |frontend| must have a network interface
connected a single subnet.
This network is used for system provisioning, management, 
and optionally applications themselves.
Servers can optionally include other networks which will also be
managed from |stackiq|.  
The |frontend| must also have a network interface connected to this
subnet and may optionally have a secondary (or more) networks.


Concepts
========

Kickstart Installation
----------------------

The |stackiq| installer is built on top of |redhat| |anaconda| and
dynamically creates |kickstart| files to install machines from bare
metal.
Because we use a framework built on top of |kickstart|,
|stackiq| systems are managed at a much higher (and simpler) level
than systems using disk imaging or virtual machine images. 
Seemingly complex actions such as swapping an OS between minor versions,
or updating a kernel become trivial operations. 
Much of this is the consequence of managing a description of the
machine (|kickstart|) rather than the image of a machine. 
Think of this is the difference in maintaining the compiled object
code of a program versus maintaining the higher level program itself. 
|StackIQ| is about programming your cluster, not managing at the bit level.

Avalanche Installer
-------------------

The Avalanche installer is a peer-to-peer, package-sharing,
installation system. It was inspired by the BitTorrent file-sharing
system. It was developed at the Rocks Clusters Group
at UC San Diego, as part of the Rocks Clusters suite.

The Avalanche installer allows for package sharing between installing
hosts. The |frontend| hosts all the packages that may be used to install
the |backend| nodes. However, if all the |backend| nodes are installed
at the same time, the |frontend| may be overwhelmed by responding to
the number of packages requested. To alleviate this problem, the Avalanche
installer was developed.

The Avalanche installer allows each |backend| host to download a small
subset of the overall packages, and then share these packages between
themselves during installation. This reduces the burden of package
distribution on the frontend.


StackIQ Command Line
--------------------

The StackIQ Cluster Manager suite has a command line utility
that allows the administrator to manage his cluster.

Managing a cluster is complicated business. Since a cluster
is a federated way of managing multiple hosts, disks,
networks, etc., administrators will need a consistent way to
manage these entities. Some of the requirements for managing
a cluster are -

        * Maintaining the state of hosts
        * Maintaining the state of network configuration
        * maintaining the state of disk configuration
        * Ability to change the state of entities mentioned
          above.
        * Ability to generate configuration files from the
          maintained data about the cluster.
        * Ability to generate installation profiles for
          hosts in the cluster.

In the initial days of development of the Rocks Cluster
suite, the above operations were performed using a variety
of simple scripts. These scripts, while functional, were an
administrative and developmental nightmare. Some of the
disadvantages of using these scripts were -

        * Lack of consistency of usage,
          parameters, and arguments
        * Lack of extensibility
        * Redundant Functionality

The StackIQ Command Line, invoked using the command 
::

        # rocks

was developed to address the requirements mentioned above,
and to alleviate some of the problems of using various scripts
for managing the cluster.

For more information about the StackIQ Command Line, see the
:ref:`rcl` documentation.

Software Architecture
---------------------

All computer systems are inherently heterogeneous - both and the
hardware level, and at the software level. 
|StackIQ| makes no assumptions of homogeneity of either of these layers (see
:ref:`section-system-requirements`). 
Hardware differences are handled by the installer itself,
and software differences can be expressed in the |stackiq| framework.

.. todo::

	Expand on this to introduced Avalanche and the Rocks Command
	Line. 
	This idea is just to introduce the term that we will
	expand upon later. 
	This doesn't have to be exactly correct.

Appliances
----------

We use the term |appliance| to refer to a type of system with unique
functionality. 
The default |appliance| created by |stackiq| is called a |compute| appliance.
This name originates from |hpc| where the |compute| nodes
are the fundamental element of the cluster. 
The definition of a given |appliance| is derived from the set of |rolls| installed on the
|frontend|. 
For example, adding the |horton| |roll| will extend the
definition of a |compute| node to include Hadoop services. 
Fine grain control over an |appliance| is managed using |attributes|,
which are simple key-value pairs applied to sets of hosts.
|rolls| are also used to define the distributions used to install and update machine.

The combinations of |appliances|, |rolls|, |attributes|, and
distributions are the key to defining and managing a |stackiq|
system.

.. _section-system-requirements:

System Requirements
===================

|stackiq| supports all |redhat| |linux| compatible operating systems,
which includes |centos|.
The current release of |stackiq| is based on |centos|
|redhat-full-version| and 
works with previous |redhat-version| versions.
|stackiq| support all x86_64 systems, 
with no support for other CPU architectures.  
Additional |frontend| and |compute| node requirements for the RAM, 
disk size, network, and the BIOS boot order are as
follows:

+---------------+-----------------------+-----------------------+
|               | |frontend|		| |compute|             |
+---------------+-----------------------+-----------------------+
| RAM		| 2 GB			| 2 GB			|
+---------------+-----------------------+-----------------------+
| Disk		| 100 GB		| 100 GB		|
+---------------+-----------------------+-----------------------+
| Network	| Dual |ethernet|	| One |ethernet|	|
+---------------+-----------------------+-----------------------+
| Boot Order	| DVD, Hard Disk	| PXE, Hard Disk	|
+---------------+-----------------------+-----------------------+


.. rubric:: Footnotes 

.. [#rocks_license] 

This product includes software developed by the 
Rocks(r) Cluster Group at the San Diego Supercomputer Center at the 
University of California, San Diego and its contributors.
