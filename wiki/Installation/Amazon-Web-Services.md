## Amazon Web Services

NOTE: This section is describing an unreleased feature of Stacki. The code isn't even on our git master branch. It works, it's cool, but it isn't released yet.

Stacki can also be installed inside Amazon EC2, and behaves very similar to standard bare-metal deployments. This guide assumes you already have an AWS account and are familiar with the AWS console or command line tools. You will need to know how to start instances and how to modify there settings (specifically the user data).

Stacki uses EBS volumes and HVM so the cloud environment is nearly identical to bare-metal. You can start and stop instances without data loss, you can even re-install backends the same way you do for bare-metal.

The following table show the AMI's that are required.

| OS     | Frontend     | Backend      |
|:-------|:-------------|:-------------|
| CentOS | ami-674a451d | ami-3e436044 |
| SLES   | ami-94507dee | ami-3e436044 |

Note: the SLES Frontend AMI is not publicly available. The Backend AMIs are identical are derived from the Amazon Linux AMI.

## Frontend

Start a new instance of the Stacki Frontend AMI, for starting out we recommend the `t2.xlarge` instance type. Make sure to associate your SSH key with it or you will never be able to log in. The `root` account will be configured to accept your SSH key.

When the new Frontend starts it will spend several minutes completing the Stacki installation, so it may be up to 5 minutes after starting before you can log in. During this time the SSH service is running but it will not accept your key until after the installation completes.

Once the Frontend is up and you can SSH in, you can start adding hosts.

## Backends

Start as many instances of the Stacki Backend AMI as needed, for starting out we recommend the `t2.large` instance type. Again you must associate your SSH key with the instance(s). You must also provide `user data` for each instance, this is how the new instances know where the Frontend is and can start the native operating system provisioner.  This `user data` is a json structure:

```
{ "master" : "ipaddress of frontend" }
```

You can also specify the appliance type by adding `"appliance" : "backend"` to this structure (replace backend with your appliance). If nothing is specified the instance will install as a backend.

Because the instance is going to completely re-provision itself you can increase the disk size of the instance from the default size of the Backend AMI for more storage.

When the instance starts it will contact the Frontend to register intself and request profile. The Frontend will add the host (it will show up in `stack list host`) and the instance will install itself. At this point forward the installation looks just like bare-metal. When the installation is complete the instance will reboot, and you can log in over the private network or over the WAN using for SSH key.

## What Next

Right now that's it. The goal here is to be as bare-metally as possible. Future directions may include using the Frontend to control AWS, but right now it doesn't even know it is running in the Cloud.
