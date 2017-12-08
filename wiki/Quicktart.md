## Quick Start Guide


The quickstart guide takes you through a frontend install with at least one backend.

It only uses the stackios minimal ISO. For more options, read the Frontend Installation documentation.

Follow this guide if you are:
* Kicking the tires.
* Starting a new cluster.
* Have never done this before.

Do not follow this guide if:
* You've done it many many times before. It's all just the same.
* You want Ubuntu or SLES. These are not currently supported on Stacki 5.0.
* You want CentOS/RHEL 6.x - not supported yet. (Really? 7.x beckons.)

### Default cluster install

Three steps:
1. Download the software
2. Install the frontend.
3. Install backend(s).

That's it.

Actually, I lied, it's four steps.

Don't do any of this if you haven't checked your machine/VM against the requirements.

If you ask for help, it's the first thing we're going to ask you, and you will sense our mockery in our Slack responses like a silent acid rain.

### 1. Check Requirements
Frontend:
* At least 4G of memory, especially for a VM.
* A least 100G of system disk.
* At least one network where backend machines can talk to frontend machines.
* The software.


### 2. (formerly 1.) Download the software

The current version is Stacki 5.0.

[stackios-5.0_20171128_b0ed4e3-redhat7.x86_64.disk1.iso](http://teradata-stacki.s3.amazonaws.com/release/stacki/5.x/stackios-5.0_20171128_b0ed4e3-redhat7.x86_64.disk1.iso) (md5: 06a32c320cf8ed546c01d6f5cbe9d31c)

Check the md5sum. Yeah, no, check the md5sum. Remember the silent acid rain of mockery.

### 3. (formerly 2.) Install the frontend.

Put the ISO in the DVD. This can be external, internal, or virtual media.

I proceed with pictures from a VirtualBox install. The actions are the same on bare metal or other virtual environments. If you can't extrapolate from one platform to the next, are you certain you have chosen the correct career?

I proceed with pictures.
