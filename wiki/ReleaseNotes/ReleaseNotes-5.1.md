## 5.1rc3

* BUGFIX: Run udevsettle to wait for controller config to finish
    
  When configuring the controller, the command can exit, but the controller
  still hasn't completed configuration.
  udevsettle waits until the controller is done, before generating
  partitioning info

* BUGFIX: Remove 'stack run host test' since it requires salt
    
  This was old code left over from StackIQ Enterprise. It's great stuff
  but beyond the mission of ping and prompt. It may come back again
  one day.
    
  Removed this since it was barfing on the code coverage tests due to
  missing python modules.

* BUGFIX: WS flush cache and don't return stack trace on CommandError
    
  WS runs multiple threads with each long lived thread managing its own
  cache. A thread cannot invalidate another thread's cache, so always
  flush right before running the stack command (subcommands still use
  the cache).
    
  Previously we sent the stack trace on CommandErrors, now behave the
  same as stack.py and send the nice error message.
    
  Code cleanup based on flake8.

* FEATURE: Separate 'stack remove storage partition' into commands based on scope.
    
  Below commands have been introduced:
  stack remove appliance storage partition
  stack remove host storage partition
  stack remove os storage partition
    
  JIRA: STACKI-246

* FEATURE: Add non-ethernet interfaces to database
    
  Send back ipmi interfaces, and InfiniBand interfaces to frontend, during install.
  On brand new machines, root user is not created or enabled in the BMC.
  This explicity creates, and enables the root user.

* FEATURE: Add new exception ArgNotFound for invalid entities
    
  Don't return CommandError for bad lookups in *ArgumentProcessor, instead return ArgNotFound

* BUGFIX: Allow correct python db api parameters
    
  Allow our sql methods (execute() and select()) to accept either our current
  style, which is vulnerable to sql injection, or the correct style which allows
  the database driver to correctly handle escaping parameters.  This will let us
  migrate code to the safer syntax gradually.
    
  See github issue #198 for more details
    
* BUGFIX: Check for duplicate hosts correctly
    
  When using self.db.select function, make sure to not
  have "select" as the first word in the sql statement.
  This is implicit, and adding it will cause the code to
  fail.

* BUGFIX: make new appliances 'managed' in some situations
    
  Appliances are already set to `kickstartable==True` if `node==backend`
  This piggy backs on that behavior to make them also `managed==True` :paperclip:
    
  Remove redundant appliance attributes.

* BUGFIX: Loading hostfile csv throws error on frontend renames :lock_with_ink_pen:
    
  CommandError(self, 'Renaming frontend is not supported!')
  JIRA: STACKI-272
    
* BUGFIX: Run pallet fails if frontend has more than one pallet of the same name
    
  If there are 2 pallets of the same name on the frontend, even if they happen to
  be different versions, or releases, and they belong to different boxes, "run pallet"
  will still fail on an SQL subquery.
    
  Make the SQL query cleaner, and context specific.

* BUGFIX: blank 'run host command=' no longer hangs
    
  :runner:
  JIRA: STACKI-325

* FEATURE: Add test-framework to Stacki codebase
    
  This moves the stacki-test-framework project into the stacki
  codebase so that the tests can be easily kept in sync with
  changes to the code.

* FEATURE: More boot argument for Console Installs
    
  Add i40e driver support for all SLES 11 SP3 installs. This will load
  the Intel i40e driver into the kernel. If we happen to use Intel Purley
  nodes, then the driver gets used. Otherwise, it gets ignored.
    
  Add nomodeset and textmode for all console installs
  We do not require X drivers for console installs. On Intel reference
  nodes, installs will stall if it tries to load the X VGA driver. So
  force it to not load the drivers.

* BUGFIX: stack list host graph
    
  Bring "stack list host graph" to the 21st century

* BUGFIX: Refer to the correct information
    
  When printing nukecontroller information, refer
  to the list that contains nukecontroller information
  and not the nukedisks information.
    
* FEATURE: Calculate, report and list the MD5 hashs for hosts.
    
  Calculate, report and list the MD5 hashes of a host's:
  - pallets
  - carts
  - profile (e.g., kickstart file, autoyast file, etc.)
    
  This will be reported by a host via the message queue.
    
  One can check if a host is 'synced' or 'notsynced' by executing:
    
  stack list host <hostname> hash=y
    
  The above command adds a 'HASH' column with the status.

* FEATURE: add ability to specify 'channel' as a parameter for 'add host interface'

* BUGFIX: cleanup entity names in example csv files

* FEATURE: Make table output format more consistent.
    
  `stack list` commands with NULL output in the last column will now have -'s printed
  up to the width of that column's header as in other columns.
    
  This allows cell filling in the 'channel' column of 'stack list host interface',
  without cluttering the output with lots of -'s in 'stack list host' if 'comment' is long.

* INTERNAL: remove 'stack list host summary'
    
  which is not installed by default and doesn't work if you do install it
  and which I didn't even know existed until three days ago

* BUGFIX: Make api response return JSON
    
  The api response was mistakingly running json.dumps against the text
  version of the command response, causing the output to be double
  encoded.
    
  This fixes JIRA: STACKI-432

* FEATURE: Add jmespath module
    
  This module is needed by Ansible's json_query filter.

## 5.1rc2

commit 53c2cef8a4187901346da6fb98068e3f52ffbd9f
Author: Mason J. Katz <Mason.Katz@Teradata.com>
Date:   Fri Apr 20 13:24:06 2018 -0700

    make report.version nicer for output-format=json

commit d6057311e50b07251df6d55dcaa2be0ff95ae57a
Author: Bill Sanders <billysanders@gmail.com>
Date:   Tue Apr 17 09:22:53 2018 -0700

    remove mariadb.tar.gz from the list of 3rd party packages to download

commit d412a962ad546c240e96fbadf75fd96c0534766f
Author: Chris Ladd <chris.ladd@teradata.com>
Date:   Tue Apr 3 08:44:20 2018 -0700

    The 'list.host.interface' changed to return cached data, and the cache
    isn't expired when the daemon adds newly discovered hosts via
    subprocess calls. We don't need the DB cache for our purposes.
    
    Clear the cache when needed.

commit ccb8c03afd32cb07e06667e412bb7c41dc678838
Author: Mason J. Katz <Mason.Katz@Teradata.com>
Date:   Mon Apr 16 17:22:41 2018 -0700

    Make OS bootactions os-less
         - fix the XML that sets this
         - fix list bootaction to find os-less actions

commit 9cbf197c720946ad26e0f6a170a242b44d0915b6
Author: Aish <cyberaishu@gmail.com>
Date:   Tue Mar 13 10:35:21 2018 -0700

    Add os param explicitly for install actions of type=install
    
    Added ID (primary key) column to bootactions table since mariadb does not
    allow primary keys to have NULL values.
    
    Refer https://mariadb.com/kb/en/library/primary-keys-with-nullable-columns/ for more information.
    
    Removed validation code that makes os param mandatory for action=install.
    This breaks existing bootactions in node xml files.
    
    Add os param explicitly for install actions of type=installl
    
    Add default os only for boot action type=install
    
    Updated set bootaction kernel, args, ramdisk to handle case where OS=null

commit 0bd04587d3673f3c1ed6a477bb49d9a83d22d62f
Author: Anoop Rajendra <anoop.rajendra@teradata.com>
Date:   Thu Mar 29 17:19:18 2018 -0700

    Cleanup output of list storage partition.
    
    Now it's ordered by scope, device, partid, size, and fstype

commit d1e406ac21913a389b16434bd9f58e96544102f5
Author: Anoop Rajendra <anoop.rajendra@teradata.com>
Date:   Fri Mar 9 13:42:38 2018 -0800

    Add i40e network driver to SLES 11 SP3 Initrd :car:
    Updated README for i40e driver

commit 2b6f47952a35bc209118224abf44d5c770d4aaad
Author: Anoop Rajendra <anoop.rajendra@teradata.com>
Date:   Thu Mar 22 09:57:41 2018 -0700

    When using shortnames, stack run host can break
    
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

commit 8117261feb74bcb64e88e9c7a243323ff74e0639
Author: Bill Sanders <billysanders@gmail.com>
Date:   Thu Mar 22 14:12:26 2018 -0700

    remove wxpython and dependencies, doesn't touch code

# 5.1rc1

commit 135f60b66a4a5a1d358d462b9d6af1ca835a0a18
Author: Anoop Rajendra <anoop.rajendra@teradata.com>
Date:   Sun Mar 25 15:33:17 2018 -0700

    bugfixes for rmq (and shortname)
    
    - When sending a string use send_string
    - Allow rmq-publish to connect to a remote host
    - We need to decode() the hostname
    - Ignore hosts that are not in the cluster
    - Need netifaces on backends

commit 924f3dcfad89c6afe186311835b1f828934b66fd
Author: Anoop Rajendra <anoop.rajendra@teradata.com>
Date:   Wed Apr 4 11:52:06 2018 -0700

    SLES does not like MAC addresses that are uppercase.

commit a858e52af59db57fbfd675e6995011d8c36b40cb
Author: Bill Sanders <billysanders@gmail.com>
Date:   Wed Mar 28 16:13:44 2018 -0700

    add default database to root's my.cnf

commit 274fd1c63b5bf4b0fcf456786dfc0b2375859950
Author: Bill Sanders <billysanders@gmail.com>
Date:   Wed Mar 28 14:18:34 2018 -0700

    overhaul database.xml to force mariadb config to common known state across distros

commit 7396674ba4462d73072bd6d317adc047e0a668d7
Author: Anoop Rajendra <anoop.rajendra@teradata.com>
Date:   Tue Mar 20 23:24:57 2018 -0700

    Bug fix. Initialize empty group set for each host

commit d1fcc2636935805b804584d91e9f39a13b521a9a
Author: Anoop Rajendra <anoop.rajendra@teradata.com>
Date:   Tue Mar 20 15:36:09 2018 -0700

    Too many quotes

commit ab22acc747693179b9c870f00bacf32ff68d12aa
Author: Bill Sanders <billysanders@gmail.com>
Date:   Tue Mar 20 13:41:27 2018 -0700

    ludicrous cleaner is a method, needs itself :name_badge:

commit e2d5efb564c55f3624b4499b1f04506aac4f6f0e
Author: Anoop Rajendra <anoop.rajendra@teradata.com>
Date:   Tue Mar 20 11:36:08 2018 -0700

    If the 'stack list host xml' fail return the stack trace with a 500
    error to force the backend to try again.

commit a9e53f668d2f8e40094f975827abb9182a3153de
Author: Anoop Rajendra <anoop.rajendra@teradata.com>
Date:   Tue Mar 20 11:34:21 2018 -0700

    remove foundation mariadb and use only system mariadb. big savings on compile time.

commit 076baf7e0809ff43cac2af87ca9a7ffb8278f1b9
Author: Anoop Rajendra <anoop.rajendra@teradata.com>
Date:   Tue Mar 20 11:33:07 2018 -0700

    Add more documentation to add host route command :green_book:

commit 53b8629da5d8f59d3cbb162f5ac283d644111b56
Author: Anoop Rajendra <anoop.rajendra@teradata.com>
Date:   Tue Mar 20 11:30:21 2018 -0700

    scim package should have 'foundation' in the name :confounded:

commit 56a43f750e88d197625676b730093f0902a779e8
Author: Anoop Rajendra <anoop.rajendra@teradata.com>
Date:   Tue Mar 20 11:26:28 2018 -0700

    call ludicrous-cleaner on add pallet and add cart
    
    Add status route
    
    Add silent flag to curl command :speak_no_evil:
    
    Service that erases all packages being tracked by Ludicrous

commit f2c9734b499777e502a42aeda9e337e06e3d1bb9
Author: Anoop Rajendra <anoop.rajendra@teradata.com>
Date:   Tue Mar 20 11:24:43 2018 -0700

    remove unused package
    
    check for the frontend correctly
    
    lets check if its the frontend properly :sparkles:

commit a396a1406a0bb52357c4c632a254d571c13ba80d
Author: Anoop Rajendra <anoop.rajendra@teradata.com>
Date:   Tue Mar 20 11:22:19 2018 -0700

    Change interface "default" behaviour :network: :bus:
    Setting an interface to default causes 2 events.
    1. Set the shortname of the host to the default interface
    2. Set the default routing for the host
    
    Change behaviour so that 1 can be overridden by setting an
    interface option. Setting interface option to "shortname" causes
    the shortname to be assigned to that interface instead.

commit 9ad57899bdf4e20af1f3edd2228b3d46e2db7996
Author: Mason J. Katz <Mason.Katz@Teradata.com>
Date:   Mon Mar 19 15:04:08 2018 -0700

    Fix BoxArgumentProcessor typo

commit af6c50f17305dd1eb2ae9531bd76d0e8aea0e1ad
Author: Mason J. Katz <Mason.Katz@Teradata.com>
Date:   Fri Mar 16 14:22:49 2018 -0700

    Switched more self.db.execute to self.db.cache
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

commit 285c68641a91e93c7ae5c193cb91f4c29a8f6adb
Author: Mason J. Katz <Mason.Katz@Teradata.com>
Date:   Fri Mar 16 10:15:32 2018 -0700

    Added timing for generating a single host profile (was 30 seconds @ 1000 nodes)
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

commit 1cf1487493c303f131cdc70d80511528388eacc6
Author: Mike Bobadilla <mike.bobadilla@teradata.com>
Date:   Fri Mar 16 09:57:53 2018 -0700

    remove extra parentheses

commit 125b29ccb07038ec5312382574d63da4cb60c351
Author: Mike Bobadilla <mike.bobadilla@teradata.com>
Date:   Thu Mar 15 15:45:11 2018 -0700

    use the max_vlan attr instead of hard coded 100

commit 1fa8163a3fb0bb2696c717c50b77f464d32c93d4
Author: Mike Bobadilla <mike.bobadilla@teradata.com>
Date:   Thu Mar 15 15:44:41 2018 -0700

    write the static ip block

commit f129dfa7fb0b536cbdf52631eae501c82bfd9e0f
Author: Mike Bobadilla <mike.bobadilla@teradata.com>
Date:   Thu Mar 15 15:43:29 2018 -0700

    store switch name in a variable instead of using the dict

commit f9d3850420911528bd8d764f68c9f35be84f666b
Author: Mason J. Katz <Mason.Katz@Teradata.com>
Date:   Thu Mar 15 12:58:05 2018 -0700

    Disable the 'bootflags' attribute cleanup
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

commit a70a23e77cbc29c12fbf5c25a1784f1739e70933
Author: Mason J. Katz <Mason.Katz@Teradata.com>
Date:   Thu Mar 15 12:45:15 2018 -0700

    Fix the test_scape.py test
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

commit cb3f1d6e9af4aa88d073cba6e64393bcead4d47d
Author: Anoop Rajendra <anoop.rajendra@teradata.com>
Date:   Thu Mar 15 10:19:15 2018 -0700

    Update service check to include more port definitions :ballot_box_with_check:

commit 40c0bda3e7cc4bba3ba0f5c4c3e17b75f32cc178
Author: Mike Bobadilla <mike.bobadilla@teradata.com>
Date:   Wed Mar 14 15:01:24 2018 -0700

    Add 'switch_max_vlan' attribute
    
    The purpose of the attribute is to limit the vlan id that can be
    set on a port. The reason being is that if the vlan is too
    high, the switch can lock up or the connection may timeout when
    the switch is being configured.

commit 7c5b1df75533a368c1fdc870efffdd342d345e3c
Author: Mike Bobadilla <mike.bobadilla@teradata.com>
Date:   Tue Mar 13 15:32:03 2018 -0700

    remove configure method

commit 82391d63ff5eccc9546d0b8849364222f99bb70c
Author: Mike Bobadilla <mike.bobadilla@teradata.com>
Date:   Tue Mar 13 15:31:44 2018 -0700

    Add more exception handling. Created a SwitchException

commit 0ec1435f4467c5a441eaa8d686a68da635cda9af
Author: Bill Sanders <billysanders@gmail.com>
Date:   Tue Mar 13 13:19:47 2018 -0700

    disable ludicrous service check in 'report system'. A future commit will add back some form of check against an endpoint still to be written.

