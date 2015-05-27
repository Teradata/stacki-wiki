Stacki enables you to create a "distribution" which holds the pallets a
particular machine will use for its software configuration. The "default"
distribution consists of the "stacki" pallet and an OS pallet (Could be CentOS
or RHEL or any other RHEL variant). These two pallets are the minimal
requirement for installing a backend machine. Backend machines are assigned the
"default" distribution by design. 

You can create additional distributions by adding ISOs you have downloaded or
have created from a mirrored repository with the "stack create mirror" command.
Either way, the iso is recognized as a pallet which can be enabled for the
"default" distribution or enabled for a new distribution you have created. 

Machines can be assigned to a different distribution containing the software
required for a set of backend machines. Different machines can be assigned
different distributions. This gives you a great deal of latitude in deciding
how to structure your environment for OS, applications, and updates.

A few examples:

* Maintaining different versions of the OS:  
If you have installed with CentOS 6.5
and want to test on CentOS 6.6, add 6.6 as a pallet, create a new distribution,
assign machines to the new distribution and install/reinstall. The machine will
have an updated version of the OS.

* Maintaining updates:  
Pallets can be created by mirroring any publicly  available repo(or
subscribed repo if using RHEL). Adding an "updates" pallet to
any distribution will make available all updated RPMS using either yum (use the
command line to run yum update commands or reinstall.

* Maintaining dev/test/production environments:  
Again, having created dev, test,
and production distributions with the appropriate pallets, assign machines to
each of those distributions. Install/reinstall the machines. When you want to
promote machines to a new environment, reassign the machine's distribution and reinstall. 