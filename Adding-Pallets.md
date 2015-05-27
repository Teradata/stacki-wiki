Adding a pallet expands the range of software available to backend machines. Newer versions of the OS (6.6 vs. 6.5), different distributions (e.g. RedHat instead of CentOS), updated OS packages, application packages with a yum repository etc. can all be added as a pallet. Once a pallet is added and enabled, a backend machine can have the desired RPMS installed with either yum or install/reinstall of the machine. 

### Adding a pallet - simple case:

Let's presume we have a stacki frontend with just two pallets, "stacki" and CentOS v6.5. The stacki pallet and an OS pallet are the minimal pallets that will make up any given distribution. (See "Adding Distributions" in the sidebar for further discussion of distributions.)

List the pallets you currently have:

    stack list pallet

![](https://github.com/StackIQ/images/stack-list-pallet-1.png)