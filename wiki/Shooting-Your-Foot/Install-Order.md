## Order of installation

The Stacki XML framework is called Stacki Universal XML. To explain how SUX
is structured, we first have to understand the process of
installation of a backend node.

### Order of Installation
When the network auto-installer (anaconda, autoyast, preseed) performs the OS installation, it does
it in the following order.

1.  **Hardware Probing** - The installer starts by probing the
    hardware and enumerates all the devices.

1.  **Network setup**  - The installer then configures the network with
    IP address, netmask, and gateway information

1.  **Kickstart/yast/preseed Retrieval** - The installer retrieves the auto-install file
    from the frontend that provides it with instructions on how
    to proceed with the installation.

1.  **Main section** - The installer configures timezones, root
    passwords, etc. This section typically includes Kickstart directives.

1.  **Pre section** - This section consists of instructions to be run
    before the partitioning, and package installation. This
    typically is used to setup the installer environment so that
    partitioning may be changed. This section is typically coded
    in shell, or python.

1. **Storage setup and build** - If a storage configuration has been set, the installer defines and implements the storage controller config on any supported controller card. (LSI)

1.  **Disk setup and partitioning** - Next, the installer configures the
    disks attached to the system, partitions them, formats them
    and makes them available to the installer.

1.  **Package Installation** - This section contains a list of
    packages to be installed on the system.

1.  **Post Section** - This section consists of instructions to be
    run after package installation. This section may be coded in
    any interpreted language that is available on the installed
    system.

1.  **Pre-boot Section** - This section is run on first-boot
    before any services or daemons are started.

1. **Post-Boot Section** - This section is a collection of shell
    scripts that are run on first-boot after all services and
    daemons have started. This is typically used to run scripts
    that interact with system daemons, or to finish and clean-up
    the installation process.

Please see the [Stacki Universal XML](Stacki-Universal-XML) for further explanation and examples.
