# Installing Backend Nodes

After the frontend is up and running, the backend nodes
can be installed.

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
   ![insert-ethers-2](images/insert-ethers/insert-ethers-2.png)

3. Turn on the backend node, and wait for it to PXE Boot. Once the
   backend node sends out a PXE request, insert-ethers captures the
   request and adds it to the Stacki database.
   ![insert-ethers-4](images/insert-ethers/insert-ethers-4.png)

4. Once the backend node downloads its kickstart file, the
   insert-ethers UI indicates it using a ```*``` next to
   the host.
   ![insert-ethers-5](images/insert-ethers/insert-ethers-5.png)

### Host Spreadsheet
