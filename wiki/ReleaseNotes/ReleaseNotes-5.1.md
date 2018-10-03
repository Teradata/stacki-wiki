# 5.1rc9

## Feature

* Ability to add user-defined global configuration for the Dell 1052 switch.

  For example, to configure SNMP on the switch named *ethernet-231-43*, exeucte:

  `stack add host attr ethernet-231-43 attr=switch_global_config value="snmp-server community \
public ro view Default"`

* Attribute control to configure a host's switch port as a *trunk*.

  A *trunk* port allows all VLAN traffic to pass through it. You can set a host's switch port
  to a trunk by executing:

        `stack set host attr hostname attr=switch_port_mode value=true`

* Include man, and man-pages in install

  SLES does not include man, or man-pages as part
  of a Minimal install set. Include the packages.

* Support for globbing on uppercase hostnames

  Globbing on hostnames is now case insensitive.

* `set host power` updates the message queue

* [Switch] Manage ssh keys on Mellanox IB switches

  * Automatically add stacki's public key to the switch on a sync.
  * Wipe out all ssh authorized keys on nukeswitch=true

* Added `nukeswitch=yes|no` to the Dell 1052 ethernet switch configuration.

  When `nukeswitch=yes`, all VLANs will be removed from the switch and each port will be confi\
gured onto the default VLAN (i.e., VLAN 1).

## Bugfix

* stack enable/disable pallet is now multiple arg friendly

* Make `remove os` actually remove the OS, even if it has attrs or routes attached

* [Switch] Correct membership settings for IB configs

* Duplicate default host interfaces won't be allowed in stack add host interface

## Git

* starting stacki-5.1rc9

# 5.1rc8

## Feature

* remove the deprecated status in `list host`

* Better tracking of 3rdparty packages

  - Update LICENSE.txt files for foundation packages
  - Generate a `nosat.txt` file for pip packages
  - Move more binaries out of git and into s3
  - Added top level LICENSE-3rdparty.txt

## Bugfix

* Freeze python-daemon pip module to 2.1.2

## Git

* starting 5.1rc8


# 5.1rc7

## Feature

* When `stack sync host network localhost` is executed, cleanup the ifcfg-* files that

  *don't* have the stamp that indicates the ifcfg file was written by Stacki. The stamp is:

        # AUTHENTIC STACKI

* Add environment scope for routes and firewalls

  BREAKING CHANGE:
```
  CREATE TABLE environment_routes (
    Environment   int(11) NOT NULL default '0',
    Network       varchar(32) NOT NULL default '',
    Netmask       varchar(32) NOT NULL default '',
    Gateway       varchar(32) NOT NULL default '',
    Subnet        int(11) default NULL references subnets,
    Interface     varchar(32) default NULL
  );

  CREATE TABLE environment_firewall (
    Environment   int(11) NOT NULL default '0',
    Tabletype     enum('nat','filter','mangle','raw') NOT NULL
                  default 'filter',
    Name          varchar(256) default NULL,
    InSubnet      int(11) default NULL references subnets,
    OutSubnet     int(11) default NULL references subnets,
    Service       varchar(256) default NULL,
    Protocol      varchar(256) default NULL,
    Action        varchar(256) default NULL,
    Chain         varchar(256) default NULL,
    Flags         varchar(256) default NULL,
    Comment       varchar(256) default NULL
  );
```

* add subnet and interface columns to list route; clean up list route and add route
* Move 'stack report system' to its own package

* Checkin of baseline code to interact with Mellanox 7800 IB switch.

  This code provides the capability to:

  * add ssh keys
  * toggle and display subnet manager status
  * create/delete partitions based on the 'ibfabric' and 'ibpartition' parameters in the management host interface
  * add/remove members from partitions, based on the 'ibpartition' parameters in their ibN host interfaces
  * members are added at differing membership levels, determined automatically

* Remove insert-ethers

  The newer node discovery code replaces the older insert-ethers. This
  commit also removes a few pylib files no longer used.

  The backup-db script is moved into the admin package.

* dump and load system configuration information into and out of a json document

* Add a check in 'stack report system' for named

## Bugfix

* fix sync host network cleanup for redhat

* Reverse the way `stack sync host network localhost` works.

  Keep all ifcfg files in /etc/sysconfig/network that *don't* have the Stacki stamp
  (AUTHENTIC STACKI) and remove all the ifcfg files that do have the Stacki stamp. Then later
  in the command, new ifcfg files will be written for each interface in the database for the
  frontend.

* Update `stack list switch config` to output info about *general* and *trunk* ports as

  well as output the coorelation with the hosts' interfaces.

* Suppress error message when removing routes from the live routing table.

* Expand firewall rules to multiple lines when needed in iptables.

  A firewall rule in the database can expand to multiple iptables rules in a couple cases:

        1) The database rule refers to a network that associated with multiple interfaces on
        the host.

        2) When 'protocol' equals 'all' and there is a 'service' specified.

  In case 1, we need a separate rule for each interface.

  In case 2, we need two separate rules, one with '-p tcp' and one with '-p udp'.

* [WebService] 'stack add pallet .iso' requires root for loopback mounting

* [WebService] remove the unneeded admin web interface as well as list_dir functionality

* [WebService] Fix string encoding bug in web service, and disable debug output from django

* Fix Stack report host bootfile so that it doesn't throw stack traces

* Fix stack sync host firewall restarts

  1. The current code uses the OS information of the frontend
     to decide which commands to run. This means for SLES 11
     backends installed from a SLES 12 frontend, the sync host firewall
     command will always be wrong, and error out.
  2. Cleanup firewall startup script for SLES 11 SP3.
     Add status, and restart commands to the service script

* Make argument processors in stack commands work consistently

  Continuation of a previous fix, some of the code went on walkabout but
  it is back now.

  Now fails when any of the following objects do not exist:

  - appliance
  - box
  - cart
  - environment
  - host
  - network
  - os
  - pallet

