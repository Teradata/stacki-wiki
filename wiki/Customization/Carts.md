**Carts** are the smallest increment of customization for backend nodes.

Stacki allows the admin to customize the software
footprint of a backend node to enable additional
functionality.

In a default setup, Stacki installs backend nodes with
a very small software footprint. In Stacki parlance, the
backend node is brought up to **a ping and a prompt**.

The backend node will have its network configured, and
the SSH daemon is started to allow password-less login access from
the frontend.

To make the backend node more useful, other application
software and services will need to be installed and
configured.

There are several "levels" of installing applications in Stacki.
We’re going to look at the simplest case - using a cart to install additional package(s) and starting the associated service.

Assumptions are:

1. The application to be installed is available as an RPM
2. The application can be configured using simple shell command
   or a script.
3. The developer has a basic knowledge of editing HTML-like syntax.

Stacki uses a collection of XML files that provide the definition
of a system, and the instructions for installing a backend node.
To extend the software footprint of a node, we will need to extend
the XML framework to accommodate the extra functionality
required.

The XML structure is not complicated - think of it as HTML with extra
tags. The tags Stacki incorporates, map to kickstart elements you
should already be familiar with: pre, post, main, package, and first boot. From there it's mostly adding shell commands and scripts to install and configure applications.

For more information about the available XML tags, refer to the
[Stacki Universal XML guide](SUX)

In Stacki, backend node configuration is controlled by a collection of XML
files.

A *node XML file* contains the description of additional packages and
configuration that should be applied to backend hosts.

A *node XML file* is written in [Stacki Universal Language](SUX), which is a way to write cart configuration so it applies to multiple OSs.

SUX consists of html tags that map to Linux installation targets: pre, post, main, packages, and first boot.

Seeing how this works is best done through examples. The two most common use cases are, adding software and configuring that same software.

Follow these two examples in order to get started with **Adding Carts**

* [Adding RPMS](Adding-RPMS)
* [Adding Files](Adding-Files)
* [Adding Installation Scripts](Adding-Scripts)

You can change the default Stacki install configuration by extending or replacing what is provided. Take a look at [Extending and Replacing Stacki XML](Extending-Replacing-Stacki-XML)