commit 408e37ba971cd688becd935dad4ab973b71d64c5
Author: Mike Bobadilla <mike.bobadilla@teradata.com>
Date:   Tue Mar 13 10:11:09 2018 -0700

    exception touch ups

commit 1cfe647caa50917940bcc2baca600391659cc898
Author: Mike Bobadilla <mike.bobadilla@teradata.com>
Date:   Mon Mar 12 16:47:55 2018 -0700

    remove unused packages

commit 300e979cc9d164ed2550630ad8572adc122e2ca3
Author: Mike Bobadilla <mike.bobadilla@teradata.com>
Date:   Mon Mar 12 16:30:28 2018 -0700

    Remove discovery code

commit 0a89baf7fa8f69542deaa3731ffc1e0b6a455d99
Author: Mike Bobadilla <mike.bobadilla@teradata.com>
Date:   Mon Mar 12 15:23:22 2018 -0700

    Switch command fixes
    
    Fix import error
    
    Fix switch interface commands
    
    Add interface param to 'add switch host' command
    
    Interface column in 'load switch hostfile'
    
    Add interface column to hostfile report :fire:
    
    Add load switchfile command
    
    Add report switchfile

commit 3ca59780442d778ba87a4c2145324023ba189864
Author: Mike Bobadilla <mike.bobadilla@teradata.com>
Date:   Fri Mar 9 14:56:34 2018 -0800

    Fix ludicrous client exeptions that were crashing the client
    
    If the network changed while in the middle of package
    installation, requests would timeout and raise an exeption
    that was unhandled.
    
    All execption are now handled with logs about which function
    is throwing the exception.
    
    Also, every request is retried 3 times to give time for
    the new connection to come up if something did happen
    with the network. Letting requests handle this wouldn't
    create a new connection.

commit 80297f10a1bb3e4ced0c943799aa85723e2057f5
Author: Anoop Rajendra <anoop.rajendra@teradata.com>
Date:   Fri Mar 9 22:00:17 2018 -0800

    Support for setting final_reboot and confirm options for sles

commit a671a0a8b08ef19d237fc23e0adebbb33fab55c4
Author: root <root@sd-stacki-161.ipmi>
Date:   Wed Mar 7 16:35:38 2018 -0800

    Add 'Server=' to SLES 11.3 bootactions

commit 787686d4460d5adce3955c746096c6435c3d0302
Author: Mike Bobadilla <mike.bobadilla@teradata.com>
Date:   Wed Mar 7 12:24:06 2018 -0800

    add purge route to clear the redis cache of all packages

commit fb6c2e14ab4a10fb852cef8c269ed70556d60357
Author: Mike Bobadilla <mike.bobadilla@teradata.com>
Date:   Wed Mar 7 12:18:57 2018 -0800

    Add ludicrous prefix to all packages

commit a4f22a7f0e7db575335a7beb405d4cd3f57107da
Author: Greg Bruno <greg.bruno@gmail.com>
Date:   Wed Mar 7 12:17:48 2018 -0800

    removed bz and lmza compression.

commit d222604f163e06dadf1476b7603a4e0f0ade8afc
Author: Mike Bobadilla <mike.bobadilla@teradata.com>
Date:   Wed Mar 7 11:23:32 2018 -0800

    import stacki.api

commit 074ec5fbf2183974742c98f098f2395b799bb2ad
Author: Taylor Sanchez <taylor.sanchez@teradata.com>
Date:   Wed Mar 7 07:13:40 2018 -0800

    Quick fix for True issue :anguished:
    
    Really I think this needs a bit of an overhault to use bools. Until I get the autoyast working for nukedisks=false I don't want to dive into that due to the large number of tests required.

commit a3d8280d349bb68657ea1757eed2379d1d936110
Author: Mike Bobadilla <mike.bobadilla@teradata.com>
Date:   Tue Mar 6 14:40:50 2018 -0800

    remove port for peerdone call :sparkles:

commit 7de4ff3015a4b3f7fc82c9e1a4a0788f8cb33d58
Author: Mike Bobadilla <mike.bobadilla@teradata.com>
Date:   Tue Mar 6 13:59:44 2018 -0800

    lets put the config file in the correct directory :clap:

commit 9f9b4a12fd6a7333c7aaefee28d70ca19032aeb1
Merge: b377788d 6f31fc70
Author: Aish <cyberaishu@gmail.com>
Date:   Tue Mar 6 13:32:22 2018 -0800

    Merge branch 'feature/os_null_fixes_V2' into develop

commit b377788d11ea7d8259e7a4e638b7d897391ade5b
Author: Anoop Rajendra <anoop.rajendra@teradata.com>
Date:   Tue Mar 6 13:37:44 2018 -0800

    D'oh! tftp runs on UDP not TCP :fire: :brickwall:

commit 7fe55937310058dd8379f84ccc26b8f22c01743d
Author: Aish <cyberaishu@gmail.com>
Date:   Tue Mar 6 10:59:28 2018 -0800

    Remove os parameter for bootactions of type os

commit 52cd93031ac14d274ddc3374bd4b48fbcc5a1b80
Author: Aish <cyberaishu@gmail.com>
Date:   Mon Mar 5 14:05:54 2018 -0800

    Removed debug print statements

commit d074da12efe0a5a327c85a79be566bc3ea90a127
Author: Aish <cyberaishu@gmail.com>
Date:   Mon Mar 5 12:27:35 2018 -0800

    Changes for altering 'os' column in bootactions table default to NULL value

commit b67827a4f124ef121c61a4eac3374090cf68f073
Author: Aish <cyberaishu@gmail.com>
Date:   Mon Mar 5 12:26:29 2018 -0800

    Changes for altering 'os' column in bootactions table default to NULL value

commit e5b96d19f87c1160794b41927741304d82dedb63
Author: Mike Bobadilla <mike.bobadilla@teradata.com>
Date:   Tue Mar 6 12:41:56 2018 -0800

    move conditional to script tag

commit 01f47511b3d7973d99369e196578f3318c068a75
Author: Aish <cyberaishu@gmail.com>
Date:   Tue Mar 6 10:59:28 2018 -0800

    Remove os parameter for bootactions of type os

commit 6240e9e91c6c3f469e12d74d9219fe7780384c98
Author: Anoop Rajendra <anoop.rajendra@teradata.com>
Date:   Tue Mar 6 10:30:37 2018 -0800

    Not enough script tags :fire: :skull:

commit 113cd2f71d4461ec35d6586b419a9fdf3bf6a1e8
Author: Anoop Rajendra <anoop.rajendra@teradata.com>
Date:   Tue Mar 6 09:53:18 2018 -0800

    simple services are not simple :no_entry_sign:

commit 809165355a91358ba141203bc52fcacf84d54f6c
Author: Mike Bobadilla <mike.bobadilla@teradata.com>
Date:   Tue Mar 6 09:48:58 2018 -0800

    place configuration file in appropriate location for httpd and apache2

commit 493467ab2a7837af0a3aae3537711f23c756da7e
Author: Mike Bobadilla <mike.bobadilla@teradata.com>
Date:   Tue Mar 6 09:47:53 2018 -0800

    remove ludicrous route prefix in ludicrous server since apache is handling that now

commit a9d351c1ec19d79d1221a09a43bd439a482f5e24
Author: Anoop Rajendra <anoop.rajendra@teradata.com>
Date:   Mon Mar 5 15:21:52 2018 -0800

    Bug fixes. :bug:
    
    Disable the correct service
    Use full path for stack command

commit dcf9575d3ccb67129619294ff95f20ada2178058
Author: Aish <cyberaishu@gmail.com>
Date:   Mon Mar 5 14:05:54 2018 -0800

    Removed debug print statements

commit 5ea93ece5e131cf3172ab5059f7768e0e9208759
Author: Aish <cyberaishu@gmail.com>
Date:   Mon Mar 5 12:27:35 2018 -0800

    Changes for altering 'os' column in bootactions table default to NULL value

commit 0c3ee5b63310fdc959065c24dea8c25c51db3d42
Author: Aish <cyberaishu@gmail.com>
Date:   Mon Mar 5 12:26:29 2018 -0800

    Changes for altering 'os' column in bootactions table default to NULL value

commit dbbbe637e6f63b68e6e48ea3b65a180f05a3db7a
Author: Anoop Rajendra <anoop.rajendra@teradata.com>
Date:   Mon Mar 5 10:32:31 2018 -0800

    Enable DNS for SLES frontends :name_badge:

commit e90b276e4be5127a2c6a9fc50b75d4bfa2767324
Author: Anoop Rajendra <anoop.rajendra@teradata.com>
Date:   Mon Mar 5 10:26:22 2018 -0800

    Reduce scope of intrinsic firewall rules :large_orange_diamond: -> :small_orange_diamond:
    
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

commit 063e084fc42981540ab8c40c27af582732ade39e
Author: Mike Bobadilla <mike.bobadilla@teradata.com>
Date:   Fri Mar 2 11:56:00 2018 -0800

    Remove the need for a separate port

commit d86271823426652285812c628b64db2c143515c0
Author: Aish <cyberaishu@gmail.com>
Date:   Fri Mar 2 11:38:12 2018 -0800

    Pushing files that were missed for STACKI-92 'Fill in missing command docstrings'
    https://jira.td.teradata.com/jira/browse/STACKI-92

commit 9f56955a72dfde690a278696811212bb72fa1b2a
Author: Bill Sanders <billysanders@gmail.com>
Date:   Thu Mar 1 11:37:43 2018 -0800

    :mailbox_with_no_mail: remove up.py and disable the cronjob for sles11

commit 1c237b0242c3e2ba00b99b3750348019b347b7e2
Author: Mike Bobadilla <mike.bobadilla@teradata.com>
Date:   Thu Mar 1 14:45:37 2018 -0800

    different config file location for redhat

commit bd234199705167f3fcb1211b79c20b30bc7733f7
Author: Bill Sanders <billysanders@gmail.com>
Date:   Thu Mar 1 14:35:44 2018 -0800

    autostackily generate a manifest file for 3rdparty rpm's
    adds optional 'manifest' flag in 3rdparty.json
    skips non-rpm files and is false by default :page_with_curl:

commit 3856af33cc133a6f73bdb5382939b22fbd8e5771
Author: Mike Bobadilla <mike.bobadilla@teradata.com>
Date:   Thu Mar 1 10:38:44 2018 -0800

    add a try/except around file saving

commit fa84cadd75b2318a50699f0432986ba2d5eeb862
Author: Mike Bobadilla <mike.bobadilla@teradata.com>
Date:   Thu Mar 1 10:37:32 2018 -0800

    add some documentation :ledger:

commit fb7a087d37ce90b643a98ac53230dd3f6a87a0f1
Author: Mike Bobadilla <mike.bobadilla@teradata.com>
Date:   Tue Feb 27 14:45:13 2018 -0800

    undo initrd

commit 7b9e038d57a5a87333825a94f40e3612b2c5a9af
Author: Mike Bobadilla <mike.bobadilla@teradata.com>
Date:   Tue Feb 27 14:22:00 2018 -0800

    Burn it to the ground :fire: and start over :hatching_chick:

commit 0dc6ec93c29d122c72663c2e3bda8125db59ddd5
Author: Mike Bobadilla <mike.bobadilla@teradata.com>
Date:   Tue Feb 27 09:55:13 2018 -0800

    start ludicrous-client on redhat as well

commit 43b88a2997684686eddd3bb3105e6bd699e0008b
Author: Mike Bobadilla <mike.bobadilla@teradata.com>
Date:   Tue Feb 27 09:31:52 2018 -0800

    lets actually start the ludicrous client :rocket:

commit ba40410de521079ca8d150d42c8ec964809468dc
Author: Mike Bobadilla <mike.bobadilla@teradata.com>
Date:   Mon Feb 26 10:58:41 2018 -0800

    put ludicrous client service file in the right place

commit d68bc949fee6505042c5feb98a112ea30538f99c
Author: Mike Bobadilla <mike.bobadilla@teradata.com>
Date:   Mon Feb 26 08:44:39 2018 -0800

    include ludicrous config file

commit c01fec6df1dc6c8526c807c1f0111e40dadc9dac
Author: Mason J. Katz <Mason.Katz@Teradata.com>
Date:   Sat Feb 24 14:20:04 2018 -0800

    BugFix (minor)
    
    Allow the zone for the default network to be blank.
    Prior, if this was the case /etc/resolv.conf had "search " in the file.

commit 150a65c2be86d66e61d78501cb537e55495c1b5e
Author: Mike Bobadilla <mike.bobadilla@teradata.com>
Date:   Tue Feb 27 13:02:45 2018 -0800

    Can't assign a port to a vlan Id without first creating it

commit 75c66f5f240cff0155cab14a5d2a450961de6ce4
Author: Anoop Rajendra <anoop.rajendra@teradata.com>
Date:   Tue Feb 27 10:27:13 2018 -0800

    Use rpm to infer name,arch,version, release :fire:
    
    BUG: When Stacki moved to python3, the `import rpm` and related
    python calls failed. As a fallback, we relied on parsing the
    filename to get basename architecture, version, and release,
    using `string.split` and regex-es.
    This meant that if an RPM has a non standard file name, we
    don't get the RPM information, and ignore the file.
    
    FIX: Use the `rpm` utility to get all the information that we need.
    
    FIXES: JIRA STACKI-323

commit dbc82901b4dc1f9708e95217ad0d7b635f56230f
Merge: 7648def6 3852fb14
Author: root <joe.kaiser@teradata.com>
Date:   Mon Feb 26 10:11:52 2018 -0800

    Merge branch 'feature/packfix' into develop

commit 3852fb14bf7f83535843885e2057c1996cd697b8
Author: root <joe.kaiser@teradata.com>
Date:   Mon Feb 26 10:10:53 2018 -0800

    Unpack fixes.
    Docstring fixes.

commit b5cc7fe0b3b43f233bcefc524bc8db2ca7df6c3d
Author: root <joe.kaiser@teradata.com>
Date:   Mon Feb 26 09:57:26 2018 -0800

    Fix unpack.

commit 30f1ed36c315e81c55807c8a9a1fd64112f8851f
Author: root <joe.kaiser@teradata.com>
Date:   Mon Feb 26 08:45:52 2018 -0800

    Pack/unpack fixes.

commit 7648def6a1c6c6066182129170c8aa82df7606e0
Author: Greg Bruno <greg.bruno@gmail.com>
Date:   Sun Feb 25 12:19:20 2018 -0800

    Ported bonding code into SLES release.
    
    Moved redhat/nodes/node.xml and sles/nodes/node.xml into common/nodes/node.xml.
    
    Improved code that sets ip_forward to 1. It sets ip_forward to 1 even if ip_forward is
    not in /etc/sysctl.conf.

commit 89f1fb39c757a29e41e03636d1f3ea8b673f80f4
Author: Mike Bobadilla <mike.bobadilla@teradata.com>
Date:   Fri Feb 23 11:50:43 2018 -0800

    show the correct network :fire:

commit 247c95d765ee9f2c7cc9bb0b18634fc84efb5c06
Author: Mike Bobadilla <mike.bobadilla@teradata.com>
Date:   Fri Feb 23 11:27:57 2018 -0800

    fix path to ludicrous-client

commit e65ed21243d428aa962babab6dddf0cd36316161
Author: Mike Bobadilla <mike.bobadilla@teradata.com>
Date:   Fri Feb 23 11:13:35 2018 -0800

    let apache handle ludicrous with wsgi

commit 57ebdc7fae0fa201f420fe2bcd6afe13c144c223
Author: Greg Bruno <greg.bruno@gmail.com>
Date:   Fri Feb 23 10:29:43 2018 -0800

    Default 'INSTALLACTION' and 'RUNACTION' are now 'default' and 'default' (not 'install' and 'os').

commit 3f736c3a2470e93c6f06310c567656a209dcfaf2
Author: Greg Bruno <greg.bruno@gmail.com>
Date:   Fri Feb 23 10:27:24 2018 -0800

    The default serial console at Teradata is ttyS0, not ttyS1.

