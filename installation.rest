.. include:: macros.rst

************
Installation
************


.. _section-getting-started:

Getting Started
===============


First download the |stackiq| software by filling out the customer
`registration page
<http://web.stackiq.com/software-download-request/>`_.  
After entering you email contact information you may choose between |bigdata|,
|cloud|, or |hpc|.  
Once you submit the form a link will be emailed
with the URL to download the selected software.  
Follow the instructions in the email and burn the downloaded .iso file to a
blank DVD.

All versions of |stackiq| software are free for use with 16 |compute|
nodes or less.  
Including the |frontend| machine means all clusters 17
nodes or less do not require a license.  
If you have purchased support
you should have received a license file and instructions at the time
of purchase.  
If you have an questions please contact one of the below.

+---------------+-----------------------+
| sales		| sales@stackiq.com	|
+---------------+-----------------------+
| support       | support@stackiq.com	|
+---------------+-----------------------+


.. _section-building-frontend:

Building the Cluster Manager
============================

The first step to building your cluster is to create a new Cluster
Manager, also referred to in this document as the |frontend|.
Installing a |frontend| will completely erase the hard disk of the
system and install a brand new operating system along with the
|stackiq| software.  
Make sure your server meets the minimum :ref:`section-system-requirements`.

Insert the DVD created in :ref:`section-getting-started` into the
|frontend| server and reboot the machine making sure it will boot from
the media rather than local disk or network.  
If your system is remote and has the ability to boot from virtual media you can upload the .iso
file into your server's lights out management console.  
After the machine boots from the DVD you will see the :ref:`figure-install-splash` on the console.

.. _figure-install-splash:
.. figure:: images/install/install-splash-6_6.png 

	`Splash screen`

The installation will pause on this screen for a few seconds and then
continue to the next step.

.. _section-graphical-installer:

Graphical Installer
-------------------

The Installer switches from text video mode to graphical mode.
This may take a few seconds while the video card is initialized. 
The first step is to select the |rolls| used to build the |frontend|.
|rolls| can be installed from local DVD media or over the network from
another |frontend|.
From the :ref:`figure-install-welcome` you can either enter the hostname of
your |central| server or choose :menuselection:`Local Rolls -->
CD/DVD-based Roll` and then click :menuselection:`Next`.


.. _figure-install-welcome:
.. figure:: images/install/install-welcome-6_5.png 

        Welcome screen

On the :ref:`figure-install-select-rolls` select all the |rolls| your
wish to use in building the |frontend|. 
In this example are building a |frontend| supporting |hpc| so we
select all the |rolls| on the |sehpc| jumbo |roll|.

.. _figure-install-select-rolls:
.. figure:: images/install/install-select-rolls-hpc-6_6.png 

	Roll Selection screen

Once the |rolls| are selected from the current DVD or |central| you
will then be prompted on the ref:`figure-install-selected-rolls` to add more
|rolls| or continue with the installation.

.. _figure-install-selected-rolls:
.. figure:: images/install/install-selected-rolls-hpc-6_6.png 

	Rolls Selected screen

The :ref:`figure-install-cluster-information` uses the completed fields for
creating SSL certificates, configuring SNMP, and other standard
services.
You will need to input a valid FQDN for the |frontend|. 
If you do not know your hostname and domainname stop here and speak to
your network administrator.

.. _figure-install-cluster-information:
.. figure:: images/install/install-cluster-information-6_5.png 

	Cluster Information screen

As we saw in the :ref:`figure-cluster-architecture` figure, the
|frontend| requires both a private and public network. 
The private network connects to all the other hosts in the clusters it is command
to uses a subnet from the non-routable IP addresses described in
`rfc1918 <http://tools.ietf.org/html/rfc1918>`_.
The :ref:`figure-install-private-network` sets the address and netmask for
the private network, for most environments you can safely accept the
default values.


.. _figure-install-private-network:
.. figure:: images/install/install-eth0-6_5.png 

        Private Network Address screen

The :ref:`figure-install-public-network` sets the address and netmask
for the public network. 
There are no defaults provided. Talk to you network administrator if you are unsure of the values.

.. _figure-install-public-network:
.. figure:: images/install/install-eth1-6_5.png 

	Public Network Address screen

The :ref:`figure-install-network` sets the default gateway and
nameserver for the |frontend|.
The default gateway and nameserver should both be in the public network side of the |frontend|.

.. _figure-install-network:
.. figure:: images/install/install-network-6_5.png 

	Network Configuration screen

The :ref:`figure-install-password` sets administrator password for
both the root account and the management portal.

.. _figure-install-password:
.. figure:: images/install/install-password-6_5.png 

	Root Password screen

The :ref:`figure-install-timezone` sets the default timezone used for
all services. 
This will be the timezone used in all logfiles. 
If the default NTP server is not reachable from your |frontend| you must
provide the name of an alternate server (this is typically a corporate
NTP server behind your company firewall).

.. _figure-install-timezone:
.. figure:: images/install/install-timezone-6_6.png 

	Timezone Selection screen

Next you must choose whether to do manual disk partitioning or have the
installer automatically allocated disk partitions. 
If this is your first time building a |frontend| select 
:menuselection:`Disk Partitioning -> Auto Partitioning`.

.. _figure-install-partitioning:
.. figure:: images/install/install-partitioning-6_5.png 

	Disk Partitioning screen

Once the disks are partitioned and formatted the installer will start
to install packages and run the post configuration scripts as show on
the :ref:`figure-install-packages`.
Following this step the |frontend| will reboot and you will then be
able to login with the root password previously chosen.

.. _figure-install-packages:
.. figure:: images/install/install-packages-6_5.png 

	Package Installation and Post Config screen


Advanced Installation
---------------------

Central Servers
^^^^^^^^^^^^^^^

Manual Disk Partitioning
^^^^^^^^^^^^^^^^^^^^^^^^

Upgrade
^^^^^^^


.. _section-building-backend:

Building Nodes
==============

Discovery
---------

Management Console
^^^^^^^^^^^^^^^^^^

Command Line
^^^^^^^^^^^^

Spreadsheet
-----------

Management Console
^^^^^^^^^^^^^^^^^^

Command Line
^^^^^^^^^^^^



