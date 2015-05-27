<h1>Using the Stacki Installer</h1>

<h3>Step 1 - Cluster Information</h3>

The first screen will appear where you enter the <b>Name</b> of the frontend (head node), the <b>Fully Qualified Domain Name</b> (i.e. name.yourdomain.com) of your frontend, <b>Email</b> and <b>Timezone</b> of the cluster.

<h3>Step 2 - Public Network</h3>

Enter public network settings. First choose your <b>Public Network Device</b>.  This is the device that connects the frontend to the outside network.  Provide the <b>Public IP</b>, <b>Netmask</b> and <b>Public Gateway</b>.  Next provide <b>DNS Servers</b>, if more than one DNS Server you can type a comma separated list (i.e. 8.8.8.8, 4.2.2.2, 8.8.4.4).  Note that after clicking on "Next", the wizard will immediately set these credentials.

<h3>Step 3 - Private Network</h3>

Enter private network settings. Choose your <b>Private Network Device</b>.  This is the interface that connects your frontend to the compute nodes.  Then enter the <b>Private IP</b> and <b>Netmask</b>.

<h3>Step 4 - Password</h3>

Enter your <b>Password</b>.  This will be the root password to the frontend.


<h3>Step 5 - Choose Partition</h3>

Choose partition setup.  In automatic mode, the first disk will be partitioned in default manner of the OS.  In manual mode, a partition setup screen will appear for you to setup after you complete this wizard.

<h3>Step 6 - Add Pallets</h3>

Choose the </b>Pallets</b> you want to install.  If booting from a CD, pallets should automatically load onto the list for you to choose.  You can also load more pallets through a network by clicking on "Add Pallets" and providing the URL to the pallets server.  That will load the pallets as well.  The "Id" column will distinguish between pallets loaded from CD vs pallets from a network.

<h3>Step 7 - Review</h3>

Review your credentials and click "Install" to proceed.  This will complete the wizard installation process.