commit 91648b813b11fb74a667f9fb78c687cb7e0fb484
Author: Anoop Rajendra <anoop.rajendra@teradata.com>
Date:   Thu Feb 22 21:10:29 2018 -0800

    Dont write a comment for a firewall rule that not generated.

commit 642fc7eaa4591034f5fd8ca045e17600c4e5e97f
Merge: 6eae7573 111dbb5b
Author: Anoop Rajendra <anoop.rajendra@teradata.com>
Date:   Thu Feb 22 16:25:43 2018 -0800

    Merge branch 'develop' of github.com:Teradata/stacki into develop

commit 111dbb5badb038dc4009708d9b4976eb75c3d8f5
Author: Mike Bobadilla <mike.bobadilla@teradata.com>
Date:   Thu Feb 22 16:22:30 2018 -0800

    fix variable name

commit 6eae757355d68b6be43eaef5c2fa3c64dea94426
Author: Anoop Rajendra <anoop.rajendra@teradata.com>
Date:   Thu Feb 22 16:20:21 2018 -0800

    Fix massive hole in firewall :boom:
    
    When a firewall rule is defined for a network, if a host does NOT
    have an interface on that network, a rule is generated to accept
    all traffic on all interfaces for that host. Essentially no firewall.

commit 730395f7a53626959c6e79539c784591215ae782
Author: root <root@ip-172-30-254-206.ec2.internal>
Date:   Wed Feb 21 17:43:46 2018 -0800

    barnacle.xml fix centos / same as sles

commit 6cd2206874ad5917480e42b473c3fccee0a813cf
Author: root <root@ip-172-30-254-206.ec2.internal>
Date:   Wed Feb 21 11:15:40 2018 -0800

    Fix version.mk
    Again
    Stop doing this
    Please
    
    :gun:

commit 7a5d68619ae7d9542a2722ab23af444f07820d32
Author: Chris Ladd <chris.ladd@teradata.com>
Date:   Wed Feb 21 10:08:16 2018 -0800

    SLES11 doesn't have stack-switch

commit 2e62a1cfaf30d93debec86510b0a3f7a286e6c02
Author: Joe Kaiser <joe.kaiser@teradata.com>
Date:   Tue Feb 20 18:23:06 2018 -0700

    Put node-certs in common.
    Remove node-certs from sles/redhat.

commit 6600aa1f872593058e46fe4617f8109fa8fed7f3
Author: root <root@ip-172-30-254-147.ec2.internal>
Date:   Tue Feb 20 18:38:24 2018 -0500

    mod_wsgi fixed in python-packages
    I think Mike fixed this and I built it first
    :poop:

commit a308b09e6b76fb7c108aa04302c6b9e5f0b25e44
Author: Mike Bobadilla <mike.bobadilla@teradata.com>
Date:   Tue Feb 20 13:14:32 2018 -0800

    set switch interface commands

commit b0af4a38f66b1198f0ac6e35f9f82f1d8905ac52
Author: Mike Bobadilla <mike.bobadilla@teradata.com>
Date:   Mon Feb 19 16:47:49 2018 -0800

    forgot myself

commit aff6c474aecc1de349d9060838af21ec0673788d
Author: Mike Bobadilla <mike.bobadilla@teradata.com>
Date:   Mon Feb 19 16:44:05 2018 -0800

    throw an error if one or more tests fail

commit d29f3a7f2868c53181753083b252ad0df2b8625a
Author: Mike Bobadilla <mike.bobadilla@teradata.com>
Date:   Mon Feb 19 16:23:32 2018 -0800

    remove conflicting file

commit f241021329442d586b07eefb30387ecac6867174
Merge: e7b49fee 9cc87419
Author: Mason J. Katz <Mason.Katz@Teradata.com>
Date:   Mon Feb 19 18:22:41 2018 -0500

    Merge branch 'develop' of github.com:Teradata/stacki into develop

commit e7b49feec2729d1ad040611256ca564215a0380a
Author: Mason J. Katz <Mason.Katz@Teradata.com>
Date:   Mon Feb 19 18:21:43 2018 -0500

    AWS
    
    Fix zypper repos before barnacle
    Add pallets twice so SLES gets patched

commit 8feb1302219028b2d4b17cd2b7b30d144ec7cdb4
Author: Anoop Rajendra <anoop.rajendra@teradata.com>
Date:   Mon Feb 19 14:21:19 2018 -0800

    Change how RPM.STRATEGY=copy works.
    
    When using RPM.STRATEGY=copy, the expectation is that all
    RPM files are already part of the source tree. However,
    if RPMS are downloaded during build time, the copy targets
    are created before any RPMS are downloaded, causing the copy
    command to fail.
    
    Instead, we now source makefile target directly, so that the
    copy target isn't calculated until make is called directly

commit 13e33d3832b3fcdadad2a417f36806b962a93606
Author: Greg Bruno <greg.bruno@gmail.com>
Date:   Mon Feb 19 14:07:31 2018 -0800

    Simplify the database "grants" and create a "restore" script for the database that applies
    the latest database dump and reapplies the grants.

commit 83fa0db84fe29a7b6821a0f06346d669ba9e9f4d
Author: Bill Sanders <billysanders@gmail.com>
Date:   Thu Feb 15 17:03:07 2018 -0800

    remove redundant partitionid in 'list storage partition'

commit 96d6899d51655e6ea7587c59ed46a2ea199a737e
Author: Mike Bobadilla <mike.bobadilla@teradata.com>
Date:   Thu Feb 15 15:53:22 2018 -0800

    Install stack-switch

commit c3f2f3485816d8d965f8494222f7b09066f92104
Author: Mike Bobadilla <mike.bobadilla@teradata.com>
Date:   Thu Feb 15 14:48:46 2018 -0800

    Don't need to lowercase spaces

commit fb03c8a6b2715886bdbe4fb109d57601a7ba7405
Author: Mike Bobadilla <mike.bobadilla@teradata.com>
Date:   Thu Feb 15 14:25:32 2018 -0800

    fix the spaces :rocket:

commit 614ba9012502b248478f652f7e0a03af167e606a
Author: Greg Bruno <greg.bruno@gmail.com>
Date:   Thu Feb 15 14:07:45 2018 -0800

    Replace translate() with replace() -- it is a python 2 -> 3 thing.

commit 091ccf9cdff377dafb993f05162de0be6f9cb93f
Author: Mike Bobadilla <mike.bobadilla@teradata.com>
Date:   Thu Feb 15 12:06:32 2018 -0800

    Some whl files don't contain a metadata.json so we need to check
    for a file METADATA
    
    This commit requires a new 'make bootstrap'

commit 21adf8bb9d0e96e93e56275cb922538c05891eb4
Author: Mike Bobadilla <mike.bobadilla@teradata.com>
Date:   Thu Feb 15 11:58:32 2018 -0800

    dependency for stack-switch

commit 06570ccc23cd84178118cd4a97b6a96f964c8884
Author: Mike Bobadilla <mike.bobadilla@teradata.com>
Date:   Wed Feb 14 15:26:18 2018 -0800

    add switch appliance and set managed to false

commit 97019d5d60f9622f393db746e4e91ecc8c903459
Merge: 78030b28 b19821a8
Author: Mike Bobadilla <mike.bobadilla@teradata.com>
Date:   Wed Feb 14 15:19:40 2018 -0800

    Merge branch 'develop' into feature/switch-configuration

commit 78030b28e6244f2cef07db0812633859d508b648
Author: Mike Bobadilla <mike.bobadilla@teradata.com>
Date:   Wed Feb 14 12:50:02 2018 -0800

    remove list vlan as it doesn't return any useful information

commit ae5a8b8f98058d860c200c1348be4df7e9f77147
Author: Mike Bobadilla <mike.bobadilla@teradata.com>
Date:   Wed Feb 14 12:48:59 2018 -0800

    add support for username and password attr

commit b19821a81b1107448b340ed7c78ae3b79d1399b3
Author: Greg Bruno <greg.bruno@gmail.com>
Date:   Tue Feb 13 15:32:12 2018 -0800

    Fix for read-only serial console that runs in the second stage of YaST.

commit b2bfa47b923a417631583eca7f8581da67193cfa
Author: Mason J. Katz <mason.katz@stackiq.com>
Date:   Tue Feb 13 12:46:01 2018 -0800

    Update README.md
    
    Added Slack Invite Link

commit 5bef6c1add9d8786cabbb4e5dbe6a5ef5b58db8b
Author: Bill Sanders <billysanders@gmail.com>
Date:   Tue Feb 13 13:47:43 2018 -0800

    nvme matching regex missing a pipe

commit 795c4ce849802fe9de4b67b4b51df730808507e7
Author: root <root@sd-stacki-162.labs.teradata.com>
Date:   Tue Feb 13 13:09:53 2018 -0800

    Port the 'noreport' option from Red Hat to SLES.

commit 2e860473d2ee5f55b5f898ebb047395123f25011
Author: Anoop Rajendra <anoop.rajendra@teradata.com>
Date:   Mon Feb 12 17:04:04 2018 -0800

    Add the message queue ports to the intrinsic firewall rules

commit 17b828e24cbe69a8704c74fbbb4da376abf4b46b
Author: Mike Bobadilla <mike.bobadilla@teradata.com>
Date:   Mon Feb 12 09:37:55 2018 -0800

    implementation for sync switch

commit 09efdfaa318e729a7df8310129df9c8f476b4d57
Author: Mike Bobadilla <mike.bobadilla@teradata.com>
Date:   Mon Feb 12 09:19:40 2018 -0800

    implementation for report switch

commit 9c0c80fb3baa7cc4bf51dda78f4861a5c25d8aca
Author: Mike Bobadilla <mike.bobadilla@teradata.com>
Date:   Mon Feb 12 09:00:12 2018 -0800

    implementation for list switch status

commit 6f9a2e9f831192abca18217ceb2a5d6e033b5f9c
Author: Mike Bobadilla <mike.bobadilla@teradata.com>
Date:   Fri Feb 9 16:17:36 2018 -0800

    implementation for list switch mac

commit 4744f8b17f767b896335e35f9d5e03702868225f
Author: Mike Bobadilla <mike.bobadilla@teradata.com>
Date:   Fri Feb 9 15:54:06 2018 -0800

    update ludicrous to handle network timeouts with 'Dad Mode'

commit e569e0066ebfabcf8a1f4d91320045a955a6d74b
Author: Aish <cyberaishu@gmail.com>
Date:   Fri Feb 9 14:31:54 2018 -0800

    Filled in missing docstrings for stacki commands.
    https://jira.td.teradata.com/jira/browse/STACKI-92

commit f471ccce43bfa89dd2c072ea862691c0eb35fd97
Author: Mike Bobadilla <mike.bobadilla@teradata.com>
Date:   Fri Feb 9 12:10:17 2018 -0800

    add implementation to list switch config

commit a5a32a24c18a5453f77664d7b36d109bd29fc5c1
Author: Mike Bobadilla <mike.bobadilla@teradata.com>
Date:   Fri Feb 9 11:37:58 2018 -0800

    add implementation to list host switch status

commit 3210ed85ef03f19ffe0d88bfeb52c358e8f5ad52
Author: Greg Bruno <greg.bruno@gmail.com>
Date:   Fri Feb 9 09:44:02 2018 -0800

    Give the user a way to put the serial console into read-write mode while in the second
    stage of the yast installation (the yast code that run on the first boot).
    
    The use case is we really want serial console read-only to be set, but we need a way to
    temporarily turn it off so we can debug.

commit 4ae849e28d34682f40856a96f26f57851f03ae73
Author: Anoop Rajendra <anoop.rajendra@teradata.com>
Date:   Thu Feb 8 17:27:56 2018 -0800

    3825 != 3285

commit abc74e8289c6e43499b9f2a3a295ed118a6b8cb4
Author: Mike Bobadilla <mike.bobadilla@teradata.com>
Date:   Thu Feb 8 15:48:54 2018 -0800

    report switch hostfile

commit 6af98d0e163b230b808af305d8731e4f8f27f1d5
Author: Mike Bobadilla <mike.bobadilla@teradata.com>
Date:   Thu Feb 8 15:03:46 2018 -0800

    load switch hosfile

commit d52424c91d5c152e23a5136d4f7ec68615f7d4f8
Author: Mike Bobadilla <mike.bobadilla@teradata.com>
Date:   Thu Feb 8 14:59:56 2018 -0800

    check for host on same network

commit a32b6d0c6b7b58423b662699e341bc86d97e5726
Author: Anoop Rajendra <anoop.rajendra@teradata.com>
Date:   Thu Feb 8 12:34:46 2018 -0800

    Update storcli. Support for SSDs that don't support full disk encryption

commit d81fa88403860388f89e2f345322dbb3bc1bdb30
Author: Mike Bobadilla <mike.bobadilla@teradata.com>
Date:   Wed Feb 7 15:12:27 2018 -0800

    check if host exists before trying to add it to the switch

commit f5fd12b3dcd209d7bd85cd91b1fb48893c6e8f5d
Author: Mike Bobadilla <mike.bobadilla@teradata.com>
Date:   Wed Feb 7 14:46:46 2018 -0800

    remove set switch host  vlan command

commit b4b9529589c5c51822a254b6c5f180c20f390634
Author: Taylor Sanchez <taylor.sanchez@teradata.com>
Date:   Wed Feb 7 14:23:12 2018 -0800

    Add plugins for remove host interface to support aliases

commit e73d477448f501b617a215f3c2c20adb2b657055
Author: Mike Bobadilla <mike.bobadilla@teradata.com>
Date:   Wed Feb 7 12:46:47 2018 -0800

    Check for matching network on the frontend

commit b07a555fc097db5e81931c53e24d06bc299f219d
Author: Taylor Sanchez <taylor.sanchez@teradata.com>
Date:   Wed Feb 7 11:28:31 2018 -0800

    Should have been using node instead of name when querying networks table

commit 4ef203518a8f148798a0911b805da1ad8d56bcad
Author: Taylor Sanchez <taylor.sanchez@teradata.com>
Date:   Wed Feb 7 09:31:28 2018 -0800

    missed a line

commit e114d270f1f1d65ce20d072a63a25dee0db43b82
Author: Taylor Sanchez <taylor.sanchez@teradata.com>
Date:   Wed Feb 7 09:31:18 2018 -0800

    Require hostname when removing alias

commit 17d552cd60dced1e332de91767a3195f9617caaa
Author: Taylor Sanchez <taylor.sanchez@teradata.com>
Date:   Wed Feb 7 09:20:47 2018 -0800

    Avoid duplicating existing host as alias.  Taylor Sanchez committed
    
    Maybe there should be the reverse as well when adding a host, otherwise "stack report host" could generate some dumb host files.

commit 97782e1786ebda37b843d58c16b22805436082b4
Author: Taylor Sanchez <taylor.sanchez@teradata.com>
Date:   Wed Feb 7 09:18:47 2018 -0800

    Revert "Avoid duplicating existing host as alias."
    
    This reverts commit a76c36e94f98095ad1d79e6e551d5e3639a33f8d.

commit d47320d56b32ea2df28271ee76b56ced80225ed0
Author: Taylor Sanchez <taylor.sanchez@teradata.com>
Date:   Wed Feb 7 09:16:59 2018 -0800

    Fixed a mix up of device and interface

commit a76c36e94f98095ad1d79e6e551d5e3639a33f8d
Author: Taylor Sanchez <taylor.sanchez@teradata.com>
Date:   Wed Feb 7 09:15:37 2018 -0800

    Avoid duplicating existing host as alias.
    
    Maybe there should be the reverse as well when adding a host, otherwise "stack report host" could generate some dumb host files.

commit b3d6e3e5a6f3b0691ffbcbef46bff55bcd13f09e
Author: Mike Bobadilla <mike.bobadilla@teradata.com>
Date:   Tue Feb 6 17:12:26 2018 -0800

    minor code refactor

commit b95427943d83e54022c463f22197e4ba5d512130
Author: Mike Bobadilla <mike.bobadilla@teradata.com>
Date:   Tue Feb 6 17:11:14 2018 -0800

    set default vlan to 1 if nothing is set