* In *stack report switch*, don't output a `vlan` stanza if there are no vlans

  configured for any backend hosts, and don't output a line that tells the switch to not
  DHCP for its management IP address (once you set the IP address, the switch automatically
  puts the management IP in `static` mode.

* Add test cases for add host and list attr

* stack add host won't accept empty string as rack and rank

* Modifying code to remove long name from appliances

  BREAKING CHANGE:
  ALTER TABLE appliances DROP COLUMN Longname;
  Replace places where longname is used to the appliance name.

* WS incorrectly handled params with `=` in value

  While we are here also
  - move logging to local1 (was local2)
  - log the complete command line called

* Log and ignore incorrect inconfigurations during reports

* in report system, only check named if it needs to be checked.  Also added a check for sshd.

* Validation of host interface before entering them in etc/hosts file

## Git

* starting 5.1rc7

# 5.1rc6

## Feature

* Add a check in 'stack report system' for named

* Upgrade to Python 3.6.6

* turn status field into a real feature

  Enhanced the message queue status reporting to be hostid based (not
  hostname) and added a ttl to all messages. The first part fixes issues
  when hosts are renamed and the status gets lost, now everything is
  keyed off the ID from the nodes table (permanent for lifetime of
  host). The second allows us the age out messages at different rates.

  Instrumented multiple parts of the installer to send more fine grained
  status messages. The typical workflow of a system install will see the
  following messages:

  | message                   | ttl  |
  | ------------------------- | ---- |
  | install profile request   |   30 |
  | install profile sent      |   30 |
  | install profile           |  300 |
  | install download          | 3600 |
  | install stage=pre         | 3600 |
  | install stage=pre-package | 3600 |
  | install download          | 3600 |
  | install stage=post        | 3600 |
  | install reboot            |  300 |
  | install stage=boot-pre    | 3600 |
  | install stage=boot-post   | 3600 |
  | online                    |  120 |

  The `install download` is seen both before the second stage image
  downloads and rpm tracker lookups. All `install *` messages should be
  thought of as the previous `install` and the extra information is for
  debugging and may change at any time.

  The `online` state was previously called `up` and just meant that the
  installer's first pass was done and the host was on the network. For
  SuSe it could be seens even though the second pass of the installer
  was active. To improve on this Stacki now tracks is `sshd` is running
  as a seperate state (piggy-back on the existing health message). The
  inspired a new command `stack list host status` which a `state` and
  `ssh` fields. The `state` field is the previous health message as
  described above. The `ssh` field is `up` IFF sshd is running, and None
  if it is not (TTL same as the `state` health).

  The new `stack list host status` command means:

  - `stack list host` `status` field is now *deprecated* and will be
    removed in the next release. Just still present to keep existing
    consumers from crashing but it will always says *deprecated*.

  - pluggins can be used to add move status (is service X runnning?)

  Other stuff:

  * update Redis to 4.0.11
  * change rmq to smq
  * health channel is now json payload (backwards compat with
    old text - but will deprecate)
  * stack-mq is now in the installer (SLES only)
  * stack-publish.py is gone replaced by updated smq-publish
  * fixed some leftover Python3 transition encode()/decode() bugs
  * remove old processors related to StackIQ Enterprise
  * changed `message` field in `Message` to `payload` (less confusing)
  * added psutil to foundation-python-packages
    * this requires refreshing version of all python code
    * hard code PyMySQL to 0.8.1 (newer version require newer pip)

  ToDo:

  * Instrument RedHat installer
  * Need a `install start` state (where to trigger it?)
  * fix test_enable_discover.py

* Added the ability to have 'auto' in the IP address field in a host configuration spreadsheet and 'set host interface' command.

  Host IP address will be automatically assigned based on the network address, mask.

  JIRA: STACKI-419

* remove the dump command

* Enhance `stack add pallet` to recognize and add SUSE Enterprise Storage media.

* Add 'load hostfile' test for duplicate interfaces

* add cart accepts url and credentials on the command line

  BREAKING CHANGE:
  ALTER TABLE carts ADD url TEXT;

  list pallet expanded=true displays the url
  generalize the download function of add pallet and place it in pylib
  from stack.download import fetch
  file = fetch(url, username="", password="")
  username and password are optional

* add ability to list supported switches

* Split switch library into multiple files

* Add vendor/make to output of 'stack list switch'

* Add tests for 'stack add/remove host alias'

  JIRA: STACKI-286

* add a url column to the rolls table

  BREAKING CHANGE:
  ALTER TABLE rolls ADD url TEXT;

  add an optional expanded parameter to list pallet to display the url
  accept username and password parameters for downloading pallets

* [add,list] storage [controller,partition] with 'os' scope

  changed sql commands to the new format to prevent injection

## Bugfix

* Validation of host interface before entering them in etc/hosts file

* `stack report ansible` remove padChar `------` from output

  Also moved ansible into foundation-python-packages, and cleaned
  up the code to use correct stacki-style argument parsing

* when adding a new api group, if the group already exists, the command error that gets raised is malformed

* Ensure `stack report host` only produces unique entries.

* Update interface information with MAC addresses correctly

  When installing a backend node, all the interfaces are reported
  back by the installer. Any interfaces missing on the frontend,
  will be added to the database.

  The Bug is - when interfaces are specified in the database, with
  all the information except the MAC address, this call fails to
  update the MAC address.

  This commit fixes that.

  FIXES: JIRA STACKI-585

* Set the frontend root password during frontend-install.py

* minor tweak to make running set-up.sh more user-friendly

* Plugins no longer run on a remove of an empty a:backend

* Prevent syncing dhcpd with duplicate host interfaces

* Fix database backup cronjob script

* Major overhaul of the Dell x1052 ethernet switch configuration code.

  BREAKING CHANGE: Apply 'ALTER TABLE switchports DROP PRIMARY KEY;' to database.

* Prevent loading a hostfile with entries containing an IP but no network

  This fixes JIRA: STACKI-551

* In select(), we need to stringify the sql parameters to be able to join() them.

* Prevent set host boot from throwing exception when given a valid-but-empty host specification.

* add api user needs to return formatted output

  This fixes JIRA: STACKI-536

  When running ```stack add api user```, the code would print
  the credentials of  the user that were just created.
  This mean when this command was called through the ReST API,
  it would fail, since it would print the output on standard out,
  and not through stacki command line formatted output.

  This commit fixes the above problem.

  FEATURE: Calling "add api user" from the ReST API returns JSON

  The following JSON
```
  [
      {
          "hostname": "front.end.name",
          "key": "ran.dom.key",
          "username": "user.name"
      }
  ]
```

  This can then be parsed by clients for future use.


* fix typo in remove storage partition and prevent call/command list.firewall from printing other appliance rules as their own

* 'sync host network' continues without backend's ssh available

* Added more required input and error handling for "remove storage partition"

  Now requires device="*" to remove all scope=global partitioning
  Warns when using deprecated host input without scope=host
  Warns when using a non-existent scope

* Removed extra "." on PQDN

## Git

* starting release 5.1rc6

# 5.1rc5

## Feature

* cleanup report attrfile

  print each entry on a single line
  ignore attrs with empty values; if loaded back these will erase attrs completely
  unload attrfile updated for python 3

* Add "chassis power" commands to control and list the power settings of hosts.

  To set the power on a host, execute:

  `stack set host power {host ...} command="on"|"off"|"reset"`

  To list the power for a host, execute:

  `stack list host power {host ...}`

## Bugfix

* SLES nukedisks=false is now functional :floppy_disk:

  JIRA: STACKI-307

## Git

* starting release 5.1rc5

# 5.1rc4

## Feature

* Add carts using URLs. Remove Unpack Carts

  Add carts using URL.
  Remove "unpack" cart command
  Clean up docstrings. Use authentication for downloading
  carts using URLS

  Fixes JIRA: STACKI-503

* Reject common hostnames ('frontend' and 'backend')

  This fixes JIRA: STACKI-350

* Add user settable host metadata

  This is similar to the AWS meta-data, the idea being a container for
  arbitrary data unique to a host. `stack set host metadata` is used
  to set this and the data itself is made available from a read-only
  host attribute called `metadata`.

  The same thing could have been accomplished using a standard attribute,
  but the intention is to have the semantics that this is unique to a host
  and not subject to the standard attribute inheritance rules.

  BREAKING CHANGE: schema addition
  ```
  $ mysql cluster
  MariaDB [cluster]> alter table nodes add column MetaData text default NULL;
  ```

* Have the test-framework VMs use less RAM

  Change all the VMs to be created with 1GB of RAM instead of 2GB. That
  should still be enough for them to get their jobs done.

* Generate Release Notes Automatically

  stack-releasenotes is installed on all nodes

  This is generated from the Git Log and assumes the new nice
  format for commits. Ugly old git logs are also included (for now)

## Bugfix

* Cart permissions need to be recursively applied.

  Cart permissions were only being applied at the top level, and
  to the files in the directories. None of the directory permissions
  changed. This commit fixes it so that directory permissions change
  as well

* Give backends 2GB each during tests

  It turns out that the Centos 7 backends don't like to install into
  anything with less than 2GB of RAM.

* Don't install the stacki-releasenotes package on SLES11

* `stack list os`

  `list os` needs to trick the endOutput code to report only one column, all
  other commands report multiple columns. Recent changes in endOutput broke
  the trick. For `output-format=json` the was not broken, only for `text` output.

* `stack list host` sorts hosts by rack/rank numerically then alphabetically

  Hosts will be sorted by rack numerically first, then alphabetically. That is, all hosts with
  numerical rack values will be listed first, then all hosts with non-numerical rack values will
  be listed last.

  Hosts with the same rack value, will be sorted numerically first, then alphabetically. Below
  is an example output of `stack list host`:

  | HOST            | RACK      | RANK       | APPLIANCE|
  |-----------------|:---------:|:----------:|----------|
  | stacki-2-1      | 0         | 0          | frontend |
  | backend-0-0     | 1         | station-11 | backend  |
  | ethernet-2-1    | 2         | 1          | switch   |
  | stacki-2-10     | 2         | 10         | backend  |
  | stacki-2-11     | 2         | 11         | backend  |
  | stacki-2-12     | 2         | 12         | backend  |
  | infiniband-2-18 | 2         | 18         | switch   |
  | infiniband-2-20 | 2         | 20         | switch   |
  | ethernet-2-43   | 2         | 43         | switch   |
  | backend-0-1     | sector-42 | 2          | backend  |
  | backend-0-2     | sector-42 | 3          | backend  |
  | backend-0-3     | sector-42 | 4          | backend  |
  | backend-0-4     | sector-42 | station-8  | backend  |

* Ignore drop database warning

  This fixes JIRA: STACKI-493

* SLES11 doesn't have the stack-releasenotes package (currently)

* Better handling for old pip wheel files

  pip2src crashed on a package update because it of lazy parsing
  of the METADATA file.

* stack-releasenotes missing from manifest

## Git

* starting release 5.1rc4


# 5.1rc3

## Feature

* Separate `stack remove storage partition` into commands based on scope.

  Below commands have been introduced:

  - stack remove appliance storage partition
  - stack remove host storage partition
  - stack remove os storage partition
  
  JIRA: STACKI-246

* Add non-ethernet interfaces to database

  - Send back ipmi interfaces, and InfiniBand interfaces to frontend, during install.
  - On brand new machines, root user is not created or enabled in the BMC.
    This explicity creates, and enables the root user.

* Add new exception ArgNotFound for invalid entities

  Don't return CommandError for bad lookups in *ArgumentProcessor, instead return ArgNotFound

* Add test-framework to Stacki codebase

  This moves the stacki-test-framework project into the stacki
  codebase so that the tests can be easily kept in sync with
  changes to the code.

* More boot argument for Console Installs

  - Add i40e driver support for all SLES 11 SP3 installs. This will load
    the Intel i40e driver into the kernel. If we happen to use Intel Purley
    nodes, then the driver gets used. Otherwise, it gets ignored.
  
  - Add nomodeset and textmode for all console installs
    We do not require X drivers for console installs. On Intel reference
    nodes, installs will stall if it tries to load the X VGA driver. So
    force it to not load the drivers.

* Calculate, report and list the MD5 hashs for hosts.

  Calculate, report and list the MD5 hashes of a host's:
  	- pallets
  	- carts
  	- profile (e.g., kickstart file, autoyast file, etc.)
  
  This will be reported by a host via the message queue.
  
  One can check if a host is 'synced' or 'notsynced' by executing:
  
  	stack list host <hostname> hash=y
  
  The above command adds a 'HASH' column with the status.

* add ability to specify 'channel' as a parameter for `add host interface`

* Make table output format more consistent.

  `stack list` commands with NULL output in the last column will now have -'s printed
  up to the width of that column's header as in other columns.
  
  This allows cell filling in the 'channel' column of `stack list host interface`,
  without cluttering the output with lots of -'s in `stack list host` if 'comment' is long.

* Add jmespath module

  This module is needed by Ansible's json_query filter.

## Bugfix

* stack load storage partition failed for host partitions

  This was a new bug since stacki-5.1rc2

* Run udevsettle to wait for controller config to finish

  When configuring the controller, the command can exit, but the controller
  still hasn't completed configuration.
  udevsettle waits until the controller is done, before generating
  partitioning info

* Remove `stack run host test` since it requires salt

  This was old code left over from StackIQ Enterprise. It's great stuff
  but beyond the mission of ping and prompt. It may come back again
  one day.
  
  Removed this since it was barfing on the code coverage tests due to
  missing python modules.

* WS flush cache and don't return stack trace on CommandError

  WS runs multiple threads with each long lived thread managing its own
  cache. A thread cannot invalidate another thread's cache, so always
  flush right before running the stack command (subcommands still use
  the cache).
  
  Previously we sent the stack trace on CommandErrors, now behave the
  same as stack.py and send the nice error message.
  
  Code cleanup based on flake8.

* Allow correct python db api parameters

  Allow our sql methods (execute() and select()) to accept either our current
  style, which is vulnerable to sql injection, or the correct style which allows
  the database driver to correctly handle escaping parameters.  This will let us
  migrate code to the safer syntax gradually.
  
  See github issue #198 for more details

* Check for duplicate hosts correctly

  When using self.db.select function, make sure to not
  have "select" as the first word in the sql statement.
  This is implicit, and adding it will cause the code to
  fail.

* make new appliances 'managed' in some situations

  Appliances are already set to `kickstartable==True` if `node==backend`
  This piggy backs on that behavior to make them also `managed==True` :paperclip:
  
  Remove redundant appliance attributes.

* Loading hostfile csv throws error on frontend renames :lock_with_ink_pen:

  CommandError(self, 'Renaming frontend is not supported!')
  JIRA: STACKI-272

* Run pallet fails if frontend has more than one pallet of the same name

  If there are 2 pallets of the same name on the frontend, even if they happen to
  be different versions, or releases, and they belong to different boxes, "run pallet"
  will still fail on an SQL subquery.
  
  Make the SQL query cleaner, and context specific.

* blank `run host command=` no longer hangs

  :runner:
  JIRA: STACKI-325

* stack list host graph

  Bring `stack list host graph` to the 21st century

* Refer to the correct information

  When printing nukecontroller information, refer
  to the list that contains nukecontroller information
  and not the nukedisks information.

* cleanup entity names in example csv files

* Make api response return JSON

  The api response was mistakingly running json.dumps against the text
  version of the command response, causing the output to be double
  encoded.
  
  This fixes JIRA: STACKI-432

## Git

* starting release 5.1rc3

* Update README.md

* Update README.md


# 5.1rc2

## Git

* make report.version nicer for output-format=json

* 5.1rc2 start

* remove mariadb.tar.gz from the list of 3rd party packages to download

* The 'list.host.interface' changed to return cached data, and the cache

  isn't expired when the daemon adds newly discovered hosts via
  subprocess calls. We don't need the DB cache for our purposes.
  
  Clear the cache when needed.

* Make OS bootactions os-less

  - fix the XML that sets this
       - fix list bootaction to find os-less actions

* Add os param explicitly for install actions of type=install

  Added ID (primary key) column to bootactions table since mariadb does not
  allow primary keys to have NULL values.
  
  Refer https://mariadb.com/kb/en/library/primary-keys-with-nullable-columns/ for more information.
  
  Removed validation code that makes os param mandatory for action=install.
  This breaks existing bootactions in node xml files.
  
  Add os param explicitly for install actions of type=installl
  
  Add default os only for boot action type=install
  
  Updated set bootaction kernel, args, ramdisk to handle case where OS=null

* Cleanup output of list storage partition.

  Now it's ordered by scope, device, partid, size, and fstype

* Add i40e network driver to SLES 11 SP3 Initrd :car:

  Updated README for i40e driver

* When using shortnames, stack run host can break

  When an interface in the database is set to use shortnames, that
  becomes its quasi-default interface, since that shortname is how
  run host connects to the node.
  
  However, it's possible that this interface is not on a network that
  the frontend can access. If that's the case, the frontend cannot run
  a run host command against it.
  
  To avoid this problem, we use the 'stack.network' attribute. This will
  tell 'run host' which network to use when talking to hosts. If this
  attribute doesn't exist, 'run host' will use the shortname
  (default old-style behaviour)
  
  Use fully qualified domain names when syncing firewall
  
  Use getRunHosts method to get fqdn for  hosts. Scaling improvements
  
  Decode the output of subprocess before returning
  Fix report host network, and make is OS specific
  Fix sync host network again to run the entire command in parallel

* remove wxpython and dependencies, doesn't touch code


# 5.1rc1

## Git

* bugfixes for rmq (and shortname)

  - When sending a string use send_string
  - Allow rmq-publish to connect to a remote host
  - We need to decode() the hostname
  - Ignore hosts that are not in the cluster
  - Need netifaces on backends

* SLES does not like MAC addresses that are uppercase.

* fix tiny typo because I copy-paste :mag_right:

* starting release 5.1rc1

* add default database to root's my.cnf

* overhaul database.xml to force mariadb config to common known state across distros

* Bug fix. Initialize empty group set for each host

* Too many quotes

* ludicrous cleaner is a method, needs itself :name_badge:

* If the 'stack list host xml' fail return the stack trace with a 500

  error to force the backend to try again.

* remove foundation mariadb and use only system mariadb. big savings on compile time.

* Add more documentation to add host route command :green_book:

* scim package should have 'foundation' in the name :confounded:

* call ludicrous-cleaner on add pallet and add cart

  Add status route
  
  Add silent flag to curl command :speak_no_evil:
  
  Service that erases all packages being tracked by Ludicrous

* remove unused package

  check for the frontend correctly
  
  lets check if its the frontend properly :sparkles:

* Change interface "default" behaviour :network: :bus:

  Setting an interface to default causes 2 events.
  1. Set the shortname of the host to the default interface
  2. Set the default routing for the host
  
  Change behaviour so that 1 can be overridden by setting an
  interface option. Setting interface option to "shortname" causes
  the shortname to be assigned to that interface instead.

* Modify .Jenkinsfile to clone iso-builder

* Fix BoxArgumentProcessor typo

* Switched more self.db.execute to self.db.cache

  Tossed SQL out of add host and use commands
  Tossed getHostnames out of add host and use SQL
  
  tests/test_scale.py::test_scale
  size = 10
  add host                         1.409s
  list host                        0.163s
  list host profile                0.639s
  remove host                      2.214s
  size = 20
  add host                         2.859s
  list host                        0.175s
  list host profile                0.661s
  remove host                      2.389s
  size = 30
  add host                         4.346s
  list host                        0.193s
  list host profile                0.736s
  remove host                      2.482s
  size = 40
  add host                         5.670s
  list host                        0.242s
  list host profile                0.748s
  remove host                      2.514s
  size = 100
  add host                         14.380s
  list host                        0.354s
  list host profile                0.898s
  remove host                      3.069s
  size = 1000
  add host                         159.959s
  list host                        3.801s
  list host profile                4.293s
  remove host                      15.800s

* Added timing for generating a single host profile (was 30 seconds @ 1000 nodes)

  Fixed SQL Cache to be Global (was per DatabaseConnection instance)
  Fixed --debug flag for stack.py
  
  tests/test_scale.py::test_scale
  size = 10
  add host                         1.321s
  list host                        0.159s
  list host profile                0.702s
  remove host                      4.326s
  size = 20
  add host                         2.716s
  list host                        0.191s
  list host profile                0.711s
  remove host                      4.355s
  size = 30
  add host                         4.087s
  list host                        0.208s
  list host profile                0.803s
  remove host                      2.417s
  size = 40
  add host                         5.571s
  list host                        0.247s
  list host profile                0.814s
  remove host                      2.635s
  size = 100
  add host                         14.913s
  list host                        0.426s
  list host profile                0.995s
  remove host                      5.209s
  size = 1000
  add host                         357.486s
  list host                        3.895s
  list host profile                4.608s
  remove host                      15.940s

* remove extra parentheses

* use the max_vlan attr instead of hard coded 100

* write the static ip block

* store switch name in a variable instead of using the dict

* Disable the 'bootflags' attribute cleanup

  This was used back when we modified the grub files, it is now dead code
  This fixes the 'remove host' scaling.
  tests/test_scale.py::test_scale
  size = 10
  add host                         1.339s
  list host                        0.141s
  remove host                      4.456s
  size = 20
  add host                         2.751s
  list host                        0.134s
  remove host                      2.585s
  size = 30
  add host                         4.123s
  list host                        0.146s
  remove host                      2.706s
  size = 40
  add host                         5.634s
  list host                        0.152s
  remove host                      3.009s
  size = 100
  add host                         15.263s
  list host                        0.164s
  remove host                      3.633s
  size = 1000
  add host                         358.226s
  list host                        0.832s
  remove host                      21.424s

* Fix the test_scape.py test

  Output below (numbers don't matter the scaling does)
  'remove host' is messed up
  
  tests/test_scale.py::test_scale
  size = 10
  add host                         1.315s
  list host                        0.135s
  remove host                      2.886s
  size = 20
  add host                         2.798s
  list host                        0.141s
  remove host                      3.439s
  size = 30
  add host                         4.200s
  list host                        0.145s
  remove host                      4.483s
  size = 40
  add host                         5.825s
  list host                        0.160s
  remove host                      5.617s
  size = 100
  add host                         15.259s
  list host                        0.186s
  remove host                      16.499s
  size = 1000
  add host                         361.726s
  list host                        1.431s
  remove host                      1485.701s

* Update service check to include more port definitions :ballot_box_with_check:

* Add 'switch_max_vlan' attribute

  The purpose of the attribute is to limit the vlan id that can be
  set on a port. The reason being is that if the vlan is too
  high, the switch can lock up or the connection may timeout when
  the switch is being configured.

* remove configure method

* Add more exception handling. Created a SwitchException

* disable ludicrous service check in 'report system'. A future commit will add back some form of check against an endpoint still to be written.

* exception touch ups

* remove unused packages

* Remove discovery code

* Switch command fixes

  Fix import error
  
  Fix switch interface commands
  
  Add interface param to 'add switch host' command
  
  Interface column in 'load switch hostfile'
  
  Add interface column to hostfile report :fire:
  
  Add load switchfile command
  
  Add report switchfile

* Fix ludicrous client exeptions that were crashing the client

  If the network changed while in the middle of package
  installation, requests would timeout and raise an exeption
  that was unhandled.
  
  All execption are now handled with logs about which function
  is throwing the exception.
  
  Also, every request is retried 3 times to give time for
  the new connection to come up if something did happen
  with the network. Letting requests handle this wouldn't
  create a new connection.

* Support for setting final_reboot and confirm options for sles

* Revert "Changes for altering 'os' column in bootactions table default to NULL value"

  This reverts commit b67827a4f124ef121c61a4eac3374090cf68f073.

* Revert "Changes for altering 'os' column in bootactions table default to NULL value"

  This reverts commit d074da12efe0a5a327c85a79be566bc3ea90a127.

* Revert "Removed debug print statements"

  This reverts commit 52cd93031ac14d274ddc3374bd4b48fbcc5a1b80.

* Revert "Remove os parameter for bootactions of type os"

  This reverts commit 7fe55937310058dd8379f84ccc26b8f22c01743d.

* Revert "Changes for altering 'os' column in bootactions table default to NULL value"

  This reverts commit b67827a4f124ef121c61a4eac3374090cf68f073.

* Revert "Remove os parameter for bootactions of type os"

  This reverts commit 01f47511b3d7973d99369e196578f3318c068a75.

* Add 'Server=' to SLES 11.3 bootactions

* add purge route to clear the redis cache of all packages

* Add ludicrous prefix to all packages

* removed bz and lmza compression.

* import stacki.api

* Quick fix for True issue :anguished:

  Really I think this needs a bit of an overhault to use bools. Until I get the autoyast working for nukedisks=false I don't want to dive into that due to the large number of tests required.

* remove port for peerdone call :sparkles:

* lets put the config file in the correct directory :clap:

* D'oh! tftp runs on UDP not TCP :fire: :brickwall:

* Remove os parameter for bootactions of type os

* Removed debug print statements

* Changes for altering 'os' column in bootactions table default to NULL value

* Changes for altering 'os' column in bootactions table default to NULL value

* move conditional to script tag

* Remove os parameter for bootactions of type os

* Not enough script tags :fire: :skull:

* simple services are not simple :no_entry_sign:

* place configuration file in appropriate location for httpd and apache2

* remove ludicrous route prefix in ludicrous server since apache is handling that now

* Bug fixes. :bug:

  Disable the correct service
  Use full path for stack command

* Removed debug print statements

* Changes for altering 'os' column in bootactions table default to NULL value

* Changes for altering 'os' column in bootactions table default to NULL value

* Enable DNS for SLES frontends :name_badge:

* Reduce scope of intrinsic firewall rules :large_orange_diamond: -> :small_orange_diamond:

  Fixes JIRA STACKI-342
  The Current Intrinsic Firewall rules are generated
  on a per-network basis to allow HTTP, HTTPS, RMQ,
  and SSH access to all hosts on a network that is
  PXE enabled.
  
  These ports are then open on all hosts (frontend and
  backends) whether they are required or not.  This can
  be a security problem for unsuspecting admins.
  
  Change this as follows:
  For all PXE capable networks, the firewall configuration should be
  1. Frontend allows access on HTTP(S), TFTP, and RMQ ports
  2. Backends allow access on SSH, and RMQ-control ports
  
  For all DNS enabled network, the intrinsic firewall configuration should be
  1. Frontend allows access on DNS ports (Both UDP and TCP)

* Remove the need for a separate port

* Pushing files that were missed for STACKI-92 'Fill in missing command docstrings'

  https://jira.td.teradata.com/jira/browse/STACKI-92

* :mailbox_with_no_mail: remove up.py and disable the cronjob for sles11

* different config file location for redhat

* autostackily generate a manifest file for 3rdparty rpm's

  adds optional 'manifest' flag in 3rdparty.json
  skips non-rpm files and is false by default :page_with_curl:

* add a try/except around file saving

* add some documentation :ledger:

* undo initrd

* Burn it to the ground :fire: and start over :hatching_chick:

* start ludicrous-client on redhat as well

* lets actually start the ludicrous client :rocket:

* put ludicrous client service file in the right place

* include ludicrous config file

* BugFix (minor)

  Allow the zone for the default network to be blank.
  Prior, if this was the case /etc/resolv.conf had "search " in the file.

* Can't assign a port to a vlan Id without first creating it

* Use rpm to infer name,arch,version, release :fire:

  BUG: When Stacki moved to python3, the `import rpm` and related
  python calls failed. As a fallback, we relied on parsing the
  filename to get basename architecture, version, and release,
  using `string.split` and regex-es.
  This meant that if an RPM has a non standard file name, we
  don't get the RPM information, and ignore the file.
  
  FIX: Use the `rpm` utility to get all the information that we need.
  
  FIXES: JIRA STACKI-323

* Unpack fixes.

  Docstring fixes.

* Fix unpack.

* Pack/unpack fixes.

* Ported bonding code into SLES release.

  Moved redhat/nodes/node.xml and sles/nodes/node.xml into common/nodes/node.xml.
  
  Improved code that sets ip_forward to 1. It sets ip_forward to 1 even if ip_forward is
  not in /etc/sysctl.conf.

* show the correct network :fire:

* fix path to ludicrous-client

* let apache handle ludicrous with wsgi

* Default 'INSTALLACTION' and 'RUNACTION' are now 'default' and 'default' (not 'install' and 'os').

* The default serial console at Teradata is ttyS0, not ttyS1.

* Dont write a comment for a firewall rule that not generated.

* fix variable name

* Fix massive hole in firewall :boom:

  When a firewall rule is defined for a network, if a host does NOT
  have an interface on that network, a rule is generated to accept
  all traffic on all interfaces for that host. Essentially no firewall.

* barnacle.xml fix centos / same as sles

* Fix version.mk

  Again
  Stop doing this
  Please
  
  :gun:

* SLES11 doesn't have stack-switch

* Put node-certs in common.

  Remove node-certs from sles/redhat.

* mod_wsgi fixed in python-packages

  I think Mike fixed this and I built it first
  :poop:

* set switch interface commands

* forgot myself

* throw an error if one or more tests fail

* remove conflicting file

* AWS

  Fix zypper repos before barnacle
  Add pallets twice so SLES gets patched

* Change how RPM.STRATEGY=copy works.

  When using RPM.STRATEGY=copy, the expectation is that all
  RPM files are already part of the source tree. However,
  if RPMS are downloaded during build time, the copy targets
  are created before any RPMS are downloaded, causing the copy
  command to fail.
  
  Instead, we now source makefile target directly, so that the
  copy target isn't calculated until make is called directly

* Simplify the database "grants" and create a "restore" script for the database that applies

  the latest database dump and reapplies the grants.

* remove redundant partitionid in 'list storage partition'

* Install stack-switch

* Don't need to lowercase spaces

* fix the spaces :rocket:

* Replace translate() with replace() -- it is a python 2 -> 3 thing.

* Some whl files don't contain a metadata.json so we need to check

  for a file METADATA
  
  This commit requires a new 'make bootstrap'

* dependency for stack-switch

* add switch appliance and set managed to false

* remove list vlan as it doesn't return any useful information

* add support for username and password attr

* Fix for read-only serial console that runs in the second stage of YaST.

* Update README.md

  Added Slack Invite Link

* fix some copyrights

* nvme matching regex missing a pipe

* Port the 'noreport' option from Red Hat to SLES.

* Add the message queue ports to the intrinsic firewall rules

* implementation for sync switch

* implementation for report switch

* implementation for list switch status

* implementation for list switch mac

* update ludicrous to handle network timeouts with 'Dad Mode'

* Filled in missing docstrings for stacki commands.

  https://jira.td.teradata.com/jira/browse/STACKI-92

* add implementation to list switch config

* add implementation to list host switch status

* Give the user a way to put the serial console into read-write mode while in the second

  stage of the yast installation (the yast code that run on the first boot).
  
  The use case is we really want serial console read-only to be set, but we need a way to
  temporarily turn it off so we can debug.

* 3825 != 3285

* report switch hostfile

* load switch hosfile

* check for host on same network

* Update storcli. Support for SSDs that don't support full disk encryption

* check if host exists before trying to add it to the switch

* remove set switch host  vlan command

* Add plugins for remove host interface to support aliases

* Check for matching network on the frontend

* Should have been using node instead of name when querying networks table

* missed a line

* Require hostname when removing alias

* Avoid duplicating existing host as alias.  Taylor Sanchez committed

  Maybe there should be the reverse as well when adding a host, otherwise "stack report host" could generate some dumb host files.

* Revert "Avoid duplicating existing host as alias."

  This reverts commit a76c36e94f98095ad1d79e6e551d5e3639a33f8d.

* Fixed a mix up of device and interface

* Avoid duplicating existing host as alias.

  Maybe there should be the reverse as well when adding a host, otherwise "stack report host" could generate some dumb host files.

* minor code refactor

* set default vlan to 1 if nothing is set

* docstring update

* Move redhat specific code into the redhat implementation

* Python string "None" is not the same as mariadb NULL value

* Few more fixes from testing.

* add arguments for switch reports

* call report switch before syncing switch

* Bug fix. Don't make sure localhost rule doesn't open up the firewall

* Database scheme update, I should have changed Node to Network, not Name.

* Actually Updated zones to handle new alias database scheme

  I didn't grab the files from the server, and commited some half wirtten code earlier. Also appears to have fixed some tabs vs spaces issue I introduced with the bad commit.

* docstring for sync switch

* remove setting of static ip

* Figured that probably wouldn't work. Guess I'll copy the '0' from the line above.

* add ip address block in config file

* more docstring

* Updated zones to handle new alias database scheme

* Comment placement was messing with code folding, indented

* alias updates to allow per interface aliasing

* CentOS FE AMI works

* docstring for list switch status

* remove entries that match have switch entries

* Check for networks before trying to add a host

* some code refactoring

* remove switch host command

* update list switch host command

* fix report host interface command

* Update switch status to show host information

* fix ordering of db schema

* If a node has only 1 interface, and that interface DHCPs,

  then it doesn't have IP address, in the interfaces table.
  So hostaddr attr shouldn't be set.

* CentOS in the Cloud

* remove switch host command

* fix add.host.interface options=

  was missing quotes

* update report to use new switchports schema

* fix typos

* If the network is DHCP it might not have an ip or netmask set.

* use vlanid from networks table

* report switch fix

* sort mac address output

* fix doc

* fix missing tag

* update docstrings

* use getSwitchNames method instead

* change subnet to network

* remove confirmhosts param

* add 'raw' parameter to show raw output instead of tabled output

* switch 'host' to 'switch'

* rearrange columns

* add stack-switch to manifest

* switch host and switch column

* RedHat

  Use Kickstart_PrivateAddress as the tracker, this is what SLES does.
  But we need to create stack_site twice
       initrd (new code)
       %pre (storage.xml)
  
  Previously we used the next-server dhcp option which is fine for
  bare metal but doesn't work in AWS.
  
  So yeah, this is an AWS fix that happens to make RedHat and SLES
  do the same thing.
  
  Cloud rules !!!!

* Bug fix: Service and Table were switched.

  Enhancement: Consolidate all intrinsic ports to a single firewall rule

* D'oh! Forgot to move the Make infrastructure

* Move frontend-install.py from stacki-tools into stacki

* Decide between host based routing and switch based routing

* add list host switch status command

* add list host switch status command

* add model to list switch

* Add ability to put serial console into read-only mode during the installation.

  Controlled by setting the attribute 'read_only_serial_console' to:
  
  	'true'	- put the console into read-only mode
  	'false'	- put the console into read/write mode

* Bug fix. Remove unnecessary print

* document structure of 3rdparty.json and authfile.json

* Add authentication support to 3rd party code.

  Add retries when downloading fails

* Fix sles11 foundation-ansible manifest.

* Add rpms to ansible-base.

* Graph/node fixes.

* list switch status starting point

* add interface and host column to list.switch.mac

* Remove "stack set host address." A change to the frontend

  private network now absolutely requires a reinstall.

* Fix of add.host.interface options.

* Fix incorrect merge

* change add switch host to relect db changes

* change db schema to interface, switch, and port since vlan will be pulled from networks table

* add model to 'list switch'

* dhcp fix.

* Ansible changes.

* stacki output for macs

* stacki output for running config

* Copying to startup configuration optional

* duh

* move sync switch

* remove switch command

* stack add switch command

* Added pydocs for 'list firewall' code.

* report host interface

  fix for non-dhcp and virtual interfaces
         remove strip() and make sure everything is a string

* Added intrinsic firewall rules for pxe=True networks.

  Refactored 'list firewall' code to make it similar to 'list attr'

* Now using 3rdparty.json instead of 3rdparty.manifest

  You can know specify different sources for the blobs, at some
  point this could include sourcing from artifactory. Still
  provides a single source for each blob, but each blob could
  come from a different place.

* graph/node ansible xmls.

  report/sync commands.

* remove new aws packages from sles11 manifest, was breaking builds

* Ansible support.

* enable and disable switch host discovery daemon

* Add discovery option for host discovry on switches

* refactor code a bit

* Do the same thing for barnacle appliances and replicants.

* fix python whitespace (health processor was broken)

* report host interface - change dhcp code

  If an interface is 'default' and has the 'dhcp' option set the following:
     DHCLIENT_SET_HOSTNAME="yes"
     DHCLIENT_SET_DEFAULT_ROUTE="yes"
  For non-default dhcp interfaces set the above to "no"
  
  This was needed for AWS but will still work in Vagrant.
  
  Also cleaned up the code to use  'list host interface expanded=true' so
  we could remove the call to 'list network'.

* add test to see if stacki rest api is running

* happy new year

* New Frontend (ami-c61437bc) and Backend (ami-3e436044) AMIs

  To build a cluster
     1) Start a Frontend instance
     2) Use you AWS ssh key to log in after 5 minutes
     3) Start a Backend instance with the following in the user data
     { "master": "ipaddress-of-frontend" }
  
  There is no step four, you are done.

