## Frontend Installation Basics

Stacki requires a single server that will host all
the software and services used to build out other servers. We
call this server the **frontend**, and the first step to running
Stacki is to build a frontend.

The process is fairly simple and looks similar to a standard Linux
build with the addition of a wizard to capture site-specific
networking information.

### Requirements

A frontend has the following hardware requirements

| Resource           | Minimum | Recommended |
|:-------------------|:--------|:------------|
| System Memory      | 8 GB    | 16 GB       |
| Network Interfaces | 1       | 1           |
| Disk Capacity      | 100 GB  | 200 GB      |
| CD/DVD Device      | 1       | 1           |

BIOS _boot order_

1. CD/DVD Device
2. Hard Disk
3. Not PXE!

In the simplest configuration, Stacki assumes a single network for all
servers. Stacki refers to the single network as the _private_ network,
and often this will be an isolated network.
This default setup in shown below.

![](images/cluster-architecture-network.png)

The private network cannot have another DHCP server that would answer
a DHCP request from a backend server. The frontend provides DHCP
services on the private network, and any additional DHCP server
would cause conflicts on the network. (Two+ DHCP servers can co-exist if the Stacki frontend answers ONLY for the backend nodes on the shared subnet and the other DHCP server(s) does not.)

### New or Existing

The Stacki frontend runs on top of a CentOS/RHEL flavored 7.6 base.

You have three options:

#### Building on new server

  If you don't have an already existing vanilla CentOS or RedHat 7.6 system, build a new server from bare metal with Stacki and the required CentOS bits (which we call "stackios").

  Follow the [Frontend Install - New](Frontend-Install-New) doc.

  You can also install a frontend by:

  * [Creating and using a "jumbo" pallet](Create-Jumbo-Pallets)


#### Building on an existing server

  If you wish to install Stacki on top of an existing vanilla CentOS or RedHat 7.6 system, follow the document labeled [Frontend Install - Existing](Frontend-Install-Existing).

#### Building in a VM using Cluster Up

  Stacki includes a tool called Cluster Up that can install a frontend in a VirtualBox or KVM VM, in a completely automated fashion. Follow the document labeled [Frontend Install - Cluster Up](Frontend-Install-Cluster-Up).

This procedure works for any CentOS/RHEL system including Oracle and Scientific Linux.