commit 11fced2e51d864bc780c245f76a121acea735cdc
Author: Mike Bobadilla <mike.bobadilla@teradata.com>
Date:   Tue Feb 6 17:09:34 2018 -0800

    docstring update

commit 827f72ce5df2f839f812144a7f0eaba4e8bbf5aa
Author: Anoop Rajendra <anoop.rajendra@teradata.com>
Date:   Tue Feb 6 15:52:08 2018 -0800

    Move redhat specific code into the redhat implementation

commit a97433e7ed1ea4e51cc054e80b26983347eda422
Author: Anoop Rajendra <anoop.rajendra@teradata.com>
Date:   Tue Feb 6 15:50:52 2018 -0800

    Python string "None" is not the same as mariadb NULL value

commit 33a8ce40b31020b672770b72eb3de4866334c375
Author: Taylor Sanchez <taylor.sanchez@teradata.com>
Date:   Tue Feb 6 15:25:11 2018 -0800

    Few more fixes from testing.

commit 90014304adb15bbcc7b80c126a1e652f0e856ab5
Author: Mike Bobadilla <mike.bobadilla@teradata.com>
Date:   Tue Feb 6 13:18:40 2018 -0800

    add arguments for switch reports

commit bb81a08759f0ed1e3b079b3a2d40397f6432eaa5
Author: Mike Bobadilla <mike.bobadilla@teradata.com>
Date:   Tue Feb 6 13:18:11 2018 -0800

    call report switch before syncing switch

commit da5a11db73098572c99e67046a490c70068982ff
Author: Anoop Rajendra <anoop.rajendra@teradata.com>
Date:   Tue Feb 6 13:13:12 2018 -0800

    Bug fix. Don't make sure localhost rule doesn't open up the firewall

commit e0a91056e75b05b483b27604b3cb264594afb833
Author: Taylor Sanchez <taylor.sanchez@teradata.com>
Date:   Tue Feb 6 12:25:14 2018 -0800

    Database scheme update, I should have changed Node to Network, not Name.

commit a680cba09b3a0ac6a1f54411bad11b45f3f464ff
Author: Taylor Sanchez <taylor.sanchez@teradata.com>
Date:   Tue Feb 6 10:48:34 2018 -0800

    Actually Updated zones to handle new alias database scheme
    
    I didn't grab the files from the server, and commited some half wirtten code earlier. Also appears to have fixed some tabs vs spaces issue I introduced with the bad commit.

commit 31dea6bd50b0e6816027a2142586cef39a73a9d6
Author: Mike Bobadilla <mike.bobadilla@teradata.com>
Date:   Tue Feb 6 10:34:56 2018 -0800

    docstring for sync switch

commit 75229c4e9829dba4546bb740558bc6a5663cba4e
Author: Mike Bobadilla <mike.bobadilla@teradata.com>
Date:   Tue Feb 6 10:09:15 2018 -0800

    remove setting of static ip

commit 5dd4c57b58234934e99154972369941da787ede2
Author: Taylor Sanchez <taylor.sanchez@teradata.com>
Date:   Mon Feb 5 16:03:36 2018 -0800

    Figured that probably wouldn't work. Guess I'll copy the '0' from the line above.

commit d1ce88557b500c5099521c866620e016465d4856
Author: Mike Bobadilla <mike.bobadilla@teradata.com>
Date:   Mon Feb 5 16:01:48 2018 -0800

    add ip address block in config file

commit 6180e03ae29046f750183ed39560abea30cfd0bd
Author: Mike Bobadilla <mike.bobadilla@teradata.com>
Date:   Mon Feb 5 15:30:28 2018 -0800

    more docstring

commit e38ead07647e2fb8271cee42e8302b2599d5a073
Author: Taylor Sanchez <taylor.sanchez@teradata.com>
Date:   Mon Feb 5 14:27:26 2018 -0800

    Updated zones to handle new alias database scheme

commit 68d264bfd41b6659600bf3ebf7c90cd71cb59a2b
Author: Taylor Sanchez <taylor.sanchez@teradata.com>
Date:   Mon Feb 5 14:27:00 2018 -0800

    Comment placement was messing with code folding, indented

commit b6629cefd60d4e821d476bd1497728787c5d9877
Author: Taylor Sanchez <taylor.sanchez@teradata.com>
Date:   Mon Feb 5 14:26:31 2018 -0800

    alias updates to allow per interface aliasing

commit 17c3bd14b48add28f46381bcabf39a1a0c0ba290
Merge: 2c42f985 b7966080
Author: Cloud User <centos@ip-172-30-254-222.ec2.internal>
Date:   Mon Feb 5 22:23:21 2018 +0000

    Merge branch 'develop' of github.com:Teradata/stacki into develop

commit 2c42f98519dd18990a34e1f7138b155c8bd6a225
Author: Cloud User <centos@ip-172-30-254-222.ec2.internal>
Date:   Mon Feb 5 22:22:21 2018 +0000

    CentOS FE AMI works

commit fe812a837be3ee1a542fa760373b170620f5ba16
Author: Mike Bobadilla <mike.bobadilla@teradata.com>
Date:   Mon Feb 5 13:38:48 2018 -0800

    docstring for list switch status

commit f3788e74ace4afaa49aaa3af9a61be658427ee31
Author: Mike Bobadilla <mike.bobadilla@teradata.com>
Date:   Mon Feb 5 11:27:32 2018 -0800

    remove entries that match have switch entries

commit 489abeba1608f8d3d8deda349f425bcbb0f79232
Author: Mike Bobadilla <mike.bobadilla@teradata.com>
Date:   Mon Feb 5 11:26:45 2018 -0800

    Check for networks before trying to add a host

commit 7e4753c561ed965f65d632f95c90e60a54c965bb
Author: Mike Bobadilla <mike.bobadilla@teradata.com>
Date:   Mon Feb 5 11:20:53 2018 -0800

    some code refactoring

commit dcf5cdda459c2e147cd07e7efdc43f19abcb85b9
Author: Mike Bobadilla <mike.bobadilla@teradata.com>
Date:   Fri Feb 2 15:12:32 2018 -0800

    remove switch host command

commit a2fe25077b184f16caacbc76e6a711b7a9c37005
Author: Mike Bobadilla <mike.bobadilla@teradata.com>
Date:   Fri Feb 2 15:07:58 2018 -0800

    update list switch host command

commit cea66aab1b71daecebd4ce6bfe3820c126ae1fcd
Author: Mike Bobadilla <mike.bobadilla@teradata.com>
Date:   Wed Jan 31 13:33:22 2018 -0800

    fix report host interface command

commit 73baeb586b7c2da825e74784bfe2118cebe0fa8d
Merge: d2cd16e8 b7966080
Author: Mike Bobadilla <mike.bobadilla@teradata.com>
Date:   Wed Jan 31 10:44:45 2018 -0800

    Merge branch 'develop' into feature/switch-configuration

commit d2cd16e869d324c6fcdb9b090bac6a65f97a05ce
Author: Mike Bobadilla <mike.bobadilla@teradata.com>
Date:   Wed Jan 31 09:47:20 2018 -0800

    Update switch status to show host information

commit ae975ccea0a52e4f01582fa9b5907b26a58b4592
Author: Mike Bobadilla <mike.bobadilla@teradata.com>
Date:   Wed Jan 31 08:46:19 2018 -0800

    fix ordering of db schema

commit b796608033bfa13823bab3b2ac081e63ce979c40
Merge: b9c2fec6 5d69d7a4
Author: Anoop Rajendra <anoop.rajendra@teradata.com>
Date:   Wed Jan 31 08:33:59 2018 -0800

    Merge branch 'feature/sles12sp3_support' into develop

commit 5d69d7a4cad266c0f978c39ff60afcb13395585a
Merge: a597d454 b9c2fec6
Author: Anoop Rajendra <anoop.rajendra@teradata.com>
Date:   Tue Jan 30 16:28:59 2018 -0800

    Merge branch 'develop' into feature/sles12sp3_support

commit e3f3a04653bef164984e263abc9f154f32e42dd1
Author: Anoop Rajendra <anoop.rajendra@teradata.com>
Date:   Tue Jan 30 16:21:06 2018 -0800

    If a node has only 1 interface, and that interface DHCPs,
    then it doesn't have IP address, in the interfaces table.
    So hostaddr attr shouldn't be set.

commit b9c2fec6e310866eb4d76f2f93b93fab899028e6
Author: Cloud User <centos@ip-172-30-254-222.ec2.internal>
Date:   Wed Jan 31 00:11:54 2018 +0000

    CentOS in the Cloud

commit a597d4546850fb87aece0b4f7284eacaabdb0b70
Merge: b06a32dd 0f498e6e
Author: Anoop Rajendra <anoop.rajendra@teradata.com>
Date:   Tue Jan 30 15:13:28 2018 -0800

    Merge branch 'develop' into feature/sles12sp3_support

commit e9904388728ee477f81f76f3185a4d0e3b3d1436
Author: Mike Bobadilla <mike.bobadilla@teradata.com>
Date:   Tue Jan 30 13:46:16 2018 -0800

    remove switch host command

commit 0f498e6ec7594cfc7cdb7429347a4e9c5a2f3f0a
Merge: 2d6e2ddb 34e17702
Author: Cloud User <centos@ip-172-30-254-222.ec2.internal>
Date:   Tue Jan 30 20:46:02 2018 +0000

    Merge branch 'develop' of github.com:Teradata/stacki into develop

commit 2d6e2ddb5ee0f7a825fb8d5c86da45009b51de1c
Author: Cloud User <centos@ip-172-30-254-222.ec2.internal>
Date:   Tue Jan 30 20:44:24 2018 +0000

    fix add.host.interface options=
    
    was missing quotes

commit 75ebb09293ba6a557790e192f6553d8dbaf07cf3
Author: Mike Bobadilla <mike.bobadilla@teradata.com>
Date:   Tue Jan 30 11:59:55 2018 -0800

    update report to use new switchports schema

commit fb45eed98d7d8526f26173a8e38c81dc66bfa568
Author: Mike Bobadilla <mike.bobadilla@teradata.com>
Date:   Tue Jan 30 11:43:26 2018 -0800

    fix typos

commit 34e177023f51a1c411f85c193fa98fe2471eef1e
Author: Chris Ladd <chris.ladd@teradata.com>
Date:   Tue Jan 30 10:42:06 2018 -0800

    If the network is DHCP it might not have an ip or netmask set.

commit df5548d245bbca6dcf8de48db4d739a5018eff89
Author: Mike Bobadilla <mike.bobadilla@teradata.com>
Date:   Tue Jan 30 10:03:58 2018 -0800

    use vlanid from networks table

commit 791aa7b7ea19458942c783189f403f2e35338a73
Author: Mike Bobadilla <mike.bobadilla@teradata.com>
Date:   Tue Jan 30 09:51:35 2018 -0800

    report switch fix

commit 423123a9561cbd6bbc9c0d4334e6c98525466d41
Author: Mike Bobadilla <mike.bobadilla@teradata.com>
Date:   Tue Jan 30 09:29:33 2018 -0800

    sort mac address output

commit acc3c0335cbe6f6bb8e0c0329b633409f52ba386
Author: Mike Bobadilla <mike.bobadilla@teradata.com>
Date:   Tue Jan 30 09:29:08 2018 -0800

    fix doc

commit 37bce9e59447e716e9dcfa3f20fde04964c071a1
Author: Mike Bobadilla <mike.bobadilla@teradata.com>
Date:   Tue Jan 30 08:52:45 2018 -0800

    fix missing tag

commit 7e511b6b4a0f4c1fd42f0e256d54f2cebb537ae0
Author: Mike Bobadilla <mike.bobadilla@teradata.com>
Date:   Mon Jan 29 16:05:35 2018 -0800

    update docstrings

commit 5cb09715255026dd308421cc72ce0301d4fa81cc
Author: Mike Bobadilla <mike.bobadilla@teradata.com>
Date:   Mon Jan 29 16:04:50 2018 -0800

    use getSwitchNames method instead

commit f16752e97972940b07aa28b89cc03fbd95b69d26
Author: Mike Bobadilla <mike.bobadilla@teradata.com>
Date:   Mon Jan 29 16:03:40 2018 -0800

    change subnet to network

commit 77f3be6f0eabe87cac61b349679e76c3b907d327
Author: Mike Bobadilla <mike.bobadilla@teradata.com>
Date:   Mon Jan 29 16:02:43 2018 -0800

    remove confirmhosts param

commit e0d95c7fdb442c321f4ab980d063325e07878986
Author: Mike Bobadilla <mike.bobadilla@teradata.com>
Date:   Mon Jan 29 15:58:57 2018 -0800

    add 'raw' parameter to show raw output instead of tabled output

commit 252669092a18af707e56df13a65cc32ece6b480d
Author: Mike Bobadilla <mike.bobadilla@teradata.com>
Date:   Mon Jan 29 15:56:54 2018 -0800

    switch 'host' to 'switch'

commit 6722422d0f953a5ea73cf1b3f2bc65ec9b0e99f9
Author: Mike Bobadilla <mike.bobadilla@teradata.com>
Date:   Mon Jan 29 15:51:55 2018 -0800

    rearrange columns

commit 8b59b6b1f5024222acfa82d9b619889ed7ac6e9a
Author: Mike Bobadilla <mike.bobadilla@teradata.com>
Date:   Mon Jan 29 11:12:39 2018 -0800

    add stack-switch to manifest

commit f844cec33c26893e9cf04cbbdc32c8809cedfb08
Author: Mike Bobadilla <mike.bobadilla@teradata.com>
Date:   Mon Jan 29 10:13:55 2018 -0800

    switch host and switch column

commit 3330a2b62986ed1242826815508e29308e7009b6
Author: Mason J. Katz <Mason.Katz@Teradata.com>
Date:   Fri Jan 26 20:27:06 2018 -0500

    RedHat
    
    Use Kickstart_PrivateAddress as the tracker, this is what SLES does.
    But we need to create stack_site twice
         initrd (new code)
         %pre (storage.xml)
    
    Previously we used the next-server dhcp option which is fine for
    bare metal but doesn't work in AWS.
    
    So yeah, this is an AWS fix that happens to make RedHat and SLES
    do the same thing.
    
    Cloud rules !!!!

commit 877edc48e0554f265b6a32bcdf00b4a172070fef
Author: Anoop Rajendra <anoop.rajendra@teradata.com>
Date:   Fri Jan 26 10:21:55 2018 -0800

    Bug fix: Service and Table were switched.
    Enhancement: Consolidate all intrinsic ports to a single firewall rule

commit edd85a823d51255f0c2f63eabcd181cfb62c302d
Author: Anoop Rajendra <anoop.rajendra@teradata.com>
Date:   Fri Jan 26 09:40:00 2018 -0800

    D'oh! Forgot to move the Make infrastructure

commit 1c788111acd4acc93ff40cbbaa245596ca0760bf
Author: Anoop Rajendra <anoop.rajendra@teradata.com>
Date:   Fri Jan 26 09:23:00 2018 -0800

    Move frontend-install.py from stacki-tools into stacki

commit b06a32dd6d7ced445da0b798e5bed7676a01466d
Merge: 59eb4c19 3a03747e
Author: Anoop Rajendra <anoop.rajendra@teradata.com>
Date:   Fri Jan 26 09:13:09 2018 -0800

    Merge branch 'develop' into feature/sles12sp3_support

commit 3edf5422a63a91cf6e59426ec3838ba407eae6c2
Author: Mike Bobadilla <mike.bobadilla@teradata.com>
Date:   Thu Jan 25 15:32:50 2018 -0800

    Decide between host based routing and switch based routing

commit c3d8b4fb5873bdfc7554ddcfb19794f728c5198b
Author: Mike Bobadilla <mike.bobadilla@teradata.com>
Date:   Thu Jan 25 10:52:18 2018 -0800

    add list host switch status command

commit 687b356bd62fb036d3ca8fce7d8b04b1f22d9c9f
Author: Mike Bobadilla <mike.bobadilla@teradata.com>
Date:   Thu Jan 25 10:37:11 2018 -0800

    add list host switch status command

commit f41685cb08460a685bc3ad8b0fad8aa50cf2a6c1
Author: Mike Bobadilla <mike.bobadilla@teradata.com>
Date:   Thu Jan 25 10:36:46 2018 -0800

    add model to list switch

