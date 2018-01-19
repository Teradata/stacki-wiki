Stacki AWS support is included in the source tree. This procedure documents how we go from built Stacki source to a new Frontend and Backend AMI.

## Frontend AMI

### Launch a Frontend

Follow the [Instructions](Amazon-Web-Services) for starting a new Stacki Frontend in AWS. Once the instance is up copy over a new Stacki ISO (or just [Build](Building-From-Source) a new one). Next disable the existing Stacki pallet and enable the new one.

### Launch a Barnacle

We use the Barnacle appliance to create a new Frontend AMI, to do this following the [Instructions](Amazon-Web-Services) for starting a Backend instance and supply the extra appliance information in the json `user data`.  For example:

```
{
  "master"    : "172.0.0.1",
  "appliance" : "barnacle"
}
```

### Prep the Instance

Once the Barnacle instance is finished installing login and prepare the instance.

```
# /opt/stack/sbin/aws-barnacle-prep-image
```

This command will remove any SSH keys, enable a barnacle service to run on next boot, and will shutdown the instance.

### Register the AMI

Register a new AMI using the shutdown Barnacle instance as the source. For CentOS make sure the AMI is public, but for SLES keep the AMI private.

## Backend AMI

The Backend AMI should rarely need to be updated. It is based on the Amazon Linux AMI with a single Stacki package added. To refresh the AMI launch the existing Backend AMI but do not supply any `user data`. The instance will start and you can SSH into it as the `ec2-user` using your AWS SSH credentials.  From here do the following:

* install the `stack-aws-client` RPM
* `rm -rf ~/ec2-user/.ssh` to remove your credentials
* shutdown the instance
* register the instance as an AMI and make it public

The only reason to do this is if the `stack-aws-client` code has significantly changed. Also note the Backend is not operating system dependent, all it does is configure grub to trigger our registration and installation code.
