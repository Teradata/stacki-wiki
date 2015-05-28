# Installing Backend Nodes

After the frontend is up and running, the backend nodes
can be installed.

## Hardware Requirements for a backend machine
* **Disk Capacity:** 100 GB
* **Memory Capacity:** 2 GB
* **Ethernet:** 1 physical port (e.g., "eth0")
* **BIOS Boot Order:** PXE (Network Boot), Hard Disk

Stacki gives the system administrator 2 choices of ways
to install backend nodes.

1. Discovery Mode
2. Spreadsheet Mode

### Discovery Mode
In discovery mode, a host that is unknown to the stacki frontend is discovered on the network, by an application called
**insert-ethers**.

1.  After the frontend is installed, on the command line, run
   ```
   # insert-ethers
   ```
   This will bring up the screen that shows a list of appliances
   available for installation. By default, there is only one appliance
   available in stacki - a **Backend** appliance.
   ![insert-ethers-1](images/insert-ethers/insert-ethers-1.png)

2. Select the **Backend** appliance, and hit `enter`. This brings
   up the following screen.
   ![insert-ethers-2](images/insert-ethers/insert-ethers-2.png)

3. Turn on the backend node, and wait for it to PXE Boot. Once the
   backend node sends out a PXE request, insert-ethers captures the
   request and adds it to the stacki database.
   ![insert-ethers-4](images/insert-ethers/insert-ethers-4.png)

4. Once the backend node downloads its kickstart file, the
   insert-ethers UI indicates it using a ```*``` next to
   the host.
   ![insert-ethers-5](images/insert-ethers/insert-ethers-5.png)

Repeat 3,4 for all backend machines in your cluster.

### Host Spreadsheet
Another feature of stacki is the ability to add compute
nodes to the system using CSV (Comma Separated Value) files.
The advantage of using CSV files, is that it gives fine-grained control over the
configuration of the cluster. The CSV files may be created in a program like Microsoft
Excel, or Google Docs spreadsheet application, and imported directly into the
stacki frontend.  
The Host CSV file needs to have the following headers:    


| NAME | APPLIANCE | RACK | RANK | IP | MAC | INTERFACE | SUBNET |  
|------|-----------|------|------|----|-----|-----------|--------|  

**Sample Host CSV file**

| NAME        | APPLIANCE | RACK | RANK | IP           | MAC               | INTERFACE | SUBNET  |  
|-------------|-----------|------|------|--------------|-------------------|-----------|---------| 
| backend-0-0 | backend   | 0    | 0    | 10.1.255.254 | 00:22:19:1c:0c:99 | eth0      | private |
| backend-0-1 | backend   | 0    | 1    | 10.1.255.255 | 00:22:19:1c:0c:98 | eth0      | private |
| backend-0-2 | backend   | 0    | 2    | 10.1.255.253 | 00:22:19:1c:0c:97 | eth0      | private |
| backend-0-3 | backend   | 0    | 3    | 10.1.255.252 | 00:22:19:1c:0c:96 | eth0      | private |
| backend-0-4 | backend   | 0    | 4    | 10.1.255.251 | 00:22:19:1c:0c:95 | eth0      | private |
| backend-0-5 | backend   | 0    | 5    | 10.1.255.250 | 00:22:19:1c:0c:94 | eth0      | private |

Once the CSV file is created, it can be added onto stacki frontend via the command line interface -  
1. Copy the CSV file onto the frontend  
2. Run the command:  

        # stack load hostfile file=hostfile.csv

Now when you run the below command, you will see that information about the backend machines has been loaded onto the frontend.

       # stack list host  

HOST | RACK | RANK | CPUS | APPLIANCE | DISTRIBUTION | RUNACTION | INSTALLACTION
-----|------|------|------|-----------|--------------|-----------|--------------
frontend-0-0 | 0 | 0 | 1 | frontend | default | os | install      
backend-0-0 | 0 | 0 | 1 | backend | default | os | install      
backend-0-2 | 0 | 2 | 1 | backend | default | os | install   
backend-0-3 | 0 | 3 | 1 | backend | default | os | install    
backend-0-4 | 0 | 4 | 1 | backend | default | os | install  
backend-0-5 | 0 | 5 | 1 | backend | default | os | install

Be default number of CPUS on every backend node is set to 1. This value will be updated automatically once
a backend node is reinstalled.

Now, we need to instruct the backend nodes to reinstall themselves on the next reboot.    

         # stack list host boot

HOST | ACTION
---- | ------
frontend-0-0: | ------
backend-0-5: | os  
backend-0-4: | os
backend-0-3: | os
backend-0-2: | os  
backend-0-1: | os
backend-0-0: | os

Here the boot action is set to _os_ indicating that the backend machines are currently set to boot off their
own hard disks. Let's update all _backend_ appliances so that they reinstall next time they powerup.   

       # stack set host boot backend action=install
       # stack list host boot

HOST | ACTION
---- | ------
frontend-0-0: | ------
backend-0-5: | install  
backend-0-4: | install 
backend-0-3: | install 
backend-0-2: | install   
backend-0-1: | install 
backend-0-0: | install 

Now, power up the backend machines. Once these machines come up, your cluster is ready for use!