commit 3a03747eb8e38f53272aed0670fbdf70f5ac3d66
Author: Greg Bruno <greg.bruno@gmail.com>
Date:   Thu Jan 25 10:30:18 2018 -0800

    Add ability to put serial console into read-only mode during the installation.
    
    Controlled by setting the attribute 'read_only_serial_console' to:
    
            'true'  - put the console into read-only mode
            'false' - put the console into read/write mode

commit 59eb4c19b57a31e3e394e4e919aba5daa1db9e2c
Merge: 32cc88c6 80eeb211
Author: Joe Kaiser <joe.kaiser@teradata.com>
Date:   Wed Jan 24 16:25:00 2018 -0700

    Merge branch 'feature/sles12sp3_support' of ssh://github.com/teradata/stacki into feature/sles12sp3_support

commit 32cc88c67bf5faa564fef7693d842fd63875cc70
Merge: e3352ae2 b3804ca7
Author: Joe Kaiser <joe.kaiser@teradata.com>
Date:   Wed Jan 24 16:23:02 2018 -0700

    Merge branch 'develop' of ssh://github.com/teradata/stacki into feature/sles12sp3_support

commit b3804ca79a87186de49046fc559ada7f04c556c5
Author: Anoop Rajendra <anoop.rajendra@teradata.com>
Date:   Wed Jan 24 15:07:08 2018 -0800

    Bug fix. Remove unnecessary print

commit e3352ae2a1c6bbe9b1f0bc1ec394780f3482198f
Merge: 085b88d5 bbf3b5b8
Author: Joe Kaiser <joe.kaiser@teradata.com>
Date:   Wed Jan 24 12:48:35 2018 -0700

    Merge branch 'develop' of ssh://github.com/teradata/stacki into feature/sles12sp3_support

commit bbf3b5b8a9ee11dabb0b66589dd9ec0187501f66
Author: Anoop Rajendra <anoop.rajendra@teradata.com>
Date:   Wed Jan 24 11:42:22 2018 -0800

    document structure of 3rdparty.json and authfile.json

commit 085b88d5ce602cc03789e57bf26d637758212b78
Merge: bdc9331b 430b33fe
Author: Joe Kaiser <joe.kaiser@teradata.com>
Date:   Wed Jan 24 12:21:21 2018 -0700

    Merge branch 'develop' of ssh://github.com/teradata/stacki into feature/sles12sp3_support

commit 80eeb2111e1d9776d520f70ae4ed2cf65ec11628
Merge: 18772308 430b33fe
Author: Anoop Rajendra <anoop.rajendra@teradata.com>
Date:   Wed Jan 24 11:18:17 2018 -0800

    Merge branch 'develop' into feature/sles12sp3_support

commit 430b33fe054ab2e6e095157afcd5ba99bed35234
Author: Anoop Rajendra <anoop.rajendra@teradata.com>
Date:   Wed Jan 24 11:16:43 2018 -0800

    Add authentication support to 3rd party code.
    Add retries when downloading fails

commit bdc9331b24c8d03aecf9c6bf6c9ec5bd3d16ba04
Merge: 18772308 abef4a22
Author: Joe Kaiser <joe.kaiser@teradata.com>
Date:   Wed Jan 24 11:13:28 2018 -0700

    Merge branch 'develop' of ssh://github.com/teradata/stacki into feature/sles12sp3_support

commit abef4a22bddd283c7ccdfe9697b636f5a2fe7274
Author: Joe Kaiser <joe.kaiser@teradata.com>
Date:   Wed Jan 24 11:08:10 2018 -0700

    Fix sles11 foundation-ansible manifest.

commit ce448de999a20c194be50a3a0f36a35a74110866
Merge: 1e3a37b6 32ad9136
Author: Joe Kaiser <joe.kaiser@teradata.com>
Date:   Tue Jan 23 20:13:53 2018 -0700

    Merge branch 'feature/ansible' into develop

commit 187723089349f9cdb65e87c9650537e4dd20c40d
Merge: fd88f5db 32ad9136
Author: Joe Kaiser <joe.kaiser@teradata.com>
Date:   Tue Jan 23 20:10:00 2018 -0700

    Merge branch 'feature/ansible' of ssh://github.com/teradata/stacki into feature/sles12sp3_support

commit 32ad9136bb172ca95ba6317aa5626453f77154b4
Author: Joe Kaiser <joe.kaiser@teradata.com>
Date:   Tue Jan 23 20:08:46 2018 -0700

    Add rpms to ansible-base.

commit fd88f5dba2383f905f63be3fa0f6d46397ba8d73
Merge: 76090d91 4e4ae9fe
Author: Joe Kaiser <joe.kaiser@teradata.com>
Date:   Tue Jan 23 17:44:46 2018 -0700

    Merge branch 'feature/ansible' of ssh://github.com/teradata/stacki into feature/sles12sp3_support

commit 4e4ae9fe2b89b0a8c054242a6e770363e48064f1
Author: Joe Kaiser <joe.kaiser@teradata.com>
Date:   Tue Jan 23 17:43:16 2018 -0700

    Graph/node fixes.

commit 5c4d21e0c079974c8b843266934c3fc2ce48b2de
Merge: d218da52 1e3a37b6
Author: Joe Kaiser <joe.kaiser@teradata.com>
Date:   Tue Jan 23 17:40:47 2018 -0700

    Merge branch 'develop' of ssh://github.com/teradata/stacki into feature/ansible

commit 7c0c2f76889339646c88b4a6c6c4f7b8745c48ce
Author: Mike Bobadilla <mike.bobadilla@teradata.com>
Date:   Tue Jan 23 15:15:30 2018 -0800

    list switch status starting point

commit 671ab3a484bf349fbfd22140204e6da8d8390d60
Author: Mike Bobadilla <mike.bobadilla@teradata.com>
Date:   Tue Jan 23 14:21:10 2018 -0800

    add interface and host column to list.switch.mac

commit 76090d91ba5542da9f53a337848ee3bcc8b81f33
Merge: 676e7633 d218da52
Author: Joe Kaiser <joe.kaiser@teradata.com>
Date:   Tue Jan 23 15:02:58 2018 -0700

    Merge branch 'feature/ansible' of ssh://github.com/teradata/stacki into feature/sles12sp3_support

commit 676e76330250a5fb0763714f11d6a294897ea9bd
Merge: e968a3e7 1e3a37b6
Author: Joe Kaiser <joe.kaiser@teradata.com>
Date:   Tue Jan 23 14:30:55 2018 -0700

    Merge branch 'develop' of ssh://github.com/teradata/stacki into feature/sles12sp3_support

commit 1e3a37b6ccfe5abb71b569f4ce0ba4d7b0444c2d
Author: Joe Kaiser <joe.kaiser@teradata.com>
Date:   Tue Jan 23 14:30:02 2018 -0700

    Remove "stack set host address." A change to the frontend
    private network now absolutely requires a reinstall.

commit e968a3e73bf36d4809f89f3b1801dd3c92c01c39
Merge: ea10ddf1 32323969
Author: Joe Kaiser <joe.kaiser@teradata.com>
Date:   Tue Jan 23 13:42:31 2018 -0700

    Merge branch 'feature/sles12sp3_support' of ssh://github.com/teradata/stacki into feature/sles12sp3_support

commit 0a7067711b6f6ef67f1a2ef652a6dbf8cff76602
Author: Joe Kaiser <joe.kaiser@teradata.com>
Date:   Tue Jan 23 13:40:44 2018 -0700

    Fix of add.host.interface options.

commit 32323969916bf12e94f43371811d6772a423df9d
Author: Anoop Rajendra <anoop.rajendra@teradata.com>
Date:   Tue Jan 23 12:38:58 2018 -0800

    Fix incorrect merge

commit 159fba220c95955961f97299ad0bbb149b2779c1
Merge: db316bf8 f0343f28
Author: Anoop Rajendra <anoop.rajendra@teradata.com>
Date:   Tue Jan 23 12:33:11 2018 -0800

    Merge branch 'develop' into feature/sles12sp3_support

commit 4c344f7a60c2c18016f6c1b88548a77e4a6c1ae2
Author: Mike Bobadilla <mike.bobadilla@teradata.com>
Date:   Tue Jan 23 10:54:15 2018 -0800

    change add switch host to relect db changes

commit a39ade809267245e5b43ea2e988a195dfb5bbc02
Author: Mike Bobadilla <mike.bobadilla@teradata.com>
Date:   Tue Jan 23 10:53:07 2018 -0800

    change db schema to interface, switch, and port since vlan will be pulled from networks table

commit f6d5d552eaba97653cb79676bdc954fd7d3b465a
Author: Mike Bobadilla <mike.bobadilla@teradata.com>
Date:   Tue Jan 23 10:51:57 2018 -0800

    add model to 'list switch'

commit ea10ddf1a63ff1d1d6e5db3abc43c5f59df749a2
Merge: db316bf8 f0343f28
Author: Joe Kaiser <joe.kaiser@teradata.com>
Date:   Tue Jan 23 09:29:21 2018 -0700

    Merge branch 'develop' of ssh://github.com/teradata/stacki into feature/sles12sp3_support

commit f0343f28a753a7dbb6c6503469e371df52f4918b
Author: Joe Kaiser <joe.kaiser@teradata.com>
Date:   Mon Jan 22 17:38:33 2018 -0800

    dhcp fix.

commit d218da52c27cbdb32400d179ff2062c22b27da75
Author: Joe Kaiser <joe.kaiser@teradata.com>
Date:   Mon Jan 22 16:21:48 2018 -0700

    Ansible changes.

commit 2eb2ff24d79fe7fbed053061447f2f869974a918
Author: Mike Bobadilla <mike.bobadilla@teradata.com>
Date:   Mon Jan 22 14:27:54 2018 -0800

    stacki output for macs

commit 67498deb6beb13f0a7ce023b25a86170b8556ef6
Author: Mike Bobadilla <mike.bobadilla@teradata.com>
Date:   Mon Jan 22 13:58:23 2018 -0800

    stacki output for running config

commit af7ae43c5caca75c1bf57844cd09beae78df1fc4
Author: Mike Bobadilla <mike.bobadilla@teradata.com>
Date:   Mon Jan 22 11:57:34 2018 -0800

    Copying to startup configuration optional

commit 227c81425877a7937841c6fd701cfea5d241509b
Author: Mike Bobadilla <mike.bobadilla@teradata.com>
Date:   Mon Jan 22 11:07:41 2018 -0800

    duh

commit 63f395ca04299dc3dea699532c4f3cf1b8145807
Author: Mike Bobadilla <mike.bobadilla@teradata.com>
Date:   Mon Jan 22 11:06:19 2018 -0800

    move sync switch

commit db316bf8423d98bf167e63b24097aaf46c575660
Merge: 01acce0c 1e9690f0
Author: Anoop Rajendra <anoop.rajendra@teradata.com>
Date:   Mon Jan 22 11:02:57 2018 -0800

    Merge branch 'develop' into feature/sles12sp3_support

commit 2978657b41ccbdd184c07f20ed5b7ae6b530ade5
Author: Mike Bobadilla <mike.bobadilla@teradata.com>
Date:   Mon Jan 22 10:26:18 2018 -0800

    remove switch command

commit 815845e4deb765a77169dd965c6cd8abbdfac7e7
Author: Mike Bobadilla <mike.bobadilla@teradata.com>
Date:   Mon Jan 22 09:47:49 2018 -0800

    stack add switch command

commit 1e86fca1f8120789d11368f0ef0be907a74024e2
Merge: 491af22f 1e9690f0
Author: Joe Kaiser <joe.kaiser@teradata.com>
Date:   Fri Jan 19 17:23:21 2018 -0700

    Merge branch 'develop' of ssh://github.com/teradata/stacki into feature/ansible

commit 1e9690f0c4edb5889395010e2f6f823f1446004d
Author: Aish <cyberaishu@gmail.com>
Date:   Fri Jan 19 13:58:35 2018 -0800

    Added pydocs for 'list firewall' code.

commit 6859d2a487e95ba126b5263c6ad19a60f2f2da35
Author: Mason J. Katz <Mason.Katz@Teradata.com>
Date:   Fri Jan 19 17:05:32 2018 -0500

    report host interface
    
           fix for non-dhcp and virtual interfaces
           remove strip() and make sure everything is a string

commit 030cefc4c40707333bf1121944db3c7d707b32dc
Author: Aish <cyberaishu@gmail.com>
Date:   Thu Jan 18 12:43:33 2018 -0800

    Added intrinsic firewall rules for pxe=True networks.
    Refactored 'list firewall' code to make it similar to 'list attr'

commit 01acce0ca868567179d46d4fe9d092110b69474d
Merge: 5d9a7942 86536ecc
Author: Anoop Rajendra <anoop.rajendra@teradata.com>
Date:   Thu Jan 18 12:34:40 2018 -0800

    Merge branch 'develop' into feature/sles12sp3_support
    
    Conflicts:
            common/src/stack/build/build/src/pallet/bin/get3rdparty.py

commit 491af22f02940bc9b75d7fb54851302b81fb3468
Merge: d9e03ecc 86536ecc
Author: Joe Kaiser <joe.kaiser@teradata.com>
Date:   Wed Jan 17 18:24:00 2018 -0700

    Merge branch 'develop' of ssh://github.com/teradata/stacki into feature/ansible

commit 86536eccb3df6239f33633bbea460f68ccd5719f
Author: Mason Katz <Mason.Katz@Teradata.com>
Date:   Wed Jan 17 19:55:34 2018 -0500

    Now using 3rdparty.json instead of 3rdparty.manifest
    
    You can know specify different sources for the blobs, at some
    point this could include sourcing from artifactory. Still
    provides a single source for each blob, but each blob could
    come from a different place.

commit d9e03ecc3d78bd69ae29db5930d469a9f3512396
Author: Joe Kaiser <joe.kaiser@teradata.com>
Date:   Wed Jan 17 17:24:44 2018 -0700

    graph/node ansible xmls.
    report/sync commands.

commit 9980681a2b1a39104bddd2f04b0fdb4c8d4d2b1b
Author: Bill Sanders <billysanders@gmail.com>
Date:   Wed Jan 17 15:27:12 2018 -0800

    remove new aws packages from sles11 manifest, was breaking builds

commit 5e180265a67b4d560248c21d1a1c178d0290426f
Merge: ead23a65 260321d7
Author: root <root@tdcsl12.jkloud>
Date:   Wed Jan 17 16:21:30 2018 -0700

    Merge branch 'develop' of ssh://github.com/teradata/stacki into feature/ansible

commit ead23a65a1142bf2a605aaa53def35f0ebe16645
Author: root <root@tdcsl12.jkloud>
Date:   Wed Jan 17 16:20:44 2018 -0700

    Ansible support.

commit 515ebcaf291721db73f70a16cc01fb7dd03e2316
Author: Mike Bobadilla <mike.bobadilla@teradata.com>
Date:   Wed Jan 17 15:14:05 2018 -0800

    enable and disable switch host discovery daemon

commit 0a90a8fd51283ae083457884d67ed7a80824a87e
Author: Mike Bobadilla <mike.bobadilla@teradata.com>
Date:   Wed Jan 17 15:11:13 2018 -0800

    Add discovery option for host discovry on switches

commit 68f4b5432b43e1b5f0a6c613cf591bc389992053
Author: Mike Bobadilla <mike.bobadilla@teradata.com>
Date:   Wed Jan 17 15:10:15 2018 -0800

    refactor code a bit

commit 260321d7abc2de1a61fd33436fbb6ea9f8a1a604
Author: Mason Katz <Mason.Katz@Teradata.com>
Date:   Wed Jan 17 17:05:00 2018 -0500

    Do the same thing for barnacle appliances and replicants.

commit c8bce7917b358e9665635588e8dfa3506f64d358
Author: Mason Katz <Mason.Katz@Teradata.com>
Date:   Wed Jan 17 17:01:29 2018 -0500

    fix python whitespace (health processor was broken)

