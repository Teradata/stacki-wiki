## Changing the IP address space across a Cluster.

### Save existing network information
1. Dump the hostfile
   
   ```
   # stack report hostfile > stacki.hosts.csv
   ```

2. Dump /etc/hosts
   
   ```
   # stack report host > hosts.stacki
   ```
3. Dump network config

   ```
   # stack report networkfile > networks.stacki
   ```

### Change CSV Files

1. Open network file, and add a new line. Change the file from

   ```csv
   NETWORK,ADDRESS,MASK,GATEWAY,MTU,ZONE,DNS,PXE
   private,192.168.16.0,255.255.240.0,192.168.16.1,1500,stacki.com,False,True
   ```
   
   to

   ```csv
   NETWORK,ADDRESS,MASK,GATEWAY,MTU,ZONE,DNS,PXE
   private,10.2.0.0,255.255.255.0,10.2.0.1,1500,stacki.com,False,True
   oldprivate,192.168.16.0,255.255.240.0,192.168.16.1,1500,stacki.com,False,False
   ```

   Note that this moved original **private** to **oldprivate**.
   The private line now contains new network information,
   including new Address, Mask, and Gateway

1. Open `hosts.csv` file, and change the IP addresses of the hosts
from original to new. 

## Apply the change

1. Import the `network.csv` file into the database

   ```sh
   # stack load networkfile file=networks.csv
   ```

1. Import the `hosts.csv` file.

   ```sh
   # stack load hostfile file=hosts.csv
   	```
   	This might throw out an error message
   saying
   > **error** - host **frontend** is not in cluster
  
   This error occurs because of a mismatch between IP address
   recorded in the database, and IP address of the NIC itself.
   It's OK to ignore this error message for now.

1. Open the /etc/hosts file.

   You should see old IP addresses for all hosts. This is
   currently showing incorrect information since, all the
   hosts still have their old networking information.
   > **NOTE**<br>
   > During a switch-over of IP addresses, there will be
   > many instances where the information in the database,
   > will be inconsistent with information in the `/etc/hosts`
   > file, which in turn will be inconsistent with the status
   > of the nodes. This might cause network connectivity  issues.


1. The /etc/hosts file has old IP addresses for all hosts.
   Move this to another location.
1. Copy over the ORIGINAL /etc/hosts file that was backed up.
1. In this file, change only the IP address of the frontend
   to the new IP address. Leave all the others IP addresses
   still pointing to the old IP addresses.
   > **NOTE**<br>
   > This is required for the `stack` command line
   > to function correctly.
 
   Copy this version of `/etc/hosts` file to a safe location.
   this will need to be used again. Call it `/tmp/etc.hosts.unstable`
   
1. Next, change the networking files on the backend nodes.
   
   ```sh
   # stack sync host network backend restart=no
   ```
   
   This will change all networking files on the backend nodes,
   but will not restart the networking.
   
   > This means that the networking files, such as
   > `/etc/sysconfig/network`, `/etc/sysconfig/network-scripts/ifcfg-*`
   > files have information in them, that is inconsistent
   > with the running configuration of the hosts.

1. The previous step will have rewritten the `/etc/hosts` file.
   Copy over the `/tmp/etc.hosts.unstable` file back to `/etc/hosts`
1. Reset the networking of all hosts, by running

   ```sh
   # stack run host backend command="service network restart"
   ```

   This will change the IP address of backend hosts, and the
   command will lose connectivity, and will not return.
   After about a minute, hit `Ctrl-C` to kill the `stack run host`
   command.

1. Reset the networking for the frontend.
   > **IMPORTANT**<br>
   > Make sure that you have console access
   > to the frontend. Do not run these commands over SSH.
   > You will lose connectivity.

   ```sh
   # stack sync host network <frontend> restart=no
   # service network restart
   ```

1. Reset the bootactions of all hosts.

   ```sh
   # stack set host boot backend action=os
   # stack sync config
   # stack sync host config
   ```

1. Your networks, for backends and the frontend, should
   be fully configured, and accessible over the new IP space.
1. Test to see if you have connectivity between frontend and
   backend hosts
1. Test to see if you have connectivity to the frontend from
   an external host.
