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
software and services will need to be installed and
configured.

There are several “levels” of installing applications in Stacki,
we’re going to look at the simplest case. Assumptions are:

1. The application to be installed is available as an RPM
2. The application can be configured using simple shell command
   or a script.
3. The developer is has a basic knowledge of editing HTML-like syntax.

Stacki uses a collection of XML files that provide the definition
of a system, and the instructions for installing a backend node.
To extend the software footprint of a node, we will need to extend
the XML framework to accommodate the extra functionality
required.

The XML structure is not complicated - think of it as HTML with extra
tags. The tags Stacki incorporates, map to kickstart elements you 
should already be familiar with: pre, post, main, package. From there
it's mostly adding shell commands and scripts to install and configure
applications.

For more information about the available XML tags, refer to the
[Wire Reference Guide](Wire-Reference)

### Example

In this example, we will extend the backend appliance, by installing
the Apache web server and starting the service on the backend
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
5. After the distribution is created, verify the kickstart file will generate correctly. 
List the profile for one of the backend nodes to be installed. This is good
hygiene and saves troubleshooting steps later.

```
# stack list host profile backend-0-0
```

You should see no errors, and the last bit of output should look 
like this:

```
rm -f /tmp/ks-script*

__EOF__

]]>
</section>
</profile>
```

5. The ```stack list host profile``` gives you reasonable assurance backend nodes will 
   install. Set all the backend nodes
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
