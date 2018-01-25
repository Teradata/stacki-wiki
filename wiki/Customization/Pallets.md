## Pallets

Pallets are a fundamental unit of configuration in Stacki. They allow you to add additional software to install on backend nodes. Pallets provide a simple way to keep multiple versions or to do patching/upgrading.

All pallets come in ISO format. They can be pulled from the web for OS distributions, created from a local directory, or pulled remotely from a  yum/zypper repository by mirroring.

The default OS pallet that comes with stackios is a minimal CentOS distribution - designed to get you a basic frontend that installs basic backends. If you're looking for a minimal distribution, this is it.

If you have heavier software needs, additional software can be added in the form of pallets. Typically, the full CentOS distribution plus updates are added to a frontend to extend the software available. If you need the full CentOS/RHEL distribution pallet, follow [Adding OS Pallets](Adding-OS-Pallets).

You can also add other applications from a repository or from downloaded RPMS in a local directory tree. This is a nice feature because generally you get all the dependencies as well. Explore [Adding Software Pallets](Adding-Software-Pallets) for further details.

To understand the difference between Carts and Pallets please see [Carts vs. Pallets](Carts-vs-Pallets).
