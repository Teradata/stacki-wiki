Stacki allows the admin to customize the software
footprint of a backend node to enable additional
functionality.

In a default setup, Stacki installs backend nodes with
a very small software footprint. In Stacki parlance, the
backend node is brought up to
> a ping and a prompt

The backend node will have its network configured, and
the SSH daemon is started to allow login access from
the frontend.

To make the backend node more useful, other application
software, and services will need to be installed and
configured.

There are several “levels” of installing applications in Stacki,
we’re going to look at the simplest case. Assumptions are:

1. The application to be installed is available as an RPM
2. The application can be configured using simple shell command
   or a script.
3. The developer is knowledgable about editing XML syntax.

Stacki uses a collection of XML files that provide the definition
of a system, and the instructions for installing a backend node.
To extend the software footprint of a node, we will need to extend
the XML framework to accommodate the extra functionality required.

### Example

In this example, we will extend the backend appliance, by installing
the Apache web server, and starting the service on the backend
node. Further explanation is available in the
[Concepts](#Concepts) section of this page.

The backend appliance definition is a collection of XML files,
the principal file being `backend.xml`.  

1. Copy and modify a `skeleton.xml` template file.
   The `skeleton.xml` file resides in

   ```
   /export/stack/site-profiles/default/1.0/nodes/
   ```
   This file contains explanation of the different sections
   that are allowed in the XML file.
   Copy the file to `extend-backend.xml` in the same directory.
   The new filename instructs Stacki that this file will extend
   the backend appliance.

2. Edit the file  to have the following contents
   ```xml
   <?xml version="1.0" standalone="no"?>
   <kickstart>

      <package>httpd</package>
      <package>httpd-tools</package>
      <package>mod_ssl</package>

      <post>
      /sbin/chkconfig --add httpd
      /sbin/chkconfig httpd on
      </post>

   </kickstart>
   ```
   This simple XML file has the following instructions.
   1. It tells the installer to install `httpd`, `httpd-tools`,
      and `mod_ssl` packages from the repository.
   2. It also tells the installer to run the `chkconfig` commands
      after installation.
      
3. Save the file, and recreate the default distribution. This step
   picks up `extend-backend.xml`, and merges it with the default
   distribution, thereby extending the functionality of the backend node.

   ```
   # stack create distribution
   ```
4. After the distribution is recreated, set all the backend nodes
   to install. For more information about re-installing backend
   refer to the [Re-installation section](Backend-Installation#re-installation).

   ```
   # stack set host boot backend action=install
   ```
5. Reboot the backend nodes. This will boot the backend nodes into
   the Stacki installer. Once the installation completes, the node
   will boot back up into a running state with the Apache web server
   running.
6. Verify that the Apache web server is running, using the command

   ```
   # stack run host backend command='service httpd status'
   ```

### Concepts

#### Order of Installation
When the anaconda installer performs the OS installation, it does
it in the following order.

1.  **Hardware Probing** - The installer starts by probing the
    hardware and enumerates all the devices.

1.  **Network setup**  - The installer then configures the network with
    IP address, netmask, and gateway information

1.  **Kickstart Retrieval** - The installer retrieves a kickstart file
    from the frontend that provides it with instructions on how
    to proceed with the installation.

1.  **Main section** - The installer configures timezones, root
    passwords, etc. This section typically includes Kickstart directives.

1.  **Pre section** - This section consists of instructions to be run
    before the partitioning, and package installation. This
    typically is used to setup the installer environment so that
    partitioning may be changed. This section is typically coded
    in shell, or python.

1.  **Disk setup and partitioning** - This section configures the
    disks attached to the system, partitions them, formats them
    and makes them available to the installer.

1.  **Package Installation** - This section contains a list of
    packages to be installed on the system.

1.  **Post Section** - This section consists of instructions to be
    run after package installation. This section may be coded in
    any interpreted language that is available on the installed
    system.

To extend backend node functionality, the sections most likely to
require modifications are the **package** section and the **post**
sections.

#### XML Syntax

From the sections mentioned above, the Stacki XML framework
maps the **main** section, the **pre** section, the **package**
section, and the **post** section verbatim. There are other tags
supported by Stacki that allow the admin to modify the filesystem
by adding, changing, or removing files.

1.  `<package>` Tag - This tag allows the admin to add packages to
    the installation.
    * ```xml
      <package>httpd</package>
      <package meta="1">gnome-desktop</package>
      ```
      The `meta="1"` attribute informs the installer that the
      package is a group package. 

2.  `<post>` Tag - This tag allows the admin to run scripts after
    the package installation is done. The scripts can be in any
    interpreted language present on the installed system.
    Examples:
    * ```xml
      <post>
      /sbin/chkconfig --enable httpd
      </post>
      ```
      This is converted to a simple shell script that runs
      `chkconfig` to enable the Apache web server
    * ```xml
      <post interpreter="/opt/rocks/bin/python">
      import os, sys
      import subprocess
      p = subprocess.Popen(['/sbin/chkconfig','--enable','httpd'])
      rc = p.wait()
      if rc != 0:
        sys.stderr.write('Chkconfig Failed\n')
      </post>
      ```
      This is converted to a post section that is interpreted as
      python code.
    * ```xml
      <post arg="--nochroot">
      cp /tmp/anaconda.log /mnt/sysimage/tmp/anaconda.log
      </post>
      ```
      The `--nochroot` argument causes the execution of the post
      section in a non-chrooted environment. Typically, after the
      package installation starts the post sections are run in a
      chrooted environment running under `/mnt/sysimage` - ie.-
      In the installer `/mnt/sysimage` is the `/` filesystem on
      the installed machine.
3.  `<file>` Tag - This tag allows the admin to create files on
    the filesystem of the installing machine. This tag is a
    resides inside a `<post>` tag.
    Examples:
    * ```xml
      <post>
        <file name="/tmp/hello.log">
        HELLO
        </file>
      </post>
      ```
      This creates a file called `/tmp/hello.log` that contains
      the word "HELLO" in it.
    * ```xml
      <post>
        <file name="/tmp/hello.log" mode="append">
        WORLD
        </file>
      </post>
      ```
      This appends to a file called `/tmp/hello.log`.
    * ```xml
      <post>
        <file name="/tmp/hello.log" perms="0400">
        HELLO
        </file>
      </post>
      ```
      This creates a file called `/tmp/hello.log` with
      `chmod` permissions of 0400.
    * ```xml
      <post>
        <file name="/tmp/hello.log" owner="root:apache">
        HELLO
        </file>
      </post>
      ```
      This creates a file called `/tmp/hello.log` owned by user
      root and group apache.