* organize files into separate folder

* set switch host vlan

* remove hard coded values

* set default vlan to 1 and set required to False

* remove exception for now

* add switch host

* Print hosts connected to each switch

* use new Switch method instead Host method

* Add a SwitchArgumentProcessor

* remove copy pasta

* create separate config file for each switch

* Get vlan config from switch

* Port management table. Defines what port a node is connected to on a switch.

* Check if redis has a status instead of calculating the time

* Fix directory paths

* Forgot to capatlize on more

* set timeout per host

* move writing config file into stack report

* Attributes uses a capital True.

  STACKI-178: My testing was hitting the blanked out fstab part of the if statement, so this morning I realized a completely fresh install doesn't function right. Quick fix.

* Found one more pallets attribute, swapping it real quick

  STACKI-215
  (Also I should have used an elif, but ignore that)

* Retry curl command when it fails downloading 3rd party packages

* Set ChallengeResponseAuth to true. Allows for password logins

* initial reporting for switches

* Using os and os.version instead of release

* reference correct attribute

* Fix sles11 build

  Looks like this was needed for the build process, otherwise sles11 builds fail on stack-discovery

* Add some stack commands

* Initial Switch Configuration :rocket:

* Separated out change for missing fstab on nukedisks=false

* Appears to be working for nukedisks=false

  Going to do some more testing, but most of this should be done.

