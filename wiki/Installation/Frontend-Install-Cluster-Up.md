## Frontend install using Cluster Up

Stacki ships with a tool which can automatically provision a frontend in a VM using Vagrant and either VirtualBox or KVM.

**_IMPORTANT_**: It is very important that you supply the _stacki_ ISO and not the _stackios_ ISO.

## Quickstart
1. Make sure you have Vagrant installed and either VirtualBox or the vagrant-libvirt plugin.

2. Download the following files to the VM host machine:
    * **Stacki ISO**: [stacki-05.04.00.00-redhat7.x86_64.disk1.iso](https://github.com/Teradata/stacki/releases/download/stacki-05.04.00.00/stacki-05.04.00.00-redhat7.x86_64.disk1.iso)

    * **Cluster Up**:
    [cluster-up-05.04.00.00.tar.gz](https://github.com/Teradata/stacki/releases/download/stacki-05.04.00.00/cluster-up-05.04.00.00.tar.gz)

        **Note**: If you have a Stacki source repository locally, then you already have Cluster up in the `tools/cluster-up` folder.

3. Unpack the Cluster UP tarball on the VM host machine and change into the root folder of he project.

4. Run: `./cluster-up.sh PATH_TO_STACKI_ISO`

Cluster up has many features and options, which are explained in more detail here: https://github.com/Teradata/stacki/blob/master/tools/cluster-up/README.md
