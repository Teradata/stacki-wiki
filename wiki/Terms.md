## Common Definitions

Stacki has the view that all server infrastructure is essentially a collection of clusters.
Where a cluster is any group of servers working in a single administration domain.
The servers may be interconnected clusters such as Hadoop or OpenStack, or may be
completely disconnected such as a web or application farm (e.g. Tomcat).
Stacki handles both cases with ease.
In addition, it contains many unique features that
make the management of highly interconnected clusters simple.

Below we introduce some of the main concepts of Stacki.

### Frontend

Stacki requires a single dedicated server that is used to build other
servers.
We call this server the **frontend**, and the servers it builds we call
**backend** nodes.

The Stacki frontend includes a configuration database coupled with software
repositories that are used to completely define backend node software
footprints (from OS kernel to application).
Backend nodes can be identical or completely unique hardware and software -
Stacki has been designed to dynamically install and configure heterogeneous
server environments.

### Kickstart/Autoyast/Preseed

Stacki is built on top of Red Hat's installation tool (known as: anaconda) and
dynamically creates kickstart files to install machines from bare
metal.

Additionally, we have made similar changes to Ubuntu preseed and SLES autoyast.
The installer speaks the appropriate installation language for the desired OS.
Because we use a framework built on top of native installation languages,
Stacki systems are managed at a much higher (and simpler) level
than systems using disk imaging or virtual machine images.
Seemingly complex actions such as swapping an OS between minor versions,
or updating a kernel, become trivial operations.
This is a consequence of managing a description of the
machine rather than the image of a machine.

### Parallel Installation

A single backend installation will download all the required
software packages from the frontend via HTTP.
While a backend is installing, it caches all downloaded packages and makes
them available to other installing backends, that is, all downloaded packages
can be shared.
This peer-to-peer package sharing is key to deploying systems at scale.
Without this feature, deploying several new backend servers could take you all
day, but with peer-to-peer package sharing, installation takes only minutes, and scales to 100s of machines.

### Pallets
A **pallet** is a set of software packages (repository). It is ingested as an ISO. This repository becomes available during and after installation to backend nodes. A pallet can contain: a) only packages (RPMS,DEBS), packages and configuration, or just configuration. We use [Stacki Universal XML](SUX) to define the configuration that takes place when installating an application.

### Carts
A **cart** is the fundamental unit of configuration. If you have site required packages or configuration or scripts to set-up. You put it in a cart. If you are testing a new application, use a cart. If you don't know what you are doing, start with a cart.

### Boxes
A **box** is a collection of pallets that serve as the package source during backend installation. It is also an installed host's primary YUM/ZYPPER/ repositories.

### Appliances

We use the term **appliance** to refer to a group of servers,
usually with related functionality.
The Stacki [pallet](#pallets--boxes) includes only the backend
appliance,
other pallets define additional appliance types. Appliances can be useful for segmenting hardware or application roles within your infrastructure. They are logical constructs and can be arbitrarily defined. If customization of the base appliance becomes unnecessarily complex for your organization, appliances are one way to reduce the complexity.

### Stacki Universal XML - SUX (but less than YAML)

The universal xml allows you to write html-like syntax for scripts, file creation, and commands during installation in the native installer language. You'll only have to write it once to be able to apply it to multiple OSs.

1. The XML files have access to the frontend's configuration database, so a single file can be customized for multiple different deployments.
2. The collection of XML files defines a complete kickstart/autoyast/preseed profile.

(Don't get all bungied about the XML thing. It's more like "HTML with extra tags," and those tags map to kickstart structure you should be familiar with: pre, post, main, packages etc. Might sound complex without an example, but it's easier than keeping track of dashes and spaces.)

### Attributes
One of the most useful items in the frontend's configuration database are **attributes**.
An attribute is a key-value pair that applies to a set of one or more hosts.
These values are the configuration data that SUX uses to build host-specific kickstart profiles.

The default installation has a set of attributes enabling the installation of a complete system via kickstart. Attributes can be changed. Arbitrary site specific attributes can be defined to customize kickstart for your site environment.
