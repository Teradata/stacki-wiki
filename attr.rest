.. include:: macros.rst 

.. |string| replace:: *String*
.. |int| replace:: *Integer*
.. |bool| replace:: *Boolean*

**********
Attributes
**********


|attributes| are key-value pairs used to fine tune |appliance|
configurations for a given host.
While |attributes| are often defined at the host level they can
also be defined at the Global, Environment, os OS level.
In addition |stackiq| defines an Intrinsic level that maps the cluster
database schema into key-value pairs.


Reference
=========

**ATTR** : *TYPE*
	DESCRIPTION 

**Kickstart_DistroDir** : *String*
	This attribute is no longer used, 
	and will be removed in the next release of the code. 

**Kickstart_Multicast** : *String*
	This IP multicast address used in the cluster private network.
	This address is randomly generated during the |frontend|
	installation.

**Kickstart_PrivateAddress** [#intrinsic_attribute]_ : |string|
	The IP address of the private network interface for the 
	|frontend|. 
	This is the value in the *IP* column in the *private* row 
	returned by 
	``rocks list host interface localhost`` 
	as run on the |frontend|. 

**Kickstart_PrivateBroadcast** [#intrinsic_attribute]_ : |string|
	The IP broadcast address of the cluster private network. 
	This is calculated based on the *SUBNET* and *NETMASK* columns returned by 
	``rocks list network private``, 
	and can be modified with 
	``rocks set network netmask private``. 

**Kickstart_PrivateDNSDomain** [#intrinsic_attribute]_ : |string|
	The domain name associated witht the cluster private network. 
	This is the value in the *DNSZONE* column returned by 
	``rocks list network private``,
	and can be modified with 
	``rocks set network zone private``. 

**Kickstart_PrivateDNSServers** : *String*
	The address of the DNS servers to be used by all hosts on
	the private network.
	This defaults to the private interface address of the
	|frontend| meaning all hosts use the |frontend| for DNS
	queries rather than reaching out to the LAN or Internet.

**Kickstart_PrivateGateway** : *String*
	This attribute is for internal use only. 

**Kickstart_PrivateHostname** [#intrinsic_attribute]_ : |string|
	The name of the private network interface for the  |frontend|. 
	This is the value in the *NAME* column in the *private* row 
	returned by 
	``rocks list host interface localhost`` 
	as run on the |frontend|. 

**Kickstart_PrivateKickstartBasedir** : *String*
	This attribute is for internal use only. 

**Kickstart_PrivateNetmask** [#intrinsic_attribute]_ : |string|
	The IP network mask of the cluster private network. 
	This is the value in the *NETMASK* column returned by 
	``rocks list network private``, 
	and can be modified with 
	``rocks set network netmask private``. 

**Kickstart_PrivateNetmaskCIDR** [#intrinsic_attribute]_ : |string| 
	The IP network mask of the cluster private network in CIDR format. 
	This is calculated based on the value in the *NETMASK* column returned by 
	``rocks list network private``, 
	and can be modified with 
	``rocks set network netmask private``. 

**Kickstart_PrivateNetwork** [#intrinsic_attribute]_: |string|
	The IP network of the cluster private network. 
	This is the value in the *SUBNET* column returned by 
	``rocks list network private``, 
	and can be modified with 
	``rocks set network subnet private``. 

**Kickstart_PublicAddress** [#intrinsic_attribute]_ : |string|
	The IP address of the public network interface for the 
	|frontend|. 
	This is the value in the *IP* column in the *public* row 
	returned by 
	``rocks list host interface localhost`` 
	as run on the |frontend|. 

**Kickstart_PublicBroadcast** [#intrinsic_attribute]_ : |string|
	The IP broadcast address of the cluster public network. 
	This is calculated based on the *SUBNET* and *NETMASK* columns returned by 
	``rocks list network public``, 
	and can be modified with 
	``rocks set network netmask public``. 

**Kickstart_PublicDNSDomain** [#intrinsic_attribute]_ : |string|
	The domain name associated witht the cluster public network. 
	This is the value in the *DNSZONE* column returned by 
	``rocks list network public``,
	and can be modified with 
	``rocks set network zone public``. 

**Kickstart_PublicGateway** : *String*
	This attribute is for internal use only. 

**Kickstart_PublicHostname** [#intrinsic_attribute]_ : |string|
	The name of the public network interface for the  |frontend|. 
	This is the value in the *NAME* column in the *public* row 
	returned by 
	``rocks list host interface localhost`` 
	as run on the |frontend|. 

**Kickstart_PublicNetmask** [#intrinsic_attribute]_ : |string|
	The IP network mask of the cluster public network. 
	This is the value in the *NETMASK* column returned by 
	``rocks list network public``, 
	and can be modified with 
	``rocks set network netmask public``. 

**Kickstart_PublicNetmaskCIDR** [#intrinsic_attribute]_ : |string| 
	The IP network mask of the cluster public network in CIDR format. 
	This is calculated based on the value in the *NETMASK* column returned by 
	``rocks list network public``, 
	and can be modified with 
	``rocks set network netmask public``. 

**Kickstart_PublicNetwork** [#intrinsic_attribute]_: |string|
	The IP network of the cluster public network. 
	This is the value in the *SUBNET* column returned by 
	``rocks list network public``, 
	and can be modified with 
	``rocks set network subnet public``. 

**appliance** [#intrinsic_attribute]_ : |string|
	The |appliance| type for a given host. 
	This is the value of the *APPLIANCE* column returned by 
	``rocks list host``,
	and can be modified with 
	``rocks set host appliance``. 

**cpus** [#intrinsic_attribute]_ : |int|
	The number of CPU cores for a given host.
	This is the value of the *CPUS* column returned by
	``rocks list host``,
	and can be modified with
	``rocks set host cpus``.

**distribution** [#intrinsic_attribute]_ : |string|
	The name of the |distribution| for a given host.
	This is the value of the *DISTRIBUTION* column returned by
	``rocks list host``,
	and can be modified with
	``rocks set host distribution``.

**graph** [#intrinsic_attribute]_ : |string|
	The name of the graph directory containing the XML graph files
	for a given hosts.
	This is the value of the *GRAPH* column returned by
	``rocks list distribution``
	for the distribution that the host's distribution.
	This value is always set to ``default`` and is never modified.

**hostaddr** [#intrinsic_attribute]_ : |string|
	The IP address of the private network interface for a given
	host.
 	This is the value in the *IP* column in the *private* row 
	returned by 
	``rocks list host interface``,
	and can be modified with
	``rocks set host interface ip``.

**hostname** [#intrinsic_attribute]_ : |string|
	The name of the private network interface for a given host. 
	This is the value in the *NAME* column in the *private* row 
	returned by 
	``rocks list host interface``,
	and can be modified with
	``rocks set host interface name``.

**membership** [#intrinsic_attribute]_ : |string|
	The |appliance| type for a given host. 
	This is the value of the *MEMBERSHIP* column returned by 
	``rocks list host``,
	and can be modified with 
	``rocks set host appliance``. 

**os** [#intrinsic_attribute]_ : |string|
	The name of the operating system for a given host.
	This is the value of the *OS* column returned by
	``rocks list distribution``
	for the distribution used by the given host.
	For both |redhat| and |centos| hosts this value is *redhat*.

**rack** [#intrinsic_attribute]_ : |int|
	The rack number for a given hosts. 
	This is the value of the *RACK* column returned by 
	``rocks list host``,
	and can be modified with 
	``rocks set host rack``. 

**rank** [#intrinsic_attribute]_ : |int|
	The rank number for a given hosts. 
	This is the value of the *RANK* column returned by 
	``rocks list host``,
	and can be modified with 
	``rocks set host rank``. 




| **Kickstart_PrivateKickstartHost** : *String* : ``10.1.1.1`` : Kickstart Host
|
| **Kickstart_PrivateNTPHost** : *String* : ``10.1.1.1`` : Private NTP Host
|
| **Kickstart_PrivateSyslogHost** : *String* : ``10.1.1.1`` : Private Syslog host
|
| **Kickstart_PublicDNSServers** : *String* :  : Public DNS Servers
|
| **Kickstart_PublicNTPHost** : *String* : ``pool.ntp.org`` : Public NTP Server
|
| **Kickstart_Timezone** : *String* : ``America/Los_Angeles`` : Timezone
|
| **discover_start** : *Bool* : ``true`` : Controls discovery mode in the GUI
|
| **discovery.base.rack** : *Integer* : ``0`` : Starting Rack number
|
| **discovery.base.rank** : *Integer* : ``0`` : Starting position number in rack
|
| **distribution.rocks-dist.version** : *Integer* : ``1`` : Latest rocks-dist version number
|
| **firewall** : *Bool* : ``true`` : Enables/disables firewall on backend nodes
|
| **ganglia_address** : *String* : ``224.0.0.3`` : Ganglia multicast address
|
| **managed** : *Bool* : ``true`` : Enables/disables management of nodes.
|
| **mcli.flags** : *String* : ``WB,NORA,Direct,NoCachedBadBBU`` : Controls flags used when creating MegaCLI RAID configurations
|
| **nukedisks** : *Bool* : ``false`` : Controls whether to wipe all disks when re-installing
|
| **os** : *String* : ``redhat`` : OS of a host.
|
| **rocks_version** : *String* : ``6.6`` : StackIQ Version Information
|
| **salt.master** : *Bool* : ``false`` : Controls installation of salt master
|
| **salt.master.interface** : *String* : ``10.1.1.1`` : Interface on which the salt-master listens
|
| **salt.master.log_level** : *String* : ``info`` : Log level of the salt-master
|
| **salt.master.log_level_logfile** : *String* : ``warning`` : Log level logfile for the salt-master
|
| **salt.minion** : *Bool* : ``true`` : Controls installation of salt-minion
|
| **salt.minion.log_level** : *String* : ``info`` : Log level for the salt-minion
|
| **salt.minion.log_level_logfile** : *String* : ``warning`` : Log level logfile for salt-minion
|
| **salt.minion.master** : *String* : ``10.1.1.1`` : Address of salt-master
|
| **ssh.use_dns** : *Bool* : ``true`` : Resolve DNS when using SSH
|
| **stats.cpu** : *Bool* : ``true`` : Enables/disables collection of CPU stats
|
| **stats.disk** : *Bool* : ``true`` : Enables/disables collection of disk stats
|
| **stats.net** : *Bool* : ``true`` : Enables/disables collection of Network stats
|
| **stats.rrd.path** : *String* : ``/state/partition1/stats/rrds`` : Location of stats
|
| **stats.rrd.seconds** : *Integer* : ``157680000`` : Longevity of stats
|
| **stats.rrd.startup** : *Integer* : ``1`` : Enables/disables collection of stats
|
| **sync.autofs** : *Bool* : ``true`` : Enables/disables syncing of autofs files
|
| **sync.root** : *Bool* : ``true`` : Enables/disables syncing of root user information
|
| **sync.users** : *Bool* : ``true`` : Enables/disables syncing of user information
|
| **user.auth** : *String* : ``unix`` : Method for user authentication
|


| **RepositoryLocal** : *Bool* : ``true`` : Use local repository
|
| **dhcp_filename** : *String* : ``pxelinux.0`` : Name of PXE file served by DHCP
|
| **dhcp_nextserver** : *String* : ``10.1.1.1`` : DHCP Nextserver
|
| **exec_host** : *Bool* : ``false`` : Execution capability of appliance
|
| **kickstartable** : *Bool* : ``yes`` : Kickstart capability of appliance
|
| **managed** : *Bool* : ``true`` : Managed appliance
|
| **primary_net** : *String* : ``private`` : Primary network of appliance
|
| **submit_host** : *Bool* : ``true`` : Job submission capability of appliance
|


| **salt.minion.disable_modules** : *String* : ``[ cmdmod, test ]`` : Disabled salt modules.


.. rubric:: Footnotes 

.. [#intrinsic_attribute] 

This is an *Intrinsic* |attribute| which means the value is a
read-only and derived from structured data in the cluster database.
While it is possible to set the value using any of the ``rocks set
attr`` commands, the calculated (instrinsic) value will always be the
one reported.
