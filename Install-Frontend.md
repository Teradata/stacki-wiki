<h2>Using the Stacki Installer</h2>

<h3>Step 1 - Cluster Information</h3>

The first screen will appear where you enter the <i>Name</i> of the frontend (head node), the <i>Fully Qualified Domain Name</i> (i.e., name.yourdomain.com) of your frontend, <i>Email</i> and <i>Timezone</i> of the cluster.

![](https://github.com/StackIQ/stacki/wiki/images/stacki_config_step_1b.png)

<h3>Step 2 - Public Network</h3>

Enter public network settings. First choose your <i>Public Network Device</i>.  This is the device that connects the frontend to the outside network.  Provide the <i>Public IP</i>, <i>Netmask</i> and <i>Public Gateway</i>.  Next provide <i>DNS Servers</i>, if more than one DNS Server you can type a comma separated list (i.e., 8.8.8.8, 4.2.2.2, 8.8.4.4).
<br /><br />
Note that after clicking on "Next", the wizard will immediately set these credentials.

![](https://github.com/StackIQ/stacki/wiki/images/stacki_config_step_2b.png)

<h3>Step 3 - Private Network</h3>

Enter private network settings. Choose your <i>Private Network Device</i>.  This is the interface that connects your frontend to the compute nodes.  Then enter the <i>Private IP</i> and <i>Netmask</i>.
<br /><br />
Note that after clicking on "Next", the wizard will immediately set these credentials.

![](https://github.com/StackIQ/stacki/wiki/images/stacki_config_step_3b.png)

<h3>Step 4 - Password</h3>

Enter your <i>Password</i>.  This will be the root password of the frontend.

![](https://github.com/StackIQ/stacki/wiki/images/stacki_config_step_4.png)

<h3>Step 5 - Choose Partition</h3>

Choose partition setup.  In <i>Automatic</i> mode, the first disk will be partitioned in default manner of the OS.  In <i>Manual</i> mode, a partition setup screen will appear for you to setup after you complete this wizard.

![](https://github.com/StackIQ/stacki/wiki/images/stacki_config_step_5.png)

<h3>Step 6 - Add Pallets</h3>

Choose the <i>Pallets</i> you want to install.  If booting from a DVD, pallets should automatically load onto the list for you to choose.  You can also load more pallets through a network by clicking on "Add Pallets" and providing the URL to the pallets server.  That will load the pallets as well.  The "Id" column will distinguish between pallets loaded from DVD vs pallets from a network.

<h3>Step 7 - Review</h3>

Review your credentials and click "Install" to proceed.  This will complete the wizard installation process.