* Only check the ip if it exists

* Missed file fix

* Fix links to packages.

  Fix references to other makefiles, and to localrepo

* Fix stack create package command.

* Small doc fix

* Start support for SLES 12.3

* Update redis status to 'Installing packages' during install

* Checkpoint: Actually install the new stack-discovery package on the frontend.

* Apparently we don't like conditionals on a <to> tag.

  Only on an <edge> tag

* syntax fix

* Checkpoint: Discovery builds as an RPM

* Put back replicant conditional

* use the release attribute instead of pallets

* Checkpoint: Add --no-install flag to just discover nodes and add them to the DB, but don't install an OS. Add --debug flag for more log output.

* add test_ to test filenames

* Checkpoint: Discovery daemon now sends out messages and the discover-nodes TUI displays them in a pretty way.

* for sles, disable the suse firewall, not firewalld

* fix host route bug

* remove hard coded value

* Removed hardcoded sles11=True

* Checkpoint: Created the basic TUI for discover-nodes. Now just to lay the MQ plumbing.

* Trying out the Jenkins build process

* add stack-barnacle to manifest to make builds stop failing

* cleanup fix for jenkins

* cleanup fix for jenkins

* stack add host interface bugfix

* Checkpoint: Add stack disable, enable, and report commands for discovery

