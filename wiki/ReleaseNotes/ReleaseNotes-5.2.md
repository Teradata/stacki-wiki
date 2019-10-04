# 05.02.06.12

## Feature

* Allow non-frontend parents to be time servers

  Also allow for non management of time

* Allow json data to be posted directly via the webservice

* Add parameter to `stack load` to have it run the commands

* Remove the `sync.hosts` attribute

  Must use `manage.hostfile` and `sync.hostsfile` from now on.

* Fine grain management of /etc/hosts

  Attributes
  
  manage.hostfile - file created during installation (default is False/None)
  
  sync.hostsfile - file creating the file during `sync host network` if
  `manage.hostsfile` is also true.  (default is False/None)
  
  Transitioning away from the sync.hosts attribute that controlled both
  of these as all or nothing.
  
  For Teradata the default will be managed.hostsfile=True and
  sync.hostsfile=False, hence the above change.


# 05.02.06.11

## Feature

* Add paramiko to python-packages

  This also means dependencies were recalculated and many other
  python packages got upgraded.


# 05.02.06.10

## Feature

* Stop managing the ssh host keys

  This means a re-install WILL change the ssh host keys.
  
  Conflicts:
  sles/nodes/ssh-client.xml

* 'stack load' includes pallet tags (if pallet exists)

* during sync host network, also sync /etc/hosts, but only if the attr sync.hosts=True

* Also sync /etc/resolv.conf during sync host network.  Cleanup seemingly superfluous 'report' calls

* Add a new "external" appliance for unmanaged hosts

## Bugfix

* Frontend goes into the frontend box

  Conflicts:
  tools/iso-builder/build.sh

* add check to install script to not break older stacki releases with newer install scripts

* Always sync /etc/hosts on the Frontend

* only restart named if a network in the database has dns=true

* Environment commands fails w/o environments defined

* when running against a host with an interface with no zone, default to using just the hostname

  Also fix various places where we assume a host, including the FE, will have a 'domainname' attribute.

* Properly set the file system type when loading partitions

* `stack dump` get correct global partition information


# 05.02.06.09

## Bugfix

* Apache appears to need restarted after the barnacle during the Redhat bootable ISO build

* Fix SQL error in `list attr`

  In the `addGlobalAttrs` function used to generate `Kickstart_PrivateHostname` and `Kickstart_PublicHostname` contained an SQL statement testing if the network interface name was null, using `<>`. This will always return false, no matter what, and should have been `IS NOT NULL` instead.

* Import sys for the rare error path

  Also cleanup some dangling whitespace.

* fix the infiniband table definitions to actually clean up the database if foreign keys are removed

* missed an argument for the error handling code in controller config


# 05.02.06.08

## Feature

* Halt the install (sles) with an error message on the console and in the message queue if we are unable to create a RAID. To override, set the attribute 'halt_install_on_error=False'.

## Bugfix

* Display an error message on the console and the message queue if we are unable to find any disks on the host.

* attempt to umount all partitions on a disk before nuking.

  If we are unable to unmount the partitions, raise an error unless attribute 'halt_install_on_error=False'.

* Correctly identify if a block device is a disk or partition on sles11

  Previous code assumed the output of hwinfo would be more consistent, but this does not appear to be the case and could cause a stacktrace that led to storage not being initialized.


# 05.02.06.07

## Bugfix

* Start Chronyd on frontend

* Handle nukedisks before the we start autoyast.  This prevents the situation where the installer hangs because it attempted to mount a disk and could not later nuke it.


# 05.02.06.06

## Feature

* `/etc/resolv.conf` improved handling

  `resolv.search` attribute can override the search line.
  
  Only the Frontend has access to the `Kickstart_PublicDNSServers`. For
  all other nodes the Frontend will be the first nameserver IFF it is
  serving DNS for any network (this was previously the case as well),
  but the subsequent nameserver lines will come only from the
  `Kickstart_PrivateDNSServers`.

## Bugfix

* Do interface validation of `set interface` commands in a case-insensitive manor, to match the DB.

* The command is systemctl, not systemd


# 05.02.06.05


# 05.02.06.04

## Feature

* Added support for `target,*,1,*,` in storage CSV.

  This will pair up drives and put them in a RAID 1 configurations.

* setting Kickstart_PrivateDNSServers to ' ' removes nameserver line from /etc/resolv.conf

  Also if no Public and Private DNSServers are defined don't setup stacki DNS to forward.

## Bugfix

* Cleanup how hostnames for "run" commands are calculated

