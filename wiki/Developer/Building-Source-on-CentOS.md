# Building stacki on a vanilla CentOS machine.

## Requirements
1.  Git
1.  The following yum groups are required
    * Additional Development
    * Compatibility libraries
    * Development tools
    * Server Platform Development
    * Web Server

## Building

### Checkout the git repository
Checkout the Stacki repository from github.com. It is about
1.6 GB in size. To build the repo, youll need another 12 GB
of usable space.

```
# mkdir /export/src
# cd /export/src
# git clone git@github.com:StackIQ/stacki.git
```

### Bootstrap
1. Run Bootstrap
    ```
    # cd /export/src/stacki
    # make bootstrap
    ```
1. Remove the src/order-stacki.mk file
    ```
    # rm src/order-stacki.mk
    ```
1. Source /etc/profile.d/stack-build.sh file
    ```
    # source /etc/profile.d/stack-build.sh
    ```
1.  Make RPMS for all packages
    ```
    # make -C src rpm 
    ```
    > **Note**: This step will take a very long time.
    > Some packages may fail to build. This is OK,
    > since we're still in the bootstrap stage.

1. The above command will create a build directory and place
   all the built RPMS in it. The next step is to create a
   yum-compatible repository.
   ```
   # createrepo build-stacki-master/RPMS
   ```

1. Write `/etc/yum.repos.d/buildstacki.repo` file with the following content.
    ```
    [buildstacki]
    name=Build Stacki
    baseurl=file:///export/src/stacki/build-stacki-master/RPMS/
    enabled=1
    gpgcheck=0
    ```

1. Refresh yum information
    ```
    # yum clean all
    # yum makecache all
    ```

1. Install the stack-wizard package. This will allow us to create a site.attrs file
   that may then be used to create the frontend installation file
   ```
   # yum install -y stack-wizard foundation-redhat foundation-py-ipaddress
   ```

1. Create /tmp/site.attrs file by running the wizard
   ```
   # boss_config_snack.py --no-net-reconfig
   ```
   > **Note**: For information on how to configure your stacki installation,
     refer to [Installation Wizard](Frontend-Installation#installation-wizard)

1. Create the installation script
    ```
    # stack list node xml server basedir=. attrs=/tmp/site.attrs | \
      stack list host profile chapter=bash profile=shell > /tmp/frontend.sh
    ```
1. Run /tmp/frontend.sh
   ```
   # sh -x /tmp/frontend.sh 2>&1 | tee /tmp/frontend-install.log
   ```
1. At this point, the frontend should have the Stacki database running,
   and the frontend should be added to the database. Reboot the machine
   ```
   # reboot
   ```

### Add OS pallets
1. Download the CentOS DVDs.
   **Note**:
   1. For CentOS 7, download the CentOS-7 everything ISO
   1. For CentOS 6, download the CentOS-6 Bin DVD1 and DVD2 ISO files

1. Add the ISO to the machine
    ```
    # stack add pallet CentOS-*.iso
    # stack enable pallet CentOS
    ```

### Rebuild the Stacki Pallet
```
# cd /export/src/stacki
# make roll
```
