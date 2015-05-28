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

Enter private network settings. Choose your _Private Network Device_.
This is the interface that connects your frontend to the compute
nodes.
Then enter the _Private IP_ and _Netmask_.

Note that after clicking on "Next", the wizard will immediately set these credentials.

![](images/stacki_config_step_3b.png)

### Password

Enter your _Password_.
This will be the root password of the frontend.

![](images/stacki_config_step_4.png)

### Choose Partition

Choose partition setup.
In _Automatic_ mode, the first disk will be partitioned in default
manner of the OS.
In _Manual_ mode, a partition setup screen will appear for you to setup after you complete this wizard.

![](images/stacki_config_step_5.png)

### Add Pallets

Choose the _Pallets_ you want to install.
If booting from a DVD, pallets should automatically load onto the list for you to choose.

In this case, we are not using a DVD and installing from a network.

![](images/stacki_config_step_6a.png)

You can also load more pallets through a network by clicking on "Add Pallets" and providing the URL to the pallets server.
This is another method to load pallets as well.

![](images/stacki_config_step_6c.png)

The "Id" column denotes pallets loaded from a DVD and the "Network" column denotes pallets from a network.
Select all pallets you want to install.

![](images/stacki_config_step_6e.png)

### Review

Review your credentials and click "Install" to proceed.  This will complete the wizard installation process.

![](images/stacki_config_step_7.png)