commit 5d9a7942bd7c393d281c5d47c1f8cba1b90b219b
Merge: d24d150d 7f822a8a
Author: Anoop Rajendra <anoop.rajendra@teradata.com>
Date:   Wed Jan 17 12:17:05 2018 -0800

    Merge branch 'develop' into feature/sles12sp3_support

commit 7f822a8a265761a7653ebb20dbcdf2f4b29beff7
Merge: 463622fc 75606ea2
Author: Mason J. Katz <Mason.Katz@Teradata.com>
Date:   Tue Jan 16 19:55:05 2018 -0500

    Merge branch 'develop' of github.com:Teradata/stacki into develop

commit 463622fce7c9231e595cd6f8109cbdb4c020c13b
Author: Mason J. Katz <Mason.Katz@Teradata.com>
Date:   Tue Jan 16 19:51:15 2018 -0500

    report host interface - change dhcp code
    
    If an interface is 'default' and has the 'dhcp' option set the following:
       DHCLIENT_SET_HOSTNAME="yes"
       DHCLIENT_SET_DEFAULT_ROUTE="yes"
    For non-default dhcp interfaces set the above to "no"
    
    This was needed for AWS but will still work in Vagrant.
    
    Also cleaned up the code to use  'list host interface expanded=true' so
    we could remove the call to 'list network'.

commit d24d150d055ab63ce2ea107315000ee9825fc5e3
Merge: 7dae9cf5 75606ea2
Author: Anoop Rajendra <anoop.rajendra@teradata.com>
Date:   Tue Jan 16 15:14:44 2018 -0800

    Merge branch 'develop' into feature/sles12sp3_support

commit 75606ea23c0bf5f7280bef8bbe2f6ba465f7a1e5
Author: Bill Sanders <billysanders@gmail.com>
Date:   Tue Jan 16 14:15:58 2018 -0800

    add test to see if stacki rest api is running

commit a9d5701f0b6cce14f69e860cc62b4e4f366028c6
Merge: 1e163ba1 6bbc91cd
Author: Mason J. Katz <Mason.Katz@Teradata.com>
Date:   Tue Jan 16 13:37:37 2018 -0500

    Merge branch 'feature/aws' into develop
    
    Conflicts:
            common/nodes/database-data-init.xml

commit 1e163ba14e2614abbb04a1a039c140bf7382019e
Author: Mason J. Katz <Mason.Katz@Teradata.com>
Date:   Tue Jan 16 13:05:17 2018 -0500

    happy new year

commit 6bbc91cd12da39875a527817b79b508768b54161
Author: Mason J. Katz <Mason.Katz@Teradata.com>
Date:   Tue Jan 16 12:58:11 2018 -0500

    New Frontend (ami-c61437bc) and Backend (ami-3e436044) AMIs
    
    To build a cluster
       1) Start a Frontend instance
       2) Use you AWS ssh key to log in after 5 minutes
       3) Start a Backend instance with the following in the user data
       { "master": "ipaddress-of-frontend" }
    
    There is no step four, you are done.

commit 490498e28871ca40148efc8dae360c88d1a600bb
Author: Mike Bobadilla <mike.bobadilla@teradata.com>
Date:   Tue Jan 16 09:55:36 2018 -0800

    organize files into separate folder

commit 3a5ec420e89949350bda52f9c4e34b8221310fe2
Author: Mike Bobadilla <mike.bobadilla@teradata.com>
Date:   Mon Jan 15 16:17:51 2018 -0800

    set switch host vlan

commit a3ed8ee80600ef3acc63e61751cc0e5008b6e460
Author: Mike Bobadilla <mike.bobadilla@teradata.com>
Date:   Mon Jan 15 16:12:40 2018 -0800

    remove hard coded values

commit 0f1746d29d99b1e78580464682be39d700988d37
Author: Mike Bobadilla <mike.bobadilla@teradata.com>
Date:   Mon Jan 15 16:09:45 2018 -0800

    set default vlan to 1 and set required to False

commit 9b567a9e34acad7e2cd839e35ab6cc446b94ed6a
Author: Mike Bobadilla <mike.bobadilla@teradata.com>
Date:   Mon Jan 15 16:09:02 2018 -0800

    remove exception for now

commit 01d1f0cd8e80916ac7b69cb8dd2c48b2497c35d1
Author: Mike Bobadilla <mike.bobadilla@teradata.com>
Date:   Mon Jan 15 12:27:23 2018 -0800

    add switch host

commit 4d2bfb848f088d3fa7403f75d637a742d92514ba
Author: Mike Bobadilla <mike.bobadilla@teradata.com>
Date:   Mon Jan 15 10:27:58 2018 -0800

    Print hosts connected to each switch

commit 7c7d99e15e3e8474ea44d9b20d5a6924c724cc66
Author: Mike Bobadilla <mike.bobadilla@teradata.com>
Date:   Mon Jan 15 10:27:20 2018 -0800

    use new Switch method instead Host method

commit e35844e7422d8c8931dbd87a1872f48ee7362a0d
Author: Mike Bobadilla <mike.bobadilla@teradata.com>
Date:   Mon Jan 15 10:25:37 2018 -0800

    Add a SwitchArgumentProcessor

commit 867c8dd1a2a539967174c142f1b145b473e8e1ab
Author: Mike Bobadilla <mike.bobadilla@teradata.com>
Date:   Fri Jan 12 13:15:38 2018 -0800

    remove copy pasta

commit c72ac78db8818794246035a12f7732ced757d395
Author: Mike Bobadilla <mike.bobadilla@teradata.com>
Date:   Fri Jan 12 13:13:40 2018 -0800

    create separate config file for each switch

commit c110127bca3131a1f30a48201e932c1b6f2a4b21
Author: Mike Bobadilla <mike.bobadilla@teradata.com>
Date:   Fri Jan 12 13:12:35 2018 -0800

    Get vlan config from switch

commit 5c888f33d89bf70d7b719292471012b5b0afacf1
Author: Mike Bobadilla <mike.bobadilla@teradata.com>
Date:   Thu Jan 11 16:25:26 2018 -0800

    Port management table. Defines what port a node is connected to on a switch.

commit 83a9610336bc7c26d3c368dc5a3c71af7c7af979
Author: Mike Bobadilla <mike.bobadilla@teradata.com>
Date:   Thu Jan 11 14:31:50 2018 -0800

    Check if redis has a status instead of calculating the time

commit 7dae9cf51b461fb061fea1ad3cc67ab37461401a
Author: Anoop Rajendra <anoop.rajendra@teradata.com>
Date:   Thu Jan 11 12:06:16 2018 -0800

    Fix directory paths

commit 8165e514e95dfb847705bcd913fd52be13bf1d66
Merge: 576c5c47 9ab8f6a7
Author: Anoop Rajendra <anoop.rajendra@teradata.com>
Date:   Thu Jan 11 12:04:06 2018 -0800

    Merge branch 'develop' into feature/sles12sp3_support

commit 9ab8f6a732d82c54d485c0875d9892871db86001
Merge: 66158680 6f8b633f
Author: Anoop Rajendra <anoop.rajendra@teradata.com>
Date:   Thu Jan 11 12:03:41 2018 -0800

    Merge branch 'develop' of github.com:Teradata/stacki into develop

commit 6f8b633f97f3c6bb909941a498654d7d3316be8d
Author: Taylor Sanchez <taylor.sanchez@teradata.com>
Date:   Thu Jan 11 12:04:53 2018 -0800

    Forgot to capatlize on more

commit 3b51d2dcad4e3210dc0c9822fb5edf3a602a2889
Author: Mike Bobadilla <mike.bobadilla@teradata.com>
Date:   Thu Jan 11 10:33:39 2018 -0800

    set timeout per host

commit d588f1617cc83b95381cefebc3ed181137dceb11
Author: Mike Bobadilla <mike.bobadilla@teradata.com>
Date:   Thu Jan 11 10:29:42 2018 -0800

    move writing config file into stack report

commit 955adf128327cffa3c6f9773f51add4a637205c0
Author: Taylor Sanchez <taylor.sanchez@teradata.com>
Date:   Thu Jan 11 10:24:01 2018 -0800

    Attributes uses a capital True.
    
    STACKI-178: My testing was hitting the blanked out fstab part of the if statement, so this morning I realized a completely fresh install doesn't function right. Quick fix.

commit b5d5400b421accb215a66919a4627effd5a7ce7e
Author: Taylor Sanchez <taylor.sanchez@teradata.com>
Date:   Thu Jan 11 09:25:46 2018 -0800

    Found one more pallets attribute, swapping it real quick
    
    STACKI-215
    (Also I should have used an elif, but ignore that)

commit 576c5c47ad6cace269b8b2f005a6900af7c2baac
Author: Anoop Rajendra <anoop.rajendra@teradata.com>
Date:   Wed Jan 10 21:08:41 2018 -0800

    Retry curl command when it fails downloading 3rd party packages

commit 61c49076244225c14bc2a449deb26b90b3c587be
Merge: ff7d92fd 66158680
Author: Anoop Rajendra <anoop.rajendra@teradata.com>
Date:   Wed Jan 10 18:38:39 2018 -0800

    Merge branch 'develop' into feature/sles12sp3_support
    
    Conflicts:
            common/src/stack/storage-config/lib/stacki_storage.py
            sles/src/stack/images/common/sles-stacki.img-patches/opt/stack/bin/output-bootloader.py

commit 66158680d4b8c7c835ee9950747718a2060ce6bc
Merge: 9e030a3a b558d6a6
Author: Anoop Rajendra <anoop.rajendra@teradata.com>
Date:   Wed Jan 10 18:37:10 2018 -0800

    Merge branch 'develop' of github.com:Teradata/stacki into develop

commit 9e030a3a063c2215cc8e50735e31304d5e232026
Author: Anoop Rajendra <anoop.rajendra@teradata.com>
Date:   Wed Jan 10 18:36:35 2018 -0800

    Set ChallengeResponseAuth to true. Allows for password logins

commit e0d5a1d52353598d384d4a04fcb2da9994c69f8a
Author: Mike Bobadilla <mike.bobadilla@teradata.com>
Date:   Wed Jan 10 16:36:21 2018 -0800

    initial reporting for switches

commit b558d6a64c7c9b3fe662a142df657d66f3b985f4
Author: Taylor Sanchez <taylor.sanchez@teradata.com>
Date:   Wed Jan 10 12:14:28 2018 -0800

    Using os and os.version instead of release

commit ff7d92fd8c0bd99680ff1f366f7053844baad8e6
Author: Anoop Rajendra <anoop.rajendra@teradata.com>
Date:   Wed Jan 10 11:57:50 2018 -0800

    reference correct attribute

commit c470a855e233acbed810962d6d95ef2fc45df30f
Merge: 4539eaf7 c0fb76d8
Author: Anoop Rajendra <anoop.rajendra@teradata.com>
Date:   Wed Jan 10 11:39:58 2018 -0800

    Merge branch 'develop' into feature/sles12sp3_support

commit 4539eaf75b7283b7f352e4dfe0b64a832fb3349c
Merge: ffbce99d 37ad9354
Author: Anoop Rajendra <anoop.rajendra@teradata.com>
Date:   Wed Jan 10 11:39:33 2018 -0800

    Merge branch 'develop' into feature/sles12sp3_support
    
    Conflicts:
            sles/src/stack/images/common/sles-stacki.img-patches/opt/stack/bin/output-bootloader.py

commit c0fb76d86f41ce332cc41935cb1393cb46edf554
Author: Taylor Sanchez <xTaylorSanchez@gmail.com>
Date:   Wed Jan 10 10:17:06 2018 -0800

    Fix sles11 build
    
    Looks like this was needed for the build process, otherwise sles11 builds fail on stack-discovery

commit 28ba3a3184ad6165c13b35f3a29334384a207381
Author: Mike Bobadilla <mike.bobadilla@teradata.com>
Date:   Tue Jan 9 15:58:50 2018 -0800

    Add some stack commands

commit 5bf855519b3a4534141fc65646e1a062b607b0d5
Author: Mike Bobadilla <mike.bobadilla@teradata.com>
Date:   Tue Jan 9 15:56:47 2018 -0800

    Initial Switch Configuration :rocket:

commit 37ad935420fbe7f1053c9e4ffa43730c62086d35
Merge: cebb4d0a fb83f0a4
Author: Taylor Sanchez <taylor.sanchez@teradata.com>
Date:   Tue Jan 9 15:45:28 2018 -0800

    Merge branch 'feature/change_pallet_attribute_to_release_STACKI_215' into develop

commit cebb4d0a8cdd7747e6119ffcef67d38e999ee67e
Merge: 8d260574 9d0dc6a0
Author: Taylor Sanchez <taylor.sanchez@teradata.com>
Date:   Tue Jan 9 15:26:40 2018 -0800

    Merge branch 'feature/sles_nukedisks_false_issue_STACKI_178' into develop

commit 9d0dc6a00c4469f1a729d5c837592efa98f39477
Author: Taylor Sanchez <taylor.sanchez@teradata.com>
Date:   Tue Jan 9 13:13:05 2018 -0800

    Separated out change for missing fstab on nukedisks=false

commit 5a57b996ba809940c87e9b9f738761cd90a21d68
Author: Taylor Sanchez <taylor.sanchez@teradata.com>
Date:   Tue Jan 9 13:12:43 2018 -0800

    Appears to be working for nukedisks=false
    
    Going to do some more testing, but most of this should be done.

commit 8d2605742e0cb7adc1c16ce77d22651d30285bdf
Author: Chris Ladd <chris.ladd@teradata.com>
Date:   Tue Jan 9 10:14:03 2018 -0800

    Only check the ip if it exists

commit ffbce99d7692a84cd221ddaeab24835b6fbd5626
Merge: ae9c5257 ab399cc3
Author: Anoop Rajendra <anoop.rajendra@teradata.com>
Date:   Mon Jan 8 20:54:20 2018 -0800

    Merge branch 'develop' into feature/sles12sp3_support

commit ab399cc3664728b46ee59c7d69007db5cc2b3a59
Merge: 6f4915ba a05d86fb
Author: Chris Ladd <chris.ladd@teradata.com>
Date:   Mon Jan 8 15:20:12 2018 -0800

    Merge branch 'develop' of github.com:Teradata/stacki into develop

commit 6f4915ba5e3c7e40f869339283618474d5f3bf95
Merge: ad8e9498 6cb83263
Author: Chris Ladd <chris.ladd@teradata.com>
Date:   Mon Jan 8 15:19:27 2018 -0800

    Merge branch 'feature/discovery' into develop

commit ae9c525708395afdf1bb40ee190557c90e1e068f
Author: Anoop Rajendra <anoop.rajendra@teradata.com>
Date:   Mon Jan 8 13:43:02 2018 -0800

    Missed file fix

commit e895596f6022ba704e731afeeff6288b22a23e4c
Author: Anoop Rajendra <anoop.rajendra@teradata.com>
Date:   Mon Jan 8 13:41:57 2018 -0800

    Fix links to packages.
    Fix references to other makefiles, and to localrepo

commit a05d86fb2425027befbd64e5c8521158910a16fb
Author: Joe Kaiser <joe.kaiser@teradata.com>
Date:   Mon Jan 8 14:32:19 2018 -0700

    Fix stack create package command.

commit 6cb832635b660ede9a50c07dd418bec46fc240ce
Author: Chris Ladd <chris.ladd@teradata.com>
Date:   Mon Jan 8 13:30:28 2018 -0800

    Small doc fix

commit 94a841216c1d42d12a79b7a2823f3c784e3ad805
Author: Anoop Rajendra <anoop.rajendra@teradata.com>
Date:   Mon Jan 8 10:05:39 2018 -0800

    Start support for SLES 12.3

commit 24dba11621b63eb7d94046fa830e253f1a9d82e1
Author: Mike Bobadilla <mike.bobadilla@teradata.com>
Date:   Mon Jan 8 09:55:27 2018 -0800

    Update redis status to 'Installing packages' during install

commit abc372c76bc1e538785d03b640911eb7dfa35836
Author: Chris Ladd <chris.ladd@teradata.com>
Date:   Mon Jan 8 09:48:04 2018 -0800

    Checkpoint: Actually install the new stack-discovery package on the frontend.