* Only delete vm's on failure

* Jenkins needs a node

  This syntax is weird, and might not work with more than one builder...

* Docstrings update.

  CLI wiki code updated for python3.
  Merge branch 'feature/docstrings' into develop

* cleanup build vms

* Yeah, that's embarrassing.

* Be nice, for once. Mostly to yourself.

* Change "compute" to "backend."

* genrcldocs python3 changes.

  Markdown fix for help format.

* If no database is present stack report host shouldn't fail

* Revert graph structure to include mq-client for sles11 machines

* Getting closer to a Frontend AMI

  Build a barnacle appliance but don't run the graph
  	Generate site.attrs from host state when a new instance starts
  	Run the graph
  	Reboot
  	or so that's the idea it's 80% there right now

* also update routes file if syncnow is true

* encode subprocess call to utf-8

* check for different Apache service names

* Bug fixes

* Checkpoint: Remove all the SQL from the library, use command.call instead.

* Checkpoint: Can detect DHCP, add hosts, and see the kickstarts.

* Remove 'assumeyes=1' in repo configuration file -- zypper/yast does not support it, that is, with

  'assumeyes=1' in the repo configuration file, you'll see warnings like this in the log:
  
      Unknown attribute in [nginx-12-sles12]: assumeyes=1 ignored

