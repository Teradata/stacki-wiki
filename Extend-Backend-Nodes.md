Stacki allows the admin to customize the software
footprint of a backend node to enable additional
functionality.

In a default setup, stacki installs backend nodes with
a very small software footprint. In stacki parlance, the
backend node is brought up to
> a ping and a prompt

The backend node will have its network configured, and
the SSH daemon is started to allow login access from
the frontend.

To make the backend node more useful, other application
software, and services will need to be installed and
configured.

There are several “levels” of installing applications in stacki,
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
the Apache web server, and starting the service on the backend node.

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
   The new filename instructs stacki that this file will extend
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
   # stack create distro
   ```
4. After the distribution is recreated, set all the backend nodes
   to install. For more information about re-installing backend
   refer to the [Re-installation section](Backend-Installation#re-installation).

   ```
   # stack set host boot backend action=install
   ```
5. Reboot the backend nodes. This will boot the backend nodes into
   the stacki installer. Once the installation completes, the node
   will boot back up into a running state with the Apache web server
   running.
6. Verify that the Apache web server is running, using the command

   ```
   # stack run host backend command='service httpd status'
   ```

## Concepts

When the anaconda installer performs the OS installation, it does
it in the following order.

1. Hardware Probing
1. Network setup
1. Disk setup and partitioning
1. Pre section

#### XML Syntax
The stacki XML framework allows the following tags
1. `<pre>` - The `<pre>` tag is used to specify instructions
    to be run before the package installation section 