commit 456e4623d8b1718ca496e6e04eefb632971f1a2b
Author: Anoop Rajendra <anoop.rajendra@teradata.com>
Date:   Fri Jan 5 18:06:31 2018 -0800

    Apparently we don't like conditionals on a <to> tag.
    Only on an <edge> tag

commit 2a61aaa89de0b52b9fd0b96dbf68e5f78fe964d6
Merge: 7ca06734 e265934f
Author: Anoop Rajendra <anoop.rajendra@teradata.com>
Date:   Fri Jan 5 17:20:03 2018 -0800

    Merge branch 'feature/20171212_synchost' into develop

commit e265934f6c49ea4bd9e2055197c5ba1759bcda3e
Author: Anoop Rajendra <anoop.rajendra@teradata.com>
Date:   Fri Jan 5 17:17:43 2018 -0800

    syntax fix

commit 27b877035b4d04a05542e0f48203a48a66277368
Author: Chris Ladd <chris.ladd@teradata.com>
Date:   Fri Jan 5 16:27:50 2018 -0800

    Checkpoint: Discovery builds as an RPM

commit 6447fb27538c2ad3c1623a4b4398268d1e344ad6
Author: Anoop Rajendra <anoop.rajendra@teradata.com>
Date:   Fri Jan 5 16:18:42 2018 -0800

    Put back replicant conditional

commit fb83f0a46c3379cf63b7f6989ce21a1a7211ce69
Author: Taylor Sanchez <taylor.sanchez@teradata.com>
Date:   Fri Jan 5 11:21:27 2018 -0800

    use the release attribute instead of pallets

commit 152f5f66db50d3f02e6825dc5f1780fd6511da90
Author: Chris Ladd <chris.ladd@teradata.com>
Date:   Thu Jan 4 16:06:24 2018 -0800

    Checkpoint: Add --no-install flag to just discover nodes and add them to the DB, but don't install an OS. Add --debug flag for more log output.

commit 9d6c589ef04f228648bc8e95cdf067417c2fe972
Merge: 2c25bf30 7ca06734
Author: Anoop Rajendra <anoop.rajendra@teradata.com>
Date:   Thu Jan 4 15:06:38 2018 -0800

    Merge branch 'develop' into feature/20171212_synchost

commit 7ca0673466cabb11b9fcb6d85beb6dd69079569d
Author: Mike Bobadilla <mike.bobadilla@teradata.com>
Date:   Thu Jan 4 14:08:28 2018 -0800

    add test_ to test filenames

commit 5d9347cb8f0dd52eb46de79abb6fb2529a6bf842
Author: Chris Ladd <chris.ladd@teradata.com>
Date:   Thu Jan 4 13:52:25 2018 -0800

    Checkpoint: Discovery daemon now sends out messages and the discover-nodes TUI displays them in a pretty way.

commit cecc6519fa9410ee3fa3e98236093a84369646fd
Author: Bill Sanders <billysanders@gmail.com>
Date:   Thu Jan 4 12:25:01 2018 -0800

    for sles, disable the suse firewall, not firewalld

commit a95e4a6809e700d08f6b381ef91f7b1f7ef64dd7
Author: Mike Bobadilla <mike.bobadilla@teradata.com>
Date:   Thu Jan 4 11:36:44 2018 -0800

    fix host route bug

commit 2c25bf30b19a34c19c002c563ad97a363e9e3e49
Merge: 17c2216a 365fa9e3
Author: Anoop Rajendra <anoop.rajendra@teradata.com>
Date:   Wed Jan 3 17:03:13 2018 -0800

    Merge branch 'develop' into feature/20171212_synchost

commit 365fa9e36c0f35254d4979fbe9a9768e0b9879f9
Merge: 7e8e4204 26ae59dd
Author: Anoop Rajendra <anoop.rajendra@gmail.com>
Date:   Wed Jan 3 16:30:36 2018 -0800

    Merge pull request #209 from Teradata/bugfix/add-host-interface-bugfix
    
    stack add host interface bugfix

commit 26ae59ddc8f687f3560790b6118b890f2165acd3
Author: Mike Bobadilla <mike.bobadilla@teradata.com>
Date:   Wed Jan 3 16:21:17 2018 -0800

    remove hard coded value

commit 17c2216ac88573ba3971316c53b989c4be274dcf
Merge: a4137e60 7e8e4204
Author: Anoop Rajendra <anoop.rajendra@teradata.com>
Date:   Wed Jan 3 16:17:23 2018 -0800

    Merge branch 'develop' into feature/20171212_synchost

commit 7e8e42042efde3b4ac3f151d412b7382c719cd7c
Merge: 1033a140 0d570b64
Author: Taylor Sanchez <taylor.sanchez@teradata.com>
Date:   Wed Jan 3 15:34:15 2018 -0800

    Merge branch 'feature/sles_11_blank_host_partition_STACKI_180' into develop

commit 0d570b64a21d6abb24d214be582d6d883066d1b7
Author: Taylor Sanchez <taylor.sanchez@teradata.com>
Date:   Wed Jan 3 14:47:50 2018 -0800

    Removed hardcoded sles11=True

commit 6a99e02db5f3231e6b5d1669cc1edc507809afda
Author: Chris Ladd <chris.ladd@teradata.com>
Date:   Wed Jan 3 11:46:12 2018 -0800

    Checkpoint: Created the basic TUI for discover-nodes. Now just to lay the MQ plumbing.

commit 33ec5492687f9706c840cddcca71d68998d8a5d9
Author: Taylor Sanchez <taylor.sanchez@teradata.com>
Date:   Wed Jan 3 10:43:03 2018 -0800

    Trying out the Jenkins build process

commit dcd6f92c9059adfadb1114ca93cf50b81a2ac8b5
Author: Bill Sanders <billysanders@gmail.com>
Date:   Wed Jan 3 10:09:32 2018 -0800

    add stack-barnacle to manifest to make builds stop failing

commit 5b2a6bae35935d3ff5cc03e1357d2e46d0328a57
Author: Bill Sanders <billysanders@gmail.com>
Date:   Wed Jan 3 10:01:17 2018 -0800

    cleanup fix for jenkins

commit 823973159fd23909f0dadbc9db800117b57de611
Author: Bill Sanders <billysanders@gmail.com>
Date:   Wed Jan 3 09:59:35 2018 -0800

    cleanup fix for jenkins

commit 9a58eedf6a08c3367ee89651a5db381167d74e60
Author: Mike Bobadilla <mike.bobadilla@teradata.com>
Date:   Tue Jan 2 16:44:13 2018 -0800

    stack add host interface bugfix

commit fa2c6142c122ecaf9fd52f88e9814ab520b37ebb
Author: Chris Ladd <chris.ladd@teradata.com>
Date:   Tue Jan 2 14:19:08 2018 -0800

    Checkpoint: Add stack disable, enable, and report commands for discovery

commit 1033a140af85b59e6ea97f340a97a3ecc053de24
Author: Bill Sanders <billysanders@gmail.com>
Date:   Tue Jan 2 14:07:56 2018 -0800

    Only delete vm's on failure

commit c34f010ae176b2e90d213bb44f0a1c93479452d3
Author: Bill Sanders <billysanders@gmail.com>
Date:   Tue Jan 2 12:03:57 2018 -0800

    Jenkins needs a node
    
    This syntax is weird, and might not work with more than one builder...

commit d8f7375789c7e32bbf385a551337148246a08fca
Merge: 06af73e1 82d6cc89
Author: Joe Kaiser <joe.kaiser@teradata.com>
Date:   Tue Jan 2 12:54:28 2018 -0700

    Merge branch 'develop' of ssh://github.com/teradata/stacki into develop

commit 06af73e19bf3b6262d677e2f2b5e7c2447ebdad6
Merge: 48d55198 7e7f834f
Author: Joe Kaiser <joe.kaiser@teradata.com>
Date:   Tue Jan 2 12:53:39 2018 -0700

    Docstrings update.
    CLI wiki code updated for python3.
    Merge branch 'feature/docstrings' into develop

commit 82d6cc895e2be8e5b3c07cf316d86eee262dfc31
Author: Bill Sanders <billysanders@gmail.com>
Date:   Tue Jan 2 09:44:02 2018 -0800

    cleanup build vms

commit 7e7f834f3c76b6b8933a273f8c23c4e794ffab5f
Author: Joe Kaiser <joe.kaiser@teradata.com>
Date:   Fri Dec 29 11:16:40 2017 -0700

    Yeah, that's embarrassing.

commit 0475ac75f6f6bf7977f29a972c2def105961479e
Author: Joe Kaiser <joe.kaiser@teradata.com>
Date:   Fri Dec 29 11:13:58 2017 -0700

    Be nice, for once. Mostly to yourself.

commit d4d1f1d6225de404ef37e0e5a64a3b7721bbc5cf
Author: Joe Kaiser <joe.kaiser@teradata.com>
Date:   Fri Dec 29 10:40:30 2017 -0700

    Change "compute" to "backend."

commit d42b2acbbbef234112109aba07ba2e3c87772d88
Author: Joe Kaiser <joe.kaiser@teradata.com>
Date:   Fri Dec 29 10:08:09 2017 -0700

    genrcldocs python3 changes.
    Markdown fix for help format.

commit a4137e60f87bccaf7db9bd263a254879c4ee3749
Author: Anoop Rajendra <anoop.rajendra@teradata.com>
Date:   Wed Dec 27 17:05:12 2017 -0800

    If no database is present stack report host shouldn't fail

commit 8afd7dda5c35a52cad47a3e554eaeaae4df6cf31
Author: Anoop Rajendra <anoop.rajendra@teradata.com>
Date:   Tue Dec 26 11:57:50 2017 -0800

    Revert graph structure to include mq-client for sles11 machines

commit 35097d3bf6288c90a477dfba61606140de87d4cf
Author: Mason J. Katz <Mason.Katz@Teradata.com>
Date:   Fri Dec 22 17:00:34 2017 -0500

    Getting closer to a Frontend AMI
            Build a barnacle appliance but don't run the graph
            Generate site.attrs from host state when a new instance starts
            Run the graph
            Reboot
            or so that's the idea it's 80% there right now

commit c702bcc7d42602190d5ea9962e7387b43376931f
Merge: bf30a87c 48d55198
Author: Anoop Rajendra <anoop.rajendra@teradata.com>
Date:   Fri Dec 22 11:05:41 2017 -0800

    Merge branch 'develop' into feature/20171212_synchost

commit bf30a87c8a7de5da57430bfe7d2e647563f94cf1
Merge: 0346bd86 d75d4419
Author: Anoop Rajendra <anoop.rajendra@teradata.com>
Date:   Fri Dec 22 11:04:57 2017 -0800

    Merge branch 'develop' into feature/20171212_synchost

commit 48d551984b5ca2c1ecc7d064a51b8c9f1d79f050
Author: Mike Bobadilla <mike.bobadilla@teradata.com>
Date:   Fri Dec 22 11:03:56 2017 -0800

    also update routes file if syncnow is true

commit df5ad164bdc7386846f95c89b825b0834f5db782
Author: Mike Bobadilla <mike.bobadilla@teradata.com>
Date:   Fri Dec 22 11:03:20 2017 -0800

    encode subprocess call to utf-8

commit ba8c2299499202246ffa7438975d355e15e2c9fc
Author: Mike Bobadilla <mike.bobadilla@teradata.com>
Date:   Fri Dec 22 09:40:32 2017 -0800

    check for different Apache service names

commit af1874c21bbf9b63fc5d5ef72aa3b5d8858f781f
Author: Chris Ladd <chris.ladd@teradata.com>
Date:   Thu Dec 21 16:37:46 2017 -0800

    Bug fixes

commit 22d25f8d1ce2f601b360c6a2547bb347f60b16a7
Author: Chris Ladd <chris.ladd@teradata.com>
Date:   Thu Dec 21 16:18:53 2017 -0800

    Checkpoint: Remove all the SQL from the library, use command.call instead.

commit f598b5da7110fb04cbc47a1da2270f441d509918
Author: Chris Ladd <chris.ladd@teradata.com>
Date:   Tue Dec 19 16:34:21 2017 -0800

    Checkpoint: Can detect DHCP, add hosts, and see the kickstarts.

commit b18d2b79d3d7bbf81540ca8ea8886414dcd245a0
Merge: f4a28e35 bf38a902
Author: Greg Bruno <greg.bruno@gmail.com>
Date:   Mon Dec 18 11:29:37 2017 -0800

    Merge branch 'develop' of github.com:/Teradata/stacki into develop

commit f4a28e3537bf4adf23a36663cc3417405759d103
Author: Greg Bruno <greg.bruno@gmail.com>
Date:   Mon Dec 18 11:28:20 2017 -0800

    Remove 'assumeyes=1' in repo configuration file -- zypper/yast does not support it, that is, with
    'assumeyes=1' in the repo configuration file, you'll see warnings like this in the log:
    
        Unknown attribute in [nginx-12-sles12]: assumeyes=1 ignored

commit bf38a90249b70de56a2875cd0b5490116693b313
Author: Mike Bobadilla <mike.bobadilla@teradata.com>
Date:   Mon Dec 18 10:24:50 2017 -0800

    check for network and address compatibility before updating

commit 37ab6ec6378acc469fd421b46f68b484ba4117b8
Author: Greg Bruno <greg.bruno@gmail.com>
Date:   Mon Dec 18 08:39:53 2017 -0800

    Support for building replicants

commit dee12bbc3614cb8580e78509909af8f0b937f1c5
Author: Greg Bruno <greg.bruno@gmail.com>
Date:   Mon Dec 18 08:36:24 2017 -0800

    Bridging support for SLES backends

commit d7f754d106a7ae522fdd9a02f89131a702ef04fe
Author: Mason J. Katz <Mason.Katz@Teradata.com>
Date:   Fri Dec 15 16:33:52 2017 -0500

    Enable Backend Re-Install for AWS
    
           aws-client-register.service
    
           Run after ever boot and query the Frontend on what to do
           1) 'os' - do nothing
           2) 'install' - configure grub2 and reboot

commit adaa5f89f87e7fec1013503ffaa3a50819212683
Author: Chris Ladd <chris.ladd@teradata.com>
Date:   Fri Dec 15 10:16:56 2017 -0800

    Checkpoint: Discovery daemon can start and stop. Log monitoring code is async.

commit b41d4b12eb2b79a5f9d974fc352c26a82f0a4797
Author: Taylor Sanchez <taylor.sanchez@teradata.com>
Date:   Thu Dec 14 15:05:22 2017 -0800

    SLES 12, the 'stack list host partition' command now outputs
    
    STACKI-110

commit 05082d327574cadcd3f0796912d86c4a998db580
Author: root <root@ip-172-30-254-249.ec2.internal>
Date:   Thu Dec 14 17:15:02 2017 -0500

    stack add host interface
            added options parameter
    
    stack report host interface
            do not include ip information if set to DHCP (sles)
            redhat already did this

commit e62488020f5ac1ff1f17f93eaf3a8b73fc943389
Merge: 4c2f478a d75d4419
Author: root <root@ip-172-30-254-249.ec2.internal>
Date:   Thu Dec 14 16:31:37 2017 -0500

    Merge branch 'develop' into feature/aws

commit 4c2f478a04a4ef839ea97e3cfff7780e0462f6ea
Author: root <root@ip-172-30-254-249.ec2.internal>
Date:   Thu Dec 14 16:15:21 2017 -0500

    Split AWS code into
            stack-aws-client
            stack-aws-server
    
    Backend AMI v1.0 is done

commit 1e4b39e85b5f4eabe66fb9c4fa682746b6e74e50
Author: root <root@ip-172-30-254-249.ec2.internal>
Date:   Wed Dec 13 20:09:45 2017 -0500

    AWS DHCP
            - Frontend and Backend both DHCP
            - Don't server DHCP info for AWS hosts
    
    Start of init process for Frontend after the DHCPs with a new
    address. Reset DB information and grab the latest SSH certificate.

commit d75d441959db915bb2487e77abf92ee521e72b21
Merge: f92df313 22b7d557
Author: Anoop Rajendra <anoop.rajendra@teradata.com>
Date:   Wed Dec 13 16:22:24 2017 -0800

    Merge branch 'develop' of github.com:Teradata/stacki into develop