* check for network and address compatibility before updating

* Support for building replicants

* Bridging support for SLES backends

* Enable Backend Re-Install for AWS

  aws-client-register.service
  
         Run after ever boot and query the Frontend on what to do
         1) 'os' - do nothing
         2) 'install' - configure grub2 and reboot

* Checkpoint: Discovery daemon can start and stop. Log monitoring code is async.

* SLES 12, the 'stack list host partition' command now outputs

  STACKI-110

* stack add host interface

  added options parameter
  
  stack report host interface
  	do not include ip information if set to DHCP (sles)
  	redhat already did this

* Split AWS code into

  stack-aws-client
  	stack-aws-server
  
  Backend AMI v1.0 is done

* AWS DHCP

  - Frontend and Backend both DHCP
  	- Don't server DHCP info for AWS hosts
  
  Start of init process for Frontend after the DHCPs with a new
  address. Reset DB information and grab the latest SSH certificate.

* Bug fix. Need full path for stack:shell

* Don't try to remove the route if it doesn't exist

* client can pass the appliance type

* Setup symlink to download kernel/ramdisk images

* check point

* Allow a new backend to register with the cluster and get a grub.conf

  that will start the installation.
  
  This is just a checkpoint, not turnkey right now.

* Can now build AWS machines w/ Yast (now start coding it up)

  - Fix pip2src to handle unicode data in package-info
  - Find the Frontend IP from user-data if not on command line
    Will likely remove this, I don't think this is really needed

