Stacki has the view that all server infrastructure is essentially a collection of clusters.
Where a cluster is any group of servers working in a single administration domain.
The servers may be interconnected clusters such as Hadoop or OpenStack, or may be
completely disconnected such as a web farm.
Stacki handles both cases with ease.
In addition, it contains many unique features that
make the management of highly interconnected clusters simple.

Below we introduce some of the main concepts of Stacki.

## Frontend

Stacki requires a single dedicated server that is used to build other
servers.
We call this server the **Frontend**, and the servers it builds we call
**Backend** nodes.

The Stacki Frontend includes a configuration database coupled with software
distributions that are used to completely define Backend node software
footprints (from OS kernel to application).
Backend nodes can be identical or completely unique hardware and software -
Stacki has been designed to dynamically install and configure heterogeneous
server environments.

## Kickstart 

Stacki is built on top of Red Hat's installation tool (known as: anaconda) and
dynamically creates Kickstart files to install machines from bare
metal.
Because we use a framework built on top of Kickstart,
Stacki systems are managed at a much higher (and simpler) level
than systems using disk imaging or virtual machine images. 
Seemingly complex actions such as swapping an OS between minor versions,
or updating a kernel, become trivial operations. 
This is a consequence of managing a description of the
machine rather than the image of a machine. 

## Parallel Installation

A single Backend installation will download all the required
software packages from the Frontend via HTTP.
While a Backend is installing, it caches all downloaded packages and makes
them available to other installing Backends, that is, all downloaded packages
can be shared.
This peer-to-peer package sharing is key to deploying systems at scale.
Without this feature, deploying several new Backend servers could take you all
day, but with peer-to-peer package sharing, installation takes only minutes.

## Appliances

We use the term **Appliance** to refer to a group of servers,
usually with related functionality.
The Stacki [Pallet](#pallets--distributions) includes only the Backend
Appliance,
other Pallets define additional Appliance types.

## Pallets & Distributions

A **Pallet** is a set of software packages and
[Wire](#wire) to specify how servers should be configured.
A **Distribution** is a composition of Pallets that can also serves as the source of packages during Backend installation and as an installed hosts primary Yum repository.

## Wire

We call the Stacki Kickstart framework **Wire**.
Wire is implemented in XML and looks like a collection of small Kickstart files.
The power comes from two ideas:

1. The XML files have access to the Frontend's configuration database, so a single file can be customized for multiple different deployments.
2. The collection of XML files defines a complete Kickstart profile.

## Attributes

One of the most useful items in the Frontend's configuration database are **Attributes**.
An Attribute is a key-value pair that applies to a set of one or more hosts.
These values are the configuration data that Wire uses to build host-specific Kickstart profiles.

