Stacki has the view that all server infrastructure is essentially a collection of clusters.
Where a cluster is any group of servers working in a single administration domain.
The servers may be interconnected clusters such as Hadoop or OpenStack, or may be
completely disconnected such as a web or application farm (e.g. Tomcat).
Stacki handles both cases with ease.
In addition, it contains many unique features that
make the management of highly interconnected clusters simple.

Below we introduce some of the main concepts of Stacki.

## Frontend

Stacki requires a single dedicated server that is used to build other
servers.
We call this server the **frontend**, and the servers it builds we call
**backend** nodes.

The Stacki frontend includes a configuration database coupled with software
distributions that are used to completely define backend node software
footprints (from OS kernel to application).
Backend nodes can be identical or completely unique hardware and software -
Stacki has been designed to dynamically install and configure heterogeneous
server environments.

## Kickstart 

Stacki is built on top of Red Hat's installation tool (known as: anaconda) and
dynamically creates kickstart files to install machines from bare
metal.
Because we use a framework built on top of kickstart,
Stacki systems are managed at a much higher (and simpler) level
than systems using disk imaging or virtual machine images. 
Seemingly complex actions such as swapping an OS between minor versions,
or updating a kernel, become trivial operations. 
This is a consequence of managing a description of the
machine rather than the image of a machine. 

## Parallel Installation

A single Backend installation will download all the required
software packages from the frontend via HTTP.
While a backend is installing, it caches all downloaded packages and makes
them available to other installing Backends, that is, all downloaded packages
can be shared.
This peer-to-peer package sharing is key to deploying systems at scale.
Without this feature, deploying several new backend servers could take you all
day, but with peer-to-peer package sharing, installation takes only minutes.

## Appliances

We use the term **appliance** to refer to a group of servers,
usually with related functionality.
The Stacki [pallet](#pallets--distributions) includes only the backend
appliance,
other pallets define additional appliance types. Appliances can be useful for segmenting hardware or application roles within your infrastructure. They are logical constructs and can be arbitrarily defined. If customization of the base appliance becomes unnecessarily complex for your organization, appliances are one way to reduce the complexity.

## Pallets & Distributions

A **pallet** is a set of software packages and
[Wire](#wire) to specify how servers should be configured.
A **distribution** is a composition of pallets that serves as the package source during backend installation. It is also an installed host's primary YUM repository.

## Wire

We call the Stacki kickstart framework **Wire**.
Wire is implemented in XML and looks like a collection of small kickstart files.
The power comes from two ideas:

1. The XML files have access to the frontend's configuration database, so a single file can be customized for multiple different deployments.
2. The collection of XML files defines a complete kickstart profile.

(Don't let XML freak you out. It's more like "HTML with extra tags," and those tags map to kickstart structure you should be familiar with: pre, post, main etc.)
 
## Attributes

One of the most useful items in the frontend's configuration database are **attributes**.
An attribute is a key-value pair that applies to a set of one or more hosts.
These values are the configuration data that Wire uses to build host-specific Kickstart profiles.

The default installation has a set of attributes enabling the installation of a complete system via kickstart. Attributes can be changed. Arbitrary site specific attributes can be defined to customize kickstart for your site environment.