commit f92df3134b0a7540122ce8d158398509ff0e7ccf
Author: Anoop Rajendra <anoop.rajendra@teradata.com>
Date:   Wed Dec 13 16:20:59 2017 -0800

    Bug fix. Need full path for stack:shell

commit 22b7d5570705e502da836cbdb85cf42c3cf0b9a0
Author: Mike Bobadilla <mike.bobadilla@teradata.com>
Date:   Wed Dec 13 16:07:21 2017 -0800

    Don't try to remove the route if it doesn't exist

commit 3e17d1a410d8ff243bd41b5d7794cdbd3498a6c3
Merge: 1c5f4fa8 ad8e9498
Author: root <root@ip-172-30-254-249.ec2.internal>
Date:   Wed Dec 13 14:29:24 2017 -0500

    Merge branch 'develop' into feature/aws

commit 1c5f4fa8588a5b8d6c09315247b6792bf4f9f45d
Merge: 99c394bb 8daafa66
Author: root <root@ip-172-30-254-249.ec2.internal>
Date:   Wed Dec 13 14:26:32 2017 -0500

    Merge branch 'feature/aws' of github.com:Teradata/stacki into feature/aws
    
    Conflicts:
            common/graph/backend.xml
            common/nodes/ldconfig.xml
            common/src/stack/kickstart/register.py

commit 99c394bb016af2eec081d81213dfe49451612fee
Author: root <root@ip-172-30-254-249.ec2.internal>
Date:   Wed Dec 13 14:16:09 2017 -0500

    client can pass the appliance type

commit 86a31dc47268c2c3e5090041cd2ad1893330c945
Author: root <root@ip-172-30-254-249.ec2.internal>
Date:   Mon Dec 11 17:31:19 2017 -0500

    Setup symlink to download kernel/ramdisk images

commit 2244659c772a2c736b98a2bab5c8b0d770c08bee
Author: Mason J. Katz <Mason.Katz@Teradata.com>
Date:   Mon Dec 11 20:26:12 2017 +0000

    check point

commit 6582106b4cf1301f459cf0819788fa514fe77efa
Author: Mason J. Katz <Mason.Katz@Teradata.com>
Date:   Sat Dec 2 01:09:15 2017 +0000

    Allow a new backend to register with the cluster and get a grub.conf
    that will start the installation.
    
    This is just a checkpoint, not turnkey right now.

commit ecaf94c1d00b11a47bc731f675aa5eb850b62496
Author: Mason J. Katz <Mason.Katz@Teradata.com>
Date:   Fri Dec 1 18:06:54 2017 +0000

    Can now build AWS machines w/ Yast (now start coding it up)
    
    - Fix pip2src to handle unicode data in package-info
    - Find the Frontend IP from user-data if not on command line
      Will likely remove this, I don't think this is really needed

commit 0346bd86975f83c9b89ab91802644fcaa5ce5aaf
Merge: 1fca6612 ad8e9498
Author: Anoop Rajendra <anoop.rajendra@teradata.com>
Date:   Wed Dec 13 10:27:05 2017 -0800

    Merge branch 'develop' into feature/20171212_synchost

commit 1fca6612c702cb63d98bc146d7ff91626a18dbf6
Author: Anoop Rajendra <anoop.rajendra@teradata.com>
Date:   Wed Dec 13 10:25:28 2017 -0800

    sync.host attribute functionality now moved to common node file

commit ad8e9498ab6e3d706585ff458350fb12b2d213c8
Merge: 89d033e7 602447ab
Author: Taylor Sanchez <taylor.sanchez@teradata.com>
Date:   Wed Dec 13 09:46:34 2017 -0800

    Merge branch 'feature/discover_all_interfaces_in_sles_STACKI_158' into develop

commit 602447ab6c238ab243a89a25c49a9c6f15c07a67
Author: Taylor Sanchez <taylor.sanchez@teradata.com>
Date:   Wed Dec 13 09:42:10 2017 -0800

    STACKI-158: discover all interfaces in sles during install

commit 89d033e7cc7ef5fea24ab351d9f93d3fe7d5c67d
Author: Joe Kaiser <joe.kaiser@teradata.com>
Date:   Wed Dec 13 10:01:07 2017 -0700

    stack sync host firewall needs a decode and to restart stacki-iptables
    on sles, not iptables.

commit dce9ff6f8bdb867b7f0974bc91dd2563599b61c0
Author: Joe Kaiser <joseph.kaiser@teradata.com>
Date:   Tue Dec 12 17:41:23 2017 -0700

    Update README.md

commit 8daafa66a17e0139240ce10ca2caa2a642b3cf89
Author: root <root@ip-172-30-254-249.ec2.internal>
Date:   Mon Dec 11 17:31:19 2017 -0500

    Setup symlink to download kernel/ramdisk images

commit 9c9efe7567c2519812b1f9c87988c00d5cadcb98
Author: Chris Ladd <chris.ladd@teradata.com>
Date:   Mon Dec 11 13:25:14 2017 -0800

    Copy Redhat's authroized_keys setup for SLES. It is simpler and fixes the backend install issue Bill and I were seeing.

commit 9004cab6130979c943fa9ec06115d462b90fdfcf
Author: Mason J. Katz <Mason.Katz@Teradata.com>
Date:   Mon Dec 11 20:26:12 2017 +0000

    check point

commit e72f8c6a48b672e58b6147ea6f411c47da0d5822
Author: Chris Ladd <chris.ladd@teradata.com>
Date:   Mon Dec 11 10:28:00 2017 -0800

    Fix DB abort connection warnings by closing the database connection when we are done with it.

commit 1673d05afe5c487bfc809512e2205be94d2c8499
Author: Bill Sanders <billysanders@gmail.com>
Date:   Wed Dec 6 16:03:31 2017 -0800

    fix 'list pallet command' for python3

commit 632e0fcd41fe43503a35295e092d56732426aba7
Author: Joe Kaiser <joseph.kaiser@teradata.com>
Date:   Fri Dec 8 08:49:43 2017 -0800

    Update README.md

commit 7a8b7041fcf4fa4830a0d974cb52cc868420a500
Merge: ea4689f4 7799fdc4
Author: Anoop Rajendra <anoop.rajendra@teradata.com>
Date:   Wed Dec 6 16:30:28 2017 -0800

    Merge branch 'develop' of github.com:Teradata/stacki into develop

commit 7799fdc4a9a9e385ba7c4c4e885bf371a949ed1f
Author: Mike Bobadilla <mike.bobadilla@teradata.com>
Date:   Wed Dec 6 14:53:55 2017 -0800

    overwrite existing route if syncnow is true

commit ea4689f40750613bc8f4e864ee7698b1c133e682
Author: Anoop Rajendra <anoop.rajendra@teradata.com>
Date:   Wed Dec 6 13:37:15 2017 -0800

    Bug fix for publish.py
    Install message queue for sles11

commit 3c8fdb7e415f9c6e80658bc6f28c7f996db8cf24
Merge: 85b5dbe3 03beebed
Author: Chris Ladd <chris.ladd@teradata.com>
Date:   Wed Dec 6 13:30:13 2017 -0800

    Merge branch 'develop' of github.com:Teradata/stacki into develop

commit 03beebedabf6713df2314a0a444405d77ec6cf6c
Merge: c3d8d0c1 8994d3c6
Author: Mike Bobadilla <mike.bobadilla@teradata.com>
Date:   Wed Dec 6 13:23:26 2017 -0800

    Merge branch 'feature/default-host-routes' into develop

commit 8994d3c618eb4070475ea4f0cc5cb82a28240676
Author: Mike Bobadilla <mike.bobadilla@teradata.com>
Date:   Wed Dec 6 13:14:36 2017 -0800

    add sync now args

commit 85b5dbe3ad064650b6e4948c3757530f5f605377
Author: Chris Ladd <chris.ladd@teradata.com>
Date:   Wed Dec 6 12:10:02 2017 -0800

    Add DHCP option support for SLES

commit d364a1e2b7828ef43879c6263db56e76bb595806
Author: Mike Bobadilla <mike.bobadilla@teradata.com>
Date:   Tue Dec 5 16:21:20 2017 -0800

    don't create routes for the frontend

commit 020c9f49d1135e701c7d9276fb4c5f7b92c731e7
Author: Mike Bobadilla <mike.bobadilla@teradata.com>
Date:   Tue Dec 5 16:19:42 2017 -0800

    remove print

commit f8a7e87fc17545b2e38177d4a2a875b4342ceccf
Author: Mike Bobadilla <mike.bobadilla@teradata.com>
Date:   Tue Dec 5 15:42:20 2017 -0800

    create default host based route when supporting multitenancy

commit c3d8d0c120d1554e2d2489e3ac257b825a0ae249
Merge: 4c8742d5 f74941e1
Author: Anoop Rajendra <anoop.rajendra@teradata.com>
Date:   Mon Dec 4 15:45:24 2017 -0800

    Merge branch 'develop' of github.com:Teradata/stacki into develop

commit f74941e1b0603149148ffd7d2120ea2f1a84b0c9
Author: Mike Bobadilla <mike.bobadilla@teradata.com>
Date:   Mon Dec 4 13:49:07 2017 -0800

    remove print statement

commit b8afb7fea73714989735783b6fe4874a94bc0a05
Author: Mason J. Katz <Mason.Katz@Teradata.com>
Date:   Sat Dec 2 01:09:15 2017 +0000

    Allow a new backend to register with the cluster and get a grub.conf
    that will start the installation.
    
    This is just a checkpoint, not turnkey right now.

commit 4c8742d5454b6dd653eca3201e0a0b1b65c70689
Author: Anoop Rajendra <anoop.rajendra@teradata.com>
Date:   Fri Dec 1 16:59:15 2017 -0800

    Fix tags

commit 380d48357d4cc2d7563726fb44a137c01cda96ab
Author: root <root@sd-stacki-117.stacki.com>
Date:   Fri Dec 1 13:33:02 2017 -0800

    Add attribute key, value columns to csv file to support 2 different ways of specifying attributes.
    https://jira.td.teradata.com/jira/browse/STACKI-138

commit dad28fce4c734fff4d14b57e973ac533f704ed6a
Author: Mason J. Katz <Mason.Katz@Teradata.com>
Date:   Fri Dec 1 18:06:54 2017 +0000

    Can now build AWS machines w/ Yast (now start coding it up)
    
    - Fix pip2src to handle unicode data in package-info
    - Find the Frontend IP from user-data if not on command line
      Will likely remove this, I don't think this is really needed

commit 834e661f34ec0cb6210ba1fa789567d9f5580277
Author: Bill Sanders <billysanders@gmail.com>
Date:   Fri Dec 1 09:30:36 2017 -0800

    adding a Jenkins build file

commit 120ee9d6cbb3ecd3b8803d09eec1bc983d0bbfde
Author: Anoop Rajendra <anoop.rajendra@teradata.com>
Date:   Thu Nov 30 16:29:12 2017 -0800

    Remove commented out wicked disabling sections. No longer required
    since we create network information early on

commit bfa01fb5c04fdf43cab89600ed1421f57bf744b4
Author: Anoop Rajendra <anoop.rajendra@teradata.com>
Date:   Thu Nov 30 13:40:01 2017 -0800

    D'oh! Remove Bad/Unnecessary line

commit 4bf3fe6925d406d853683ea0ede681af97489c82
Author: Anoop Rajendra <anoop.rajendra@teradata.com>
Date:   Thu Nov 30 12:06:00 2017 -0800

    Don't disable wicked dhcp service. Required for interfaces
    that need to dhcp

commit 8ac6a85ec2820cb70a01105baa28e1f6271578b3
Author: Joe Kaiser <joseph.kaiser@teradata.com>
Date:   Thu Nov 30 10:54:30 2017 -0700

    Update README.md

commit c4632fa4bcecb60565d9dcfa0f20623b0130ed9c
Author: Joe Kaiser <joseph.kaiser@teradata.com>
Date:   Thu Nov 30 10:34:43 2017 -0700

    Update README.md

commit 391d6c30fdc8b454c283a396ea97cb29fa0746e8
Author: Joe Kaiser <joe.kaiser@teradata.com>
Date:   Wed Nov 29 19:57:05 2017 -0500

    Set stacki-profile.py to discover all interfaces except loop back.

commit f30021892bf0af43f9562692ce8ebfe8338e8d7b
Author: Bill Sanders <billysanders@gmail.com>
Date:   Wed Nov 29 16:39:21 2017 -0800

    update jenkinsfile to handle branches

commit cb2db3083cd3c1e327aade45a3c753b706d781ad
Author: Bill Sanders <billysanders@gmail.com>
Date:   Wed Nov 29 16:27:46 2017 -0800

    adding a Jenkins build file

commit 7da0760b4bc9f4d53bcc299d8270d10b482b0d0d
Merge: 62172e64 b0ed4e3f
Author: Anoop Rajendra <anoop.rajendra@teradata.com>
Date:   Tue Nov 28 10:40:48 2017 -0800

    Merge branch 'master' into develop

commit 62172e644290e37bcffd7697372f863d0362e980
Author: Mason J. Katz <Mason.Katz@Teradata.com>
Date:   Mon Nov 27 16:21:30 2017 -0800

    SLES Fixes
         STACKI-148 - SUX remove package
         STACKI-150 - SUX non-shell script

commit 46ec5907257cab723b0c0ecf1b57ece3797a4726
Author: Mike Bobadilla <mike.bobadilla@teradata.com>
Date:   Mon Nov 27 11:37:52 2017 -0800

    vlans need to go in the shared network block as well

commit ea8c2ce1d91a6146dd32d820d4a5eb7d1f3ea22a
Author: Mike Bobadilla <mike.c.bobadilla@gmail.com>
Date:   Fri Nov 24 12:36:37 2017 -0800

    if default route uses a virtual interface, use the main interface

commit 3b46e9582f17b2f2ff84e099983554b54a8ea728
Author: Mike Bobadilla <mike.bobadilla@teradata.com>
Date:   Wed Nov 22 10:25:51 2017 -0800

    sles dhcpd.conf support for interfaces with multiple subnets

commit 07d7b91ec052478eaf19be7d370fa64d03dd1ef9
Author: Bill Sanders <billysanders@gmail.com>
Date:   Tue Nov 21 15:08:23 2017 -0800

    Fix incorrect calling of CommandError

commit 41cd5e30edfbd4b5cb9873d0cae0c3780decd2c9
Merge: d6a454f3 16bd1820
Author: Mike Bobadilla <mike.bobadilla@teradata.com>
Date:   Tue Nov 21 10:28:32 2017 -0800

    Merge branch 'feature/sync-routes' into develop

commit 16bd18201fe563919f261c09445f07b02a75664d
Author: Mike Bobadilla <mike.bobadilla@teradata.com>
Date:   Tue Nov 21 10:26:04 2017 -0800

    Add syncnow feature to add/remove host route commands

commit d6a454f323fe2251063240497c3f3ab4fcf584e2
Author: Bill Sanders <billysanders@gmail.com>
Date:   Mon Nov 20 15:19:31 2017 -0800

    fix docstring for 'add host message'

commit 87f2219a81f77e92c87aaba5d5e2694a1087a7a6
Author: Bill Sanders <billysanders@gmail.com>
Date:   Mon Nov 20 15:13:38 2017 -0800

    fix bug for 'stack add pallet' with no args

commit 8bf0e100689c084063cf8e67f1ef4e9259e4e324
Author: Mike Bobadilla <mike.bobadilla@teradata.com>
Date:   Mon Nov 20 10:19:11 2017 -0800

    Add interface column to routes tables.
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

commit 0cae40efbfe1d69567eb360c3e0d53d0afe1a199
Author: Mason J. Katz <Mason.Katz@Teradata.com>
Date:   Fri Nov 17 15:12:17 2017 -0800

    SLES12 - post-packages fix
    
           sles11
           - installs post-package after network is up
           - requires network scripts in the boot-pre section
    
           sles12
           - installs post-package before network is up
           - requires network scripts in the install-post section
    
           This change does both, tested in 11 and 12
