Stacki enables you to create a **Distribution** which holds the Pallets a
particular machine will use for its software configuration.
The _default_ Distribution consists of the _stacki_ and _OS_ pallets
(the OS pallet can be CentOS
or RHEL or any other RHEL variant in the 6.x series >= 6.5).
These two pallets are the minimal
requirement for installing a Backend machine.
Backend machines are assigned the _default_ distribution automatically.

You can create additional distributions by adding ISOs you have downloaded or
have created from a mirrored repository with the _stack create mirror_ command.
Either way, the ISO is recognized as a pallet which can be enabled for the
_default_ distribution or enabled for a new distribution you have created. 

Different machines can be assigned different Distributions.
This gives you a great deal of latitude in deciding
how to structure your environment for OS, applications, and updates.

A few examples:

* Maintaining different versions of the OS:

If you have installed with CentOS 6.5
and want to test on CentOS 6.6, add 6.6 as a Pallet, create a new Distribution,
assign machines to it, and install/reinstall.
The machine will have an updated version of the OS.

* Maintaining updates:

Pallets can be created by mirroring any publicly  available repo(or
subscribed repo if using RHEL).
Adding an _updates_ Pallet to any Distribution will make available to
Yum all updated RPMS.

* Maintaining dev/test/production environments:

Again, having created dev, test,
and production Distributions with the appropriate Pallets, assign machines to
each of those Distributions.
Install/reinstall the machines.
When you want to
promote machines to a new environment, reassign the machine's
Distribution and reinstall. 