* Tell logrotate it's ok to skip rotating missing logs instead of erroring.  Also include local0 in rotation, and make the log rotation size 100M for all logs in stack.conf

  The logrotate file is laid down via SUX, so existing frontends can get an approximation of this fix with:
  
  ```
  sed -i 's/local\[1/local\[0/' /etc/logrotate.d/stack
  sed -i '1s;^;size=100M\nmissingok\n;' /etc/logrotate.d/stack
  logrotate /etc/logrotate.conf -d 2>/dev/null && echo "success"
  ```


# 05.02.06.03

## Bugfix

* Fix NTP code for frontends.


# 05.02.06.02

## Feature

* NTP Fixes

  Support for NTP service across the cluster.
  1. Run Chrony server on the frontend
  2. Run NTP / Chrony on backends
  3. Support for time islands


# 05.02.06.01

## Bugfix

* Keep health message out of the YaST 2nd stage

* comments in rsyslog broke for SLES11


# 05.02.06.00

## Feature

* Add `cluster-up` tool to tools directory

* Move the frontend to its own box

  Doing this so `run pallet` becomes simpler and doesn't change
  the box used for backend nodes. `default` box is remains for that.

## Bugfix

* We have more than a `default` box now, update test accordingly

* Find and check all RPMS regardless of architecture

* Treat certain scenarios in manifest-check and get3rdparty as errors

  This updates manifest-check.py to return a nonzero exit code if there
  are no manifest files found.
  
  This also updates get3rdparty.py to return a nonzero exit code if it
  fails to fetch a 3rd party package.

* Make enable pallet error message more explicit

  When a pallet is trying to be enabled after being added, if a parameter mismatches,
  the stack command would just say the pallet isn't valid. This isn't a clear enough
  error message to the user so instead the error message was made more explicit. Now
  when the same thing occurs, the error message includes a list of the parameters entered.

* dump of carts matches pallets

* really send ws logs to /var/log/local1


# 05.02.05.00

## Bugfix

* Add check for malformed gateway addresses in Installer

* Fix add pallet when /mnt/cdrom unavailable

* add 'remove pallet' to the list of sudo'd web service commands

* make 'create new pallet' default to creating a pallet that matches the current OS, not 'sles'

* Use correct variable

  Incorrect variable referenced

* Add leading zeros to ID of script section

  When post sections are generated, boot-post sections are generated
  according to Stacki ordering, but are run in a lexical order. This
  means that boot-post-20 is run after boot-post-100. If there was
  an explicit ordering specified in Stacki, this ordering can get
  ignored when AutoYaST actually runs.
  
  Fix this by making the script ID a 4-digit ID with leading zeros.
  'Cuz we'll never have more than 9999 sections in a node file. /flw

* Fix Intrinsic firewall for frontend

  iptables rule had a syntax error. Fix

* for previous bugfix

* Autogeneration of release notes broke for some tags


# 05.02.04.00

## Feature

* Add ability to override reported files

  Only for /etc/resolv.conf right now. Added `reportFile` method
  for generating <file> tags.
  
  If an attribute `etc_resolv.conf` is defined the value will be used
  rather than the generated report.

* Run test-framework integration tests in parallel

  The tests are distributed across 4 cpus inside of the VM. Minor special handling for database names needed to be added to the stack command code to point everything at a copy of the database the test-framework manages. Each test file is pinned on the same process and it's test functions ran sequentially, which seems to keep things happy.
  
  A new fixture named `exclusive_lock` has been added to allow your test to run with exclusive control of the VM. It does this by waiting for the other test processes to finish their tests, then pause them before they can start the next one. Only a few tests and fixtures that use shared resources (modify the filesystem, start servers on ports, inject code, etc) have needed this extreme step. Only use it if your test won't pass without it.
  
  A second new fixture, named `debug_log`, has also been added. You add it to your other fixtures or tests and then call as a function. You give it a string and it will write it to a `debug.log` file in the reports directory, along with the test making the call and the xdist worker it is running on. Useful for debugging pytest fixtures because pytesst swallows normal print calls. You should remove any `debug_log` calls from your code before merging into `develop`, because writing to the shared log isn't very efficient.
  
  I added a new `--audit` flag to the `run-tests.sh` script for the integration test suite. This will log any modifications to the `/etc`, `/export/stack/pallets`, and `/export/stack/carts` directories, and warn you at the end of testing if any of the tests are missing the fixtures to revery the filesystem modifications.

## Bugfix

* WS message to /var/log/local1


# 05.02.03.00

## Feature

* Add a parameter to 'list host attr' to separate the display of common and distinct attributes.

  'stack list host attr display=[all|common|distinct] [hosts...] [attr=<attr>]' changes which attributes are displayed.
  
  display=all will display all attributes for each host, grouped by host.  This is the default, traditional behavior.
  
  display=common will display only attributes which are identical for each host, under the name '_common_'.
  
  display=distinct will display only attributes which are *not* identical for each host.

