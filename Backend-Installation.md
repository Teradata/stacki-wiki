# Installing Backend Nodes

After the frontend is up and running, the backend nodes
can be installed.

The minimum requirements for backend nodes are -

Resource | Capacity
-------- | --------
System RAM | 1 GB
Network Interfaces | 1 (PXE-Capable)
Hard Drive | 40 GB

For production systems, the recommended configuration
for backend nodes are -

Resource | Capacity
-------- | --------
System RAM | 16 GB or more
Network Interfaces | 1 or More (PXE-Capable)
Hard Drive | 200 GB or more

An additional requirement is that the backend nodes must
be setup in the BIOS have the following boot order.
1. PXE Boot
2. CD/DVD Device (Optional - Only if device is present)
3. Hard Drive

Stacki gives the system administrator 2 choices of ways
to install backend nodes.

1. Discovery Mode
2. Spreadsheet Mode

### Discovery Mode
In discovery mode, a host that is unknown to the cluster
manager is discovered on the network, by an app called
**insert-ethers**.

1.  After the frontend is installed, on the command line, run
   ```
   # insert-ethers
   ```
   This will bring up the screen that shows a list of appliances
   available for installation. By default, there is only one appliance
   available in Stacki - a **backend** appliance.
   ![insert-ethers-1](images/insert-ethers/insert-ethers-1.png)

2. Select the **Backend** appliance, and hit `enter`. This brings
   up the following screen.
   ![insert-ethers-2](http://github.com/StackIQ/stacki/wiki/images/insert-ethers/insert-ethers-2.png)

3. Turn on the backend node, and wait for it to PXE Boot. Once the
   backend node sends out a PXE request, insert-ethers captures the
   request and adds it to the Stacki database.
   ![insert-ethers-4](http://github.com/StackIQ/stacki/wiki/images/insert-ethers/insert-ethers-4.png)

4. Once the backend node downloads its kickstart file, the
   insert-ethers UI indicates it using a ```*``` next to
   the host.
   ![insert-ethers-5](http://github.com/StackIQ/stacki/wiki/images/insert-ethers/insert-ethers-5.png)

### Host Spreadsheet
