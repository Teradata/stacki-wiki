# Boot From CDROM

# Installation Wizard

## Cluster Information

The first screen will appear where you enter the _Name_ of the frontend (head node), the _Fully Qualified Domain Name_ (i.e., name.yourdomain.com) of your frontend, _Email_ and _Timezone_ of the cluster.

![](images/stacki_config_step_1b.png)

### Public Network

Enter public network settings. First choose your _Public Network Device_.  
This is the device that connects the frontend to the outside network.  
Provide the _Public IP_, _Netmask_ and _Public Gateway_.
Next provide _DNS Servers_, if more than one DNS Server you can type a comma separated list (i.e., 8.8.8.8, 4.2.2.2, 8.8.4.4).

Note that after clicking on "Next", the wizard will immediately set these credentials.

![](images/stacki_config_step_2b.png)

### Private Network

Enter private network settings. Choose your <i>Private Network Device</i>.  This is the interface that connects your frontend to the compute nodes.  Then enter the <i>Private IP</i> and <i>Netmask</i>.
<br /><br />
Note that after clicking on "Next", the wizard will immediately set these credentials.

![](https://github.com/StackIQ/stacki/wiki/images/stacki_config_step_3b.png)

### Password

Enter your <i>Password</i>.  This will be the root password of the frontend.

![](https://github.com/StackIQ/stacki/wiki/images/stacki_config_step_4.png)

### Choose Partition

Choose partition setup.  In <i>Automatic</i> mode, the first disk will be partitioned in default manner of the OS.  In <i>Manual</i> mode, a partition setup screen will appear for you to setup after you complete this wizard.

![](https://github.com/StackIQ/stacki/wiki/images/stacki_config_step_5.png)

### Add Pallets

Choose the <i>Pallets</i> you want to install.  If booting from a DVD, pallets should automatically load onto the list for you to choose.
<br /><br />In this case, we are not using a DVD and installing from a network.

![](https://github.com/StackIQ/stacki/wiki/images/stacki_config_step_6a.png)

You can also load more pallets through a network by clicking on "Add Pallets" and providing the URL to the pallets server.  This is another method to load pallets as well.

![](https://github.com/StackIQ/stacki/wiki/images/stacki_config_step_6c.png)

The "Id" column denotes pallets loaded from a DVD and the "Network" column denotes pallets from a network. Select all pallets you want to install.

![](https://github.com/StackIQ/stacki/wiki/images/stacki_config_step_6e.png)

### Review

Review your credentials and click "Install" to proceed.  This will complete the wizard installation process.

![](https://github.com/StackIQ/stacki/wiki/images/stacki_config_step_7.png)
