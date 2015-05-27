<h1>Using the Stacki Installer</h1>

<h3>Step 1 - Cluster Information</h3>

The first screen will appear where you enter the name of the frontend (head node), the URL of your frontend, email and timezone of the cluster.

<h3>Step 2 - Public Network</h3>

Enter public network settings. First choose your public network device.  This is the device that connects the frontend to the outside network.  Provide the IP, Netmask and Public Gateway.  Provide DNS Servers.  If more than one DNS Server, you can provide a comma separated list such as (8.8.8.8, 1.1.1.1, 3.3.3.3)

<h3>Step 3 - Private Network</h3>

Enter private network settings. Next choose your private network device.  This is the interface that connects your frontend to the compute nodes.

<h3>Step 4 - Password</h3>

Enter your password.  This will be the root password to the frontend.


<h3>Step 5 - Choose Partition</h3>

Choose partition setup.  In automatic mode, the first disk will be partition in default manner.  In manual mode, a partition setup screen will appear for you to setup after you complete this wizard.

<h3>Step 6 - Add Pallets</h3>

Choose the pallets you want to install.  If booting from a CD, pallets should automatically load onto the list for you to choose.  You can also load more pallets through a network by clicking on Add Pallets and providing the URL to the pallets server.  That will load the pallets as well.  The Id column will distinguish between pallets loaded from CD vs pallets from a network fi they are the same name.

<h3>Step 7 - Review</h3>

Review your credentials and click install to proceed.  This will complete the installation process.