* sync.host attribute functionality now moved to common node file

* STACKI-158: discover all interfaces in sles during install

* stack sync host firewall needs a decode and to restart stacki-iptables

  on sles, not iptables.

* Update README.md

* Setup symlink to download kernel/ramdisk images

* Copy Redhat's authroized_keys setup for SLES. It is simpler and fixes the backend install issue Bill and I were seeing.

* check point

* Fix DB abort connection warnings by closing the database connection when we are done with it.

* fix 'list pallet command' for python3

* Update README.md

* overwrite existing route if syncnow is true

* Bug fix for publish.py

  Install message queue for sles11

* add sync now args

* Add DHCP option support for SLES

* don't create routes for the frontend

* remove print

* create default host based route when supporting multitenancy

* remove print statement

* Update README.md

* Update README.md

* Update README.md

* Update README.md

* Allow a new backend to register with the cluster and get a grub.conf

  that will start the installation.
  
  This is just a checkpoint, not turnkey right now.

* Fix tags

* Add attribute key, value columns to csv file to support 2 different ways of specifying attributes.

  https://jira.td.teradata.com/jira/browse/STACKI-138

* Can now build AWS machines w/ Yast (now start coding it up)

  - Fix pip2src to handle unicode data in package-info
  - Find the Frontend IP from user-data if not on command line
    Will likely remove this, I don't think this is really needed

