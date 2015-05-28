Stacki has the view that all server infrastructure is essentially a collection of clusters.
Where a cluster is any group of servers working in a single administration domain.
The servers may be an interconnected clusters such as Hadoop or OpenStack, or may be
completely disconnected such as a web farm.
Stacki handles both cases with ease, but contains many unique features that
make the management of highly interconnected clusters simple.

Below we introduce some of the main concepts that power stacki.

## Frontend

Stacki requires a single dedicated server that to build out other servers.
We call this server the **Frontend**, and the servers it builds **Backend** nodes.

The stacki Frontend includes a configuration database, and software distributions
that when combined completely define Backend node software footprints
(from OS kernel to application).
Backend nodes can be identical or completely unique hardware and software, this
is not an imaging tool, stacki implements software defined infrastructure.

> Code your datacenter.

## Kickstart 

The stacki installer is built on top of RedHat anaconda and
dynamically creates Kickstart files to install machines from bare
metal.
Because we use a framework built on top of kickstart,
stacki systems are managed at a much higher (and simpler) level
than systems using disk imaging or virtual machine images. 
Seemingly complex actions such as swapping an OS between minor versions,
or updating a kernel become trivial operations. 
This is a consequence of managing a description of the
machine rather than the image of a machine. 

## Parallel Installation

A single Backend kickstart will download (via http) all the required
software packages from the Frontend.
In addition to installation the downloaded packages the Backend will
cache the packages and serve them to other Backends just like the Frontend.
This peer-to-peer package sharing is key to depoloying systems at scale,
without this feature deploying 100 new Backend severs could take you all day.
With peer-to-peer installation this takes you minutes.

The combination of programmable infrastructure (from zero) and
rapid deployment (in parallel) is freedom.

## Appliances

We use the term **Appliance** to refer to a group of servers,
usually with related functionallity.
The stacki [Pallet](#pallets--distributions) include only the Backend Appliance,
other Pallets define additional Appliance types.

## Pallets & Distributions

A **Pallet** is a set of software packages and
[Wire](#wire) to specific how servers should install and configure the packages.
A **Distribution** is a composition of Pallets that can also serves as the source of packages during Backend installation and as an installed hosts primary Yum repository.

## Wire

We call the stacki Kickstart framework **Wire**.
Wire is implemented in XML and looks like a collection of small Kickstart files.
The power here comes from two ideas:

1. The XML files have access to the configuration database, so a single file can be applied in multiple situations (server, or even datacenters).
2. The wiring pattern of the XML files define a complete Kickstart profile.

## Attributes

One of the most useful items in the configuration database are **Attributes**.
An Attribute is a key-value pair that applies to a set of one or more hosts.
These values are the configuration data that Wire uses to build host-specific Kickstart profiles.

