.. include:: macros.rst

*************
Release Notes
*************

Release 6.6 - Stack 4
=====================

New Features
------------

* Command Line API 

	Access control is now based on UNIX group membership with root having access to modify the
	cluster database, and members of the ``wheel`` group allowed to run any ``list`` command.

	All ``host`` commands now accept shell style regex globs as host arguments.  
	For example: ``stack list host compute-*-0``

	API caches all database selects statements and invalidates upon any update.  
	This replaces the previous database caching code.

	Added colorized output for commands with column headers in the output.

	Command line is now named ``stack`` with ``rocks`` remaining as an alias.


* Real-time logfile streaming

	Added the ability to stream log files from |compute| nodes to the |frontend|.
	``stack start host logreader`` can trigger this from the command line, 
	or this can be done in the management console.
	If using the management console multiple hosts and files can be accessed 
	concurrently and output if color coded and filterable.

* Salt Stack

	Added the option to sync the ``/etc/hosts`` file from the |frontend| to the |compute| nodes.
	This is controlled with the ``sync.hosts`` attribute and is disabled by default.

	Added parameters to ``stack sync host state``.  
	The ``test`` parameter is used to perform a dry run and only report what would be modified.
	The ``name`` and ``function`` are used to specify a specific subset of the *high state* to be synced.

	All Salt root hierarchies are now placed under Git for version control.

* Puppet

	|frontend| run the Puppet master and |compute| nodes have the agent installed but
	turned off by default.  
	This was added for users with existing Puppet infrastructure that wished to bring it forward into cluster management.

* Disk Array Controller Spreadsheet Configuration

 	Added ``stack load storage controller`` to define disk array controller
	RAID configuration (LSI and HP Smart Array controllers).

	Improved ``stack load hostfile`` network handling to include bonded interfaces.

Improvements
------------

Added /boot to list of partition reformatted during re-installation 

Improvements in cluster validation screen layout in management console.

Improvements in RAID visualization in management console.

Ability to enable host discovery from management console.

Changed default timezone to Pacific in the cluster manager installation screens.

Management console verified with Internet Explorer version 11.

Improved host file .cvs handling to include more complex network configurations.

LVM support for boot disks and data disks.