* adding a Jenkins build file

* Remove commented out wicked disabling sections. No longer required

  since we create network information early on

* D'oh! Remove Bad/Unnecessary line

* Don't disable wicked dhcp service. Required for interfaces

  that need to dhcp

* Update README.md

* Update README.md

* Set stacki-profile.py to discover all interfaces except loop back.

* update jenkinsfile to handle branches

* adding a Jenkins build file

* SLES Fixes

  STACKI-148 - SUX remove package
       STACKI-150 - SUX non-shell script

* vlans need to go in the shared network block as well

* if default route uses a virtual interface, use the main interface

* sles dhcpd.conf support for interfaces with multiple subnets

* Fix incorrect calling of CommandError

* Add syncnow feature to add/remove host route commands

* fix docstring for 'add host message'

* fix bug for 'stack add pallet' with no args

* Add interface column to routes tables.

  Specify interface to use in routing table.
  
  alter table commands:
  
  ALTER TABLE global_routes
      ADD Interface varchar(32) default NULL;
  ALTER TABLE os_routes
      ADD Interface varchar(32) default NULL;
  ALTER TABLE appliance_routes
      ADD Interface varchar(32) default NULL;
  ALTER TABLE node_routes
      ADD Interface varchar(32) default NULL;

* SLES12 - post-packages fix

  sles11
         - installs post-package after network is up
         - requires network scripts in the boot-pre section
  
         sles12
         - installs post-package before network is up
         - requires network scripts in the install-post section
  
         This change does both, tested in 11 and 12


