The Stacki XML framework is called **Wire**. To explain how wire
is structured, we first have to understand the process of
installation of a backend node.

### Order of Installation
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

1.  **Disk setup and partitioning** - Next, the installer configures the
    disks attached to the system, partitions them, formats them
    and makes them available to the installer.

1.  **Package Installation** - This section contains a list of
    packages to be installed on the system.

1.  **Post Section** - This section consists of instructions to be
    run after package installation. This section may be coded in
    any interpreted language that is available on the installed
    system.

1.  **Pre-boot Section** - This section is run on first-boot
    before any services or daemons are started.

1. **Post-Boot Section** - This section is a collection of shell
    scripts that are run on first-boot after all services and
    daemons have started. This is typically used to run scripts
    that interact with system daemons, or to finish and clean-up
    the installation process.

To extend backend node functionality, the sections most likely to
require modifications are the **package** section and the **post**
sections.

### Wire XML Syntax Reference

The Stacki Wire XML framework supports the following tags.

##### `<pre>` Tag

This tag allows the admin to run scripts in the
installer before the package installation, and disk
configuration is done. Internally, Stacki uses this section
to configure disk controllers, and partitions.
Example:

* This example looks at the partitions that the installer is
  aware of and keeps a copy of that in a file.

  ```xml
  <pre>
  cat /proc/partitions > /tmp/partitions.state
  </pre>
  ```

##### `<package>` Tag

This tag allows the admin to add packages to
the installation.

* ```xml
  <package>httpd</package>
  <package meta="1">gnome-desktop</package>
  ```

  The `meta="1"` attribute informs the installer that the
  package is a group package. 

##### `<post>` Tag

This tag allows the admin to run scripts after
the package installation is done. The scripts can be in any
interpreted language present on the installed system.
Examples:

* This is converted to a simple shell script that runs
  `chkconfig` to enable the Apache web server.

  ```xml
  <post>
  /sbin/chkconfig --enable httpd
  </post>
  ```

* This post section is interpreted as
  python code.

  ```xml
  <post interpreter="/opt/rocks/bin/python">
  import os, sys
  import subprocess
  p = subprocess.Popen(['/sbin/chkconfig','--enable','httpd'])
  rc = p.wait()
  if rc != 0:
  	sys.stderr.write('Chkconfig Failed\n')
  </post>
  ```

* The `--nochroot` argument causes the execution of the post
  section in a non-chrooted environment. Typically, after the
  package installation starts the post sections are run in a
  chrooted environment running under `/mnt/sysimage` - ie.-
  In the installer `/mnt/sysimage` is the `/` filesystem on
  the installed machine.

  ```xml
  <post arg="--nochroot">
  cp /tmp/anaconda.log /mnt/sysimage/tmp/anaconda.log
  </post>
  ```

##### `<file>` Tag

This tag allows the admin to create files on
the filesystem of the installing machine. This tag is a
resides inside a `<post>` tag.
Examples:

* This creates a file called `/tmp/hello.log` that contains
  the word "HELLO" in it.
  ```xml
  <post>
  	<file name="/tmp/hello.log">
    HELLO
    </file>
  </post>
  ```

* This appends to a file called `/tmp/hello.log`.

  ```xml
  <post>
    <file name="/tmp/hello.log" mode="append">
    WORLD
    </file>
  </post>
  ```

* This creates a file called `/tmp/hello.log` with
  `chmod` permissions of 0400.

  ```xml
  <post>
    <file name="/tmp/hello.log" perms="0400">
    HELLO
    </file>
  </post>
  ```

* This creates a file called `/tmp/hello.log` owned by user
  root and group apache.

  ```xml
  <post>
    <file name="/tmp/hello.log" owner="root:apache">
    HELLO
    </file>
  </post>
  ```

##### `<boot>` tag