## Bugfix

* Prevent infinite recusion when there is no search line in resolv.conf

* Force the CSV files to be ascii during CSV based load commands


# 05.02.02.00

## Feature

* On SLES machines, make sure the `primary` network is always associated with `eth0`

  This is done by setting the 'profile.force_eth0' attribute to true.

* stack load

  Initial work to load the json output of `stack dump`. More to come.

* Create a Dockerized Frontend for development

  This is not full Docker support, this is only for internal
  development. See docker/README.md for details.

* Make systemd default target an attribute

  Systemd default target is currently set to multi-user.
  For VMS systems this is required to be graphical.
  Making this an attribute gives us the option to
  override it, as required

* Add an IP sanity check to 'stack report system'

## Bugfix

* stack load dropped network zone

* UTC is now a selecteable timezone in the wizard

* produce a better error message when trying to add an existing interface

* Fix how named.conf and zone files are created

  - Currently, Stacki does not have support for resolving
  names that are in address spaces with netmasks of 23-8.
  This commit remedies this.
  - Aliases were generated incorrectly. This commit fixes it.
  - Add comments about requirements and design
  - Fix tests for the new report zones output

* Remove the basic sudoers file from the 'ws' package since we overwrite it anyway.


# 05.02.01.00

## Feature

* Allow release notes to be generated between any git commits

  Move release notes generation to the build package. This way, it can
  be used for any other pallet as well.

## Bugfix

* Fix SQL logic when collapsing down lists of scoped data for host

  Because a host might have a `null` environment ID, the query was matching any `scope_map` that also had a null, even if it wasn't an `environment` scoped scope_map. Change the queries to check scope type when comparing the foreign keys with an OR in the WHERE clause.

* Fixed two bugs in 'load storage controller'

  The command was not correctly handling raid 0 with slots of '*', or non-integer array id's


# 05.02.00.00


# 5.2.0.0

## Feature

* Support parsing m7800 firmware information on firmware 3.6.8010


# 5.2.0

## Feature

* Long domainnames

  Increase the `zone` in the networks table to 255 (rfc1035 limit), and
  increase the network name to 128 (arbitrary but was 32).


# 5.2rc2

## Feature

* Refresh all PyPi package versions

* Support parsing Mellanox 3.6.8010 IB partition output

* Add yoyo-migrations to handle database schema changes

* Refactor the storage controller commands to use the new scoping scheme

  There are now scope level commands for `storage controller`:
  
  ```
  stack add [appliance, environment, host, os] storage controller
  stack list [appliance, environment, host, os] storage controller
  stack remove [appliance, environment, host, os] storage controller
  ```
  
  These versions of the commands operate on the global scope:
  
  ```
  stack add storage controller
  stack list storage controller
  stack remove storage controller
  ```

* Refactor Mellanox7800 firmware functions to be more robust

* [IB] Sync the hostname of the switch.

  If the 'name' field of the switch's mgmt0 interface is set, that name will be used.  Otherwise use the name in Stacki.

* Refactor the route comands to use the new scoping scheme

* Better Shadow Attributes

  Split the shadow attributes out of the `cluster` database and into a
  their own `shadow` database. This is the start of a locked down secrets
  database where host keys and other things can be stored.

* Pretty print when output_format=json

* Added a new 'stack verify xml' command to report XML errors across multiple node, graph files. 'stack list host profile' also has better XML parse error reporting now.

* Refactor the firewall comands to use a new scoping scheme.

## Bugfix

* Wait for the quit command to run before terminating the process

* [IB] Make setting the subnet manager more reliable.

* Under redhat, device routes need to output the interface

* Fix ask() to pass along kwargs so things like timeout work

* SLES11 use chkconfig for message queue

  - Call out libffi-devel for installation (zmq needs this)
  - Use `os.version` not `release`

* [IB] Properly parse partition members with GUID=ALL

* Missed a spot in the Vagrantfile which broke the `--use-src` flag in KVM

* Make sure commands using `Command::command` get the correct usage message on exception

## Breaking Change

* 

  There is new a database schema for the storage_controller table. This SQL will update an existing DB, but you will lose your existing controller configurations in the process:
  
  ```
  DROP TABLE IF EXISTS storage_controller;
  CREATE TABLE storage_controller (
  id		INT AUTO_INCREMENT PRIMARY KEY,
  scope_map_id	INT NOT NULL,
  enclosure	INT NOT NULL,
  adapter		INT NOT NULL,
  slot		INT NOT NULL,
  raidlevel	VARCHAR(16) NOT NULL,
  arrayid		INT NOT NULL,
  options		VARCHAR(512) NOT NULL,
  INDEX (enclosure, adapter, slot),
  FOREIGN KEY (scope_map_id) REFERENCES scope_map(id) ON DELETE CASCADE
  );
  ```

