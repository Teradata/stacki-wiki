## Changing the IP address space across a Cluster.

Reinstalling a frontend to change the private network is a *Stacki best practice*. The procedure you are now reading is a *Stacki non-best practice* and is documented to make you go away.

You've been warned, but you persist in wanting what you want. You should know changing the private network on a frontend can raise the level of uncertainty about the validity of your configuration. If that is acceptable to you, then do the following. If it's not acceptable, reinstall the frontend.

### Save existing network information
1. Dump the hostfile

   ```
   # stack report hostfile > stacki.hosts.csv
   ```

1. Dump /etc/hosts

   ```
   # stack report host > hosts.stacki
   ```
1. Dump network config

   ```
   # stack report networkfile > networks.stacki
   ```

### Change CSV Files

1. Open network file, and add a new line. Change the file from

   ```
   NETWORK,ADDRESS,MASK,GATEWAY,MTU,ZONE,DNS,PXE
   private,192.168.16.0,255.255.240.0,192.168.16.1,1500,stacki.com,False,True
   ```

   to

   ```
   NETWORK,ADDRESS,MASK,GATEWAY,MTU,ZONE,DNS,PXE
   private,10.2.0.0,255.255.255.0,10.2.0.1,1500,stacki.com,False,True
   oldprivate,192.168.16.0,255.255.240.0,192.168.16.1,1500,stacki.com,False,False
   ```

   Note that this moved original **private** to **oldprivate**.
   The private line now contains new network information,
   including new Address, Mask, and Gateway

1. Open `hosts.csv` file, and change the IP addresses of the hosts
from original to new subnet addresses.

## Apply the change

1. Import the `network.csv` file into the database

   ```
   # stack load networkfile file=networks.csv
   ```

1. Import the `hosts.csv` file.

  ```
  # stack load hostfile file=hosts.csv
  ```

  This might throw out an error message saying:
   > **error** - host **frontend** is not in cluster

   This error occurs because of a mismatch between the IP address
   recorded in the database, and the IP address of the NIC itself.
   It's OK to ignore this error message for now.

3. Open the /etc/hosts file.

   You should see old IP addresses for all hosts. This is
   currently showing incorrect information since, all the
   hosts still have their old networking information.
   > **NOTE**<br>
   > During a switch-over of IP addresses, there will be
   > many instances where the information in the database,
   > will be inconsistent with information in the `/etc/hosts`
   > file, which in turn will be inconsistent with the status
   > of the nodes. This might cause network connectivity  issues.

We want to make changes to the active backend hosts that currently have new IP addresses in the database, but old IP addresses on all of their nics.

Copy over the ORIGINAL /etc/hosts file that was backed up to /etc/hosts.

```# cp hosts.orig /etc/hosts```


1. In /etc/hosts, change  the IP address of the frontend
   to the new IP address. Leave all the others IP addresses
   still pointing to the old IP addresses.
   > **NOTE**<br>
   > This is required for the `stack` command line
   > to function correctly.

   Copy this version of `/etc/hosts` file to a safe location.
   this will need to be used again. Call it `/tmp/etc.hosts.unstable`

1. Next, change the networking files on the backend nodes.

   ```
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
1. Reset the networking of all hosts.

   If you have console access to all backend hosts, instead of
   running the `stack run host` command, log into each hosts'
   console, and run

   ```
   # systemctl network restart
   ```
(Though this takes much longer than using a `stack run command.`)

   If you don't have console access to the hosts, or if you
   have a large number of hosts, you can try to run the
   following:

   ```
   # stack run host backend command="systemctl restart network"
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

```
# stack report host resolv a:frontend | stack report script | bash
# stack report host interface a:frontend | stack report script | bash
# stack report host network a:frontend | stack report script | bash

Fix the attributes you just broke, using the new ip you've assigned the frontend.

# stack set attr attr=Kickstart_PrivateDNSServers attr=172.16.20.1,8.8.8.8
# stack set attr attr=Kickstart_PrivateGateway attr=172.16.20.1
# stack set attr attr=Kickstart_PrivateNTPHost attr=172.16.20.1
```

Reboot your frontend. No, really, reboot your frontend. Too many services.

1. Your networks, for backends and the frontend, should
   be fully configured, and accessible over the new IP space
1. There should be a status of "up" on all nodes in a `stack list host.`
1. Test to see if you have connectivity between frontend and
   backend hosts
1. Test to see if you have connectivity to the frontend from
   an external host.
