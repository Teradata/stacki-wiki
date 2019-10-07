## Quickstart

The quickstart guide takes you through a frontend install with at least one backend.

It only uses the stackios minimal ISO. For more options, read the Frontend Installation documentation.

Follow this guide if you are:
* Kicking the tires.
* Starting a new cluster.
* Have never done this before.

Do not follow this guide if:
1. You've done it many many times before. It's all just the same.
2. You want Ubuntu or SLES. These are not currently supported on Stacki 5.0.
3. You want CentOS/RHEL 6.x - not supported yet. (Really? 7.x beckons.)

(If you really, really, really...really, need 2 or 3, use [Stacki-4.0](https://github.com/Teradata/stacki-documentation-4.x/wiki).

## Default cluster install

Three steps:
1. Download the software
2. Install the frontend.
3. Install backend(s).

That's it.

Actually, I lied, it's four steps.

Don't do any of this if you haven't checked your machine/VM against the requirements.

If you ask for help, it's the first thing we're going to ask you, and you will sense the silent acid rain of mockery in our Slack responses.

## 1. Check Requirements
Frontend:
* At least 4G of memory, especially for a VM.
* A least 100G of system disk.
* At least one network where backend machines can talk to frontend machines.
* The software.

Backend:
* At least 4G of memory.
* At least 80G system disk.
* At least one network that talks to the frontend.
* PXE first!

## 2. Download the software (formerly Step 1)

The current version is Stacki 5.0.

[stackios-5.0_20171128_b0ed4e3-redhat7.x86_64.disk1.iso](http://teradata-stacki.s3.amazonaws.com/release/stacki/5.x/stackios-5.0_20171128_b0ed4e3-redhat7.x86_64.disk1.iso) (md5: 06a32c320cf8ed546c01d6f5cbe9d31c)

Check the md5sum. Yeah, no, check the md5sum. Remember, silent acid rain of mockery.

## 3. Install the frontend (formerly Step 2)

Burn the ISO to a DVD or USB. Then put the just burned DVD into an external, internal, or virtual DVD drive.

I proceed with pictures from a VirtualBox install. The actions are the same on bare metal or other virtual environments. If you can't extrapolate from one platform to the next, are you certain you have chosen the correct career?

This is just an average CentOS/RHEL install. Nothing new here.

Put the DVD in and boot it. Pick the first option if you have a DVD. The second if you're using a USB

![frontend_install_vbox_3](images/frontend/frontend_install_vbox_3.png)


It will bring you to choose your Timezone. So do that and hit Continue.

![frontend_install_vbox_8](images/frontend/frontend_install_vbox_8.png)

The next screen is network set-up. Input the information for the network that the frontend and backend share. After installation, you can add more networks and interfaces.

_**Do not get this network wrong! Changing it after the fact means a RE-INSTALL of the frontend.**_

![frontend_install_vbox_10](images/frontend/frontend_install_vbox_10.png)

Choose a password, but better than the one in this png. Seriously, your career will thank me later.

![frontend_install_vbox_11](images/frontend/frontend_install_vbox_11.png)

Partitioning is next. If you've never done this, choose "Automated." If you have site requirements, choose "Manual" and go through the CentOS/RHEL 7.x partitioning screens.

![frontend_install_vbox_12](images/frontend/frontend_install_vbox_12.png)

Pallets to Install. Make sure there's a '*' next to each of those. Don't deselect either of them, you won't get an installed frontend.

![frontend_install_vbox_13](images/frontend/frontend_install_vbox_13.png)

Summary. Make sure it's good. If it's not, go back and fix it. Then "Finish" and the machine will start the installation of the frontend.

![frontend_install_vbox_14](images/frontend/frontend_install_vbox_14.png)

You'll see install screens. This is typical of a CentOS server install. Don't click on any buttons. It's doing its job. Your job is to have another cuppa and don't interfere.

More screens go by. Packages install. Post-install scripts get run. This is a Quickstart so 15 more pngs are not going to be "quick."

You should end up here:

![frontend_install_vbox_27](images/frontend/frontend_install_vbox_27.png)


Log-in and run the following to verify it worked:

```bash
# stack list host
```

![frontend_install_vbox_28](images/frontend/frontend_install_vbox_28.png)

```bash
# stack list pallet
```
![frontend_install_vbox_29](images/frontend/frontend_install_vbox_29.png)

Looks good! Let's go!

## 4. Install backend(s) (formerly Step 3)

** Please note: Installing laptops as backends is not supported. Ever. Evvvvvvvverrrrrrrrrr. Don't write, don't call, don't text if you're trying to install a laptop as a backend server. Our most acidic mockery is reserved for you. (pH level = 0 = battery acid) If you're successful, great, don't tell us, we don't care.

You have a frontend. It's useless if it's not managing backend nodes.

You can add backend hosts either with a spreadsheet or discovery.

Since this is "quick" start. We'll use discovery.

You must be allowed to run promiscuous DHCP for the initial install. After the initial install, you don't need to run discovery again and reinstalls will be hostname/mac/ip matched.

Log into the frontend and start "discover-nodes." This sets the frontend to listen for all DHCP requests. It will attempt to answer any request made to it.

![backend_install_vbox_1](images/backend/backend_install_vbox_1.png)

The default appliance you have is the "Backend" appliance. Choose that because you don't know enough yet to create your own.

![backend_install_vbox_2](images/backend/backend_install_vbox_2.png)

You now have a blank screen waiting to receive DHCP requests.

![backend_install_vbox_3](images/backend/backend_install_vbox_3.png)

## Set-up the backend(s)

These two pictures show the minimal requirement for a backend node. It's just an example.

Backend nodes have to have PXE set first in the BIOS boot order. A must. An absolute requirement. A categorical imperative (Yeaaah, you know your Kant). You're not installing anything automated or at scale if you're not doing this. Don't argue. I have 15 years of arguments waiting to be used.

If the vendor does not set PXE first on your machines, you have to go do it.

* Boot the machine.
* Select BIOS Setup.
* Enable PXE on the NIC wired to the installation network.
* In the boot order set that NIC to the first boot device.
* Save settings and exit.

On a VM it looks like this:

![backend_install_vbox_8](images/backend/backend_install_vbox_8.png)

The frontend and backend have to be on the same network to talk to each other. It doesn't have to be the same network as your apps or storage or whatever. But the wires where the backends make requests and the frontend gives answers has to be the same set of wires.

In this VM example, we're putting both networks on a "local" network. They can only talk to each other. It looks like this:

![backend_install_vbox_7](images/backend/backend_install_vbox_7.png)

Now power on the backend machine.

Breathe.

Back on the frontend you should see the backend node gets discovered:

![backend_install_vbox_4](images/backend/backend_install_vbox_4.png)

The node, patiently waiting for its configuration file:

![backend_install_vbox_5](images/backend/backend_install_vbox_5.png)

The node with its configuration file and the kickstart started. Note the '*' that tells you this:

![backend_install_vbox_6](images/backend/backend_install_vbox_6.png)

You can quit out of the discover-nodes application at this point. Or discover more machines. It stops when you stop booting backends.

If you want to see the status of the node as it installs you can do:

```bash
# watch -n 2 "stack list host"
```

The "Status" column will periodically indicate what is happening.

When the node says "up", it's installed, and you should be able to ssh to it without giving a password.

```bash
# ssh backend-0-0
```

or run the cluster command:

```bash
# stack run host command="uptime"
```

Woohoo! Let's go [Customize](Customization)!