* 

  There is new a database schema for the routes. This SQL
  will update an existing DB, but you will lose your existing
  routes in the process:
  
  ```
  DROP TABLE IF EXISTS global_routes;
  DROP TABLE IF EXISTS os_routes;
  DROP TABLE IF EXISTS appliance_routes;
  DROP TABLE IF EXISTS node_routes;
  DROP TABLE IF EXISTS environment_routes;
  
  CREATE TABLE routes (
  id		INT AUTO_INCREMENT PRIMARY KEY,
  scope_map_id	INT NOT NULL,
  address		VARCHAR(32) NOT NULL,
  netmask		VARCHAR(32) NOT NULL,
  gateway		VARCHAR(32) DEFAULT NULL,
  subnet_id	INT DEFAULT NULL,
  interface	VARCHAR(32) DEFAULT NULL,
  INDEX (address),
  INDEX (interface),
  FOREIGN KEY (scope_map_id) REFERENCES scope_map(id) ON DELETE CASCADE,
  FOREIGN KEY (subnet_id) REFERENCES subnets(id) ON DELETE CASCADE
  );
  ```

* 

  ```
  mysqladmin --defaults-extra-file=/etc/root.my.cnf --user=root create shadow
  ```
  
  ```
  mysql --defaults-extra-file=/etc/root.my.cnf
  > grant select,update,insert,delete,lock tables on shadow.*  to apache@localhost;
  > grant select,update,insert,delete,lock tables on shadow.*  to apache@HOSTNAME;
  ```
  
  ```
  mysql --defaults-extra-file=/etc/root.my.cnf --user=root shadow
  > DROP TABLE IF EXISTS attributes;
  CREATE TABLE attributes (
  Scope           enum ('global', 'os', 'environment', 'appliance', 'host'),
  Attr            varchar(128) NOT NULL,
  Value           text,
  ScopeID         int(11)
  );
  ```

* 

  You can no longer pass `network=all` or `output-network=all` to
  the `add firewall` commands. That is the default, so if you want
  the firewall rule to apply to all networks, just don't specify
  the `network` or `output-network` parameters. This is how it really
  worked in the previous code, specifying `all` was just a nop.

* 

  There is new a database schema for the firewall rules. This SQL
  will update an existing DB, but you will lose your existing
  firewall rules in the process:
  
  ```
  DROP TABLE IF EXISTS global_firewall;
  DROP TABLE IF EXISTS os_firewall;
  DROP TABLE IF EXISTS appliance_firewall;
  DROP TABLE IF EXISTS node_firewall;
  DROP TABLE IF EXISTS environment_firewall;
  
  CREATE TABLE scope_map (
  id		INT AUTO_INCREMENT PRIMARY KEY,
  scope		ENUM('global','appliance','os','environment', 'host') NOT NULL,
  appliance_id	INT DEFAULT NULL,
  os_id		INT DEFAULT NULL,
  environment_id	INT DEFAULT NULL,
  node_id		INT DEFAULT NULL,
  INDEX (scope),
  FOREIGN KEY (appliance_id) REFERENCES appliances(id) ON DELETE CASCADE,
  FOREIGN KEY (os_id) REFERENCES oses(id) ON DELETE CASCADE,
  FOREIGN KEY (environment_id) REFERENCES environments(id) ON DELETE CASCADE,
  FOREIGN KEY (node_id) REFERENCES nodes(id) ON DELETE CASCADE
  );
  
  CREATE TABLE firewall_rules (
  id		INT AUTO_INCREMENT PRIMARY KEY,
  scope_map_id	INT NOT NULL,
  name		VARCHAR(256) NOT NULL,
  table_type	ENUM('nat','filter','mangle','raw') NOT NULL,
  chain		VARCHAR(256) NOT NULL,
  action		VARCHAR(256) NOT NULL,
  service		VARCHAR(256) NOT NULL,
  protocol 	VARCHAR(256) NOT NULL,
  in_subnet_id	INT DEFAULT NULL,
  out_subnet_id	INT DEFAULT NULL,
  flags		VARCHAR(256) DEFAULT NULL,
  comment		VARCHAR(256) DEFAULT NULL,
  INDEX (name),
  INDEX (table_type),
  FOREIGN KEY (scope_map_id) REFERENCES scope_map(id) ON DELETE CASCADE,
  FOREIGN KEY (in_subnet_id) REFERENCES subnets(id) ON DELETE CASCADE,
  FOREIGN KEY (out_subnet_id) REFERENCES subnets(id) ON DELETE CASCADE
  );
  ```
