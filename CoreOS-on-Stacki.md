
The Guide to CoreOS on Stacki

If you’re old, all of this will be old in a new way. If you’re new, all of this will be new, but really, it’s old.

Containers are the new sexy. It’s what you turn to when you finally decide virtual machines are too heavy for what you want to do or when you realize OpenStack is not as cool as everyone thought it was. It’s what you use when you don’t want to bother with user segmentation and batch-like systems. (Though you will, which is why you’ll install Mesos or Kubernetes, which are two other tutorials.)

CoreOS is for linux containers  in a fast automated deployment.  (Which we’ve been doing for, oh, two decades now, and three decades if you cite Sun Microsystems, and four if you’re going to get technical and tell me about your VAX back in the day, [which was technically, before I even had a day - I think I was six.])

All you have to do is put up a TFTP/DHCP server and add machines, well, and software too, and now you can play with containers (Docker works on stable, Rocket will be the next new thing in CoreOS in a couple of releases.) and tell your boss (and recruiters!) that you know CoreOS and Docker.

In this tutorial, we’ll install CoreOS on a Stacki server, set-up TFTP/PXE/DHCP to serve coreos, and bring you to the point where you can run Docker containers. It’s simple, it’s easy. And it’s one more thing you can add to a Stacki frontend to own your data center. We don’t care what you run, we just care you’re able to run it. So we’ll do a basic CoreOS implementation on the infrastructure that CoreOS can build.

- Get the software.
- Set up the bootaction.
- Put the files into tftp
- Set machines to boot from coreos
- Install using cloud-config
    - first just in memory
    - second, set to copy to disk
- Run docker.
- More advanced shit.

1. Get the software:

You can find the latest and greatest CoreOS here:

http://coreos.com

I’m essentially following these instructions:
https://coreos.com/os/docs/latest/booting-with-pxe.html

But adapting them to Stacki which already has PXE/DHCP set-up configured. I’m just going to point everything in the right place to do CoreOS.

We’ll use the “Stable Channel.” This should still work with Beta, and Alpha even, if you like to dance on the razor’s edge, but I’ve been there and needed a transfusion afterwards. I’m older now, so we’ll use Stable.

Actually getting the software:

Put this into a script a file and run it with bash, or run each command by hand with cut and paste. Whatever blisses your joy.

cd /tftpboot/pxelinux
wget http://stable.release.core-os.net/amd64-usr/current/coreos_production_pxe.vmlinuz
wget http://stable.release.core-os.net/amd64-usr/current/coreos_production_pxe.vmlinuz.sig
wget http://stable.release.core-os.net/amd64-usr/current/coreos_production_pxe_image.cpio.gz

wget http://stable.release.core-os.net/amd64-usr/current/coreos_production_pxe_image.cpio.gz.sig
# gpg --verify coreos_production_pxe.vmlinuz.sig
# gpg --verify coreos_production_pxe_image.cpio.gz.sig

ln -s coreos_production_pxe.vmlinuz vmlinuz.coreos
ln -s coreos_production_pxe_image.cpio.gz initrd.coreos

Two things:

First thing: The gpg check is commented out because it failed when I ran this, said there was no public key. Whatever, I can have a little risk in my life. I left them so you know what CoreOS recommends for installation.

Second thing: There is this issue (well, maybe it’s just my issue) in Stacki where the pxelinux.cfg/0x0whatever file doesn’t get created correctly if the kernel image and the ramdisk images don’t look like vmlinuz.something or initrd.something. I created a couple of symlinks to get around this peccadillo. Someone is going to fix this, soon, real soon.

2. Set-up the bootaction.

Anything you can boot from a pxe server, we can boot. CoreOS, ESXi, Windows, etc. If you can create a pxe boot action for it, you can add it to the Stacki database and assign nodes to boot from that bootaction.

So let’s add the CoreOS bootaction.

List the bootactions to see examples:

[root@stacki7 ~]# stack list bootaction
ACTION                      KERNEL                        RAMDISK               ARGS
coreos:                     coreos_production_pxe.vmlinuz --------------------- cloud-config-url=http://10.2.1.1/install/coreos/pxe-cloud-config.y console=tty0 console=ttyS0,115200
install:                    vmlinuz-2.0-x86_64            initrd.img-2.0-x86_64 ip=bootif:dhcp inst.ks=https://10.2.1.1/install/sbin/kickstart.cgi inst.geoloc=0 inst.noverifyssl inst.ks.sendmac
install headless:           vmlinuz-2.0-x86_64            initrd.img-2.0-x86_64 ip=bootif:dhcp inst.ks=https://10.2.1.1/install/sbin/kickstart.cgi inst.geoloc=0 inst.noverifyssl inst.ks.sendmac headless
install no-parallel-format: vmlinuz-2.0-x86_64            initrd.img-2.0-x86_64 ip=bootif:dhcp inst.ks=https://10.2.1.1/install/sbin/kickstart.cgi inst.geoloc=0 inst.noverifyssl inst.ks.sendmac no-parallel-format
install serial:             vmlinuz-2.0-x86_64            initrd.img-2.0-x86_64 ip=bootif:dhcp inst.ks=https://10.2.1.1/install/sbin/kickstart.cgi inst.geoloc=0 inst.noverifyssl inst.ks.sendmac console=tty0 console=ttyS0,115200n8
install vnc:                vmlinuz-2.0-x86_64            initrd.img-2.0-x86_64 ip=bootif:dhcp inst.ks=https://10.2.1.1/install/sbin/kickstart.cgi inst.geoloc=0 inst.noverifyssl inst.ks.sendmac inst.vnc
memtest:                    kernel memtest                --------------------- -----------------------------------------------------------------------------------------------------------------------------------------------------
os:                         com32 chain.c32               --------------------- hd0
os.hplocalboot:             localboot -1                  --------------------- -----------------------------------------------------------------------------------------------------------------------------------------------------
os.localboot:               localboot 0                   --------------------- -----------------------------------------------------------------------------------------------------------------------------------------------------
pxeflash:                   kernel memdisk bigraw         pxeflash.img          keeppxe
rescue:                     vmlinuz-2.0-x86_64            initrd.img-2.0-x86_64 ip=bootif:dhcp inst.ks=https://10.2.1.1/install/sbin/kickstart.cgi inst.geoloc=0 inst.noverifyssl inst.ks.sendmac rescue

Add the bootaction, to get the arguments you need:

# stack add bootaction

error - "action" parameter is required
[action=string] [args=string] [kernel=string] [ramdisk=string]

[root@stacki7 ~]# stack add bootaction
error - "action" parameter is required
[action=string] [args=string] [kernel=string] [ramdisk=string]

Add the bootaction to reflect what CoreOS requires:

[root@stacki7 ~]# stack add bootaction action=coreos kernel=vmlinuz.coreos ramdisk=initrd.coreos args="cloud-config-url=https://10.2.1.1/install/coreos/pxe-cloud-config.y console=tty0 console=ttyS0,115200"

Check it:

[root@stacki7 ~]# stack list bootaction | grep coreos

coreos:                     vmlinuz.coreos        initrd.coreos         cloud-config-url=https://10.2.1.1/install/coreos/pxe-cloud-config.y console=tty0 console=ttyS0,115200

Some things to note:

- In the “url” use the ip address of the frontend.
- We have to create the pxe-cloud-config.y for this to work, I’ll show that in the next step.
- You don’t need “console=tty0 console=ttyS0,115200”. I watch my lab installs with SOL over ipmi on the backend nodes so I use these parameters.

3. Add some hosts to boot CoreOS:

I’m going to do all my hosts so I’ll use the “backend” appliance name to any of the stack host commands to apply the changes to all of the “backend” nodes.

You could easily do just one backend node by giving these commands the name of the host, e.g. “backend-0-0” or a for just a few of them use a regex, e.g. “backend-0-[1-3]"

We’re just going to do all of them. If I explain the next command to you, it will take as long to explain it as this whole document. I’m sure I’ve covered it somewhere else. If I haven’t, ask. It was the single hardest concept for me to grasp when I first started using this software 12 years ago. Do the following, on faith:

# stack set host installaction backend action=coreos

Now set all the machines to install coreos:

[root@stacki7 pxelinux]# stack set host installaction backend action=coreos

[root@stacki7 pxelinux]# stack list host

HOST         RACK RANK CPUS APPLIANCE DISTRIBUTION RUNACTION INSTALLACTION
stacki7:     0    0    1    frontend  default      os        install
backend-0-0: 0    0    2    backend   default      os        coreos
backend-0-1: 0    1    2    backend   default      os        coreos
backend-0-2: 0    2    2    backend   default      os        coreos
backend-0-3: 0    3    2    backend   default      os        coreos
backend-0-4: 0    4    2    backend   default      os        coreos

Really check it:

Pxe config files are dynamically generated when you set the host to boot from either “install” or “os” in /tftpboot/pxelinux/pxelinux.cfg/hexnumberofmachine. “cat" one to make sure it looks okay.

[root@stacki7 ~]# cat /tftpboot/pxelinux/pxelinux.cfg/0A02FFFE

default stack
prompt 0
label stack
    kernel vmlinuz-2.0-x86_64
    append ip=bootif:dhcp inst.ks=https://10.2.1.1/install/sbin/kickstart.cgi inst.geoloc=0 inst.noverifyssl inst.ks.sendmac console=tty0 console=ttyS0,115200n8 initrd=initrd.img-2.0-x86_64
    ipappend 2

Oh look, it failed! (There’s no coreos bootaction in that file.) We’ll unset and reset the boot flag to fix it:

# stack set host boot backend action=os

# stack set host boot backend action=install

Now look:

[root@stacki7 ~]# cat /tftpboot/pxelinux/pxelinux.cfg/0A02FFFE
default stack
prompt 0
label stack
    coreos_production_pxe.vmlinuz
    append cloud-config-url=https://10.2.1.1/install/coreos/pxe-cloud-config.y console=tty0 console=ttyS0,115200

Much better. So now we can power cycle our machines and expect them to install.

4. Installing machines

No, wait, we can’t install yet. there is the pxe-cloud-config.y yaml file referenced in the URL we have to use to get them up. It’s like a kickstart file for CoreOS. So let’s go create that.

The file has to be available via an http call which means it has to be accessible on the wire. Conveniently enough, we already do this for kickstart files so we’ll just drop this in a directory accessible via web server.

# cd /export/stack

or:

# cd /state/partition1/stack
(They’re the same directory. How much do you like to type?

Let’s create a coreos directory because we’ll probably do some other cool shtuff later:

# mkdir coreos
# cd coreos

Put the following file in as pxe-cloud-config.y (copied from the website)

#cloud-config
coreos:
  units:
    - name: etcd2.service
      command: start
    - name: fleet.service
      command: start
ssh_authorized_keys:
  - put your /root/.ssh/id_rsa.pub here

See that “put your /root/.ssh/id_rsa.pub here” line? Just “cat” that file from /root/.ssh/id_rsa.pub and paste it there.

Validate the file:

Go here:

https://coreos.com/validate/

and cut and paste your pxe-cloud-config.y file into the provided text box and hit the “Validate Cloud-Config” button.

You can also download and build coreos-cloudinit from git here:
https://github.com/coreos/coreos-cloudinit.git, and build it, but for the purposes of this, I’m not going to do demonstrate that here.

Once validated, reboot your machines and watch them install. Once installed, you can go to the last part of this and use Docker.

The key you put in the config file is for the user “core” not “root”. So you should have passwordless access for user “core."

We’ll add a “root” user in the next more advanced section.

5. The more advanced section.

This initial install will install CoreOS into memory. So if you don’t have enough memory on your machines, you have old machines - the coreos install will fail and die.

The solution to not having enough memory is to get new machines. They’re out of warranty if they can’t support something as small as CoreOS. Get better ones.

Or, you can just install it to disk. That works too. So we’ll do that by adjusting our cloud config to create some disk from which to use docker.

We’re going to adjust our boot url to call a script that will install our cloud configuration and install everything to disk. So let’s do that:

To install to disk you need the production images and they also need to be available from the webserver.

Here is the code to do that:

if [ ! -d /export/stack/coreos/current ]; then
    mkdir -p /export/stack/coreos/current
fi

cd /export/stack/coreos/current
wget http://stable.release.core-os.net/amd64-usr/current/coreos_production_image.bin.bz2
wget http://stable.release.core-os.net/amd64-usr/current/coreos_production_image.bin.bz2.sig

This will put the images required in the /export/stack/coreos/current  directory where they can be pulled during install.

To take advantage of this we’ll use a script to install CoreOS permanently on  disk.  In /export/stack/coreos create cloud-config-bootstrap.sh with the following content:

#!/bin/bash

sudo su - root
curl -s -k -O https://10.2.1.1/install/coreos/cloud-config.yaml
coreos-install -d /dev/sda -c cloud-config.yaml -v -b http://10.2.1.1/install/coreos -V current
curl -s -k -o /dev/null https://10.2.1.1/install/sbin/public/setPxeboot.cgi?params='\{"action":"os"\}'
reboot

What this means is, we’re going to pull our pxe-cloud-config.y, (now symlinked to pxe-cloud-config.y like this “ln -s pxe-cloud-config.y cloud-config.yaml. We’re doing this so we can symlink to different cloud-configs if we want to.)

The second line installs the pxe-cloud-config.y to disk. So when the machine reboots, it will boot up with a disk configuration. We know these particular machines have a /dev/sda so we’ll use that.

The “setPxeboot.cgi” call will automatically set the “stack set host boot” to “os” rather than install so you don’t get trapped into an endless install loop. We do this on our installations via kickstart. It makes sense to do that here as well.

So now we have to
change our bootaction again to reflect that we’re using a different installation script:

# stack add bootaction action=coreos kernel=vmlinuz.coreos ramdisk=initrd.coreos args="cloud-config-url=http://10.2.1.1/install/coreos/cloud-config-bootstrap.sh console=tty0 console=ttyS0,115200n8"

And kick the install flag so the right pxefile is generated:

# stack set host boot backend action=os
# stack set host boot backend action=install

And then we’ll reboot the machine(s). I imagine you can put more shell commands in this file to do much more. But this is sufficient for now. One of the nice things about installing CoreOS from Stacki, is that the hostname and ip address is automatically set during the CoreOS install because it’s inherited from the installing environment. No need to set that information in a cloud-config file.

Additional user and network config.

If your instances run on a private subnet, they won’t be able to get out to pull things from the docker.io registry. Which is okay, you can always run a local registry on the Stacki frontend and pull images that way. That’s another topic in itself, however.

This means we want the individual nodes to have outside access. The machines in this example already have a public facing interface so we will fix networking so it goes out the right gateway on the right interface.

Also we want to run commands as root with “stack run host” so we can manage all instances at once. So we’ll make sure the root user has the ssh keys.

In /export/stack/coreos create a new file called cloud-config-example.yaml and soft link it to cloud-config.yaml in the same directory.

# rm -f cloud-config.yaml
# ln -s cloud-config-example.yaml

add the following to cloud-config-example.yaml. The first part is from our original pxe-cloud-config.y

It should look like this:

#cloud-confie
coreos:
  units:
    - name: etcd2.service
      command: start
    - name: fleet.service
      command: start
ssh_authorized_keys:
  - ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABAQDEB28SB7N6EECT56UOSRk5MQ1ovfoR32vWQT1GOZgPDQveFwvHbCBNS0JY7J5tc+X7P70YPLUe8enZu92GFOoSpyj0uOJaMXzh321QglorSTS9AAvTVgiAEbnIiWEvfiSZ5RBUeTlCJJkt/f8+xxyGYAuCrE+/2VwQThQUlPlaiZ0kij+6LIxD/nLXy/VpEoLf7PsDYjSBpMx/VzzY9g7esJvjOCc32oAzqcyDX1ClrlGb9GkN8j+zsX+N7wdlCh30WTt4V+LMq+d4i6kiBW5eC1zDPqsdYXjp7J3pp3uunIrWxNfgLNyRAzSIMD1zKgaSclbX5ioXdqB4A7Gai5Z1 root@stacki7.jkloud.com

Warning: Using the .yaml extension for files if you’re using vim as an editor is really, really, really slow. It’s weird. Use a .y extension for editing and then copy the file to a .yaml if you must, or just use the .y and set filenames in your scripts appropriately.

To start the network, we’re just going to turn on DHCP for the public network, and since this is already in the Stacki database, each machine will get it’s correct IP and gateway info. There are ways to do this in cloud-config, but this is the simplest way to do it on a Stacki frontend.

Let’s list the networks:

[root@stacki7 coreos]# stack list network
NETWORK    ADDRESS     MASK          GATEWAY     MTU   ZONE       DNS   PXE
openstack: 10.3.1.0    255.255.255.0 10.3.1.100  1500  openstack  False False
private:   10.2.0.0    255.255.0.0   10.2.1.1    1500  jkloud.com False True
public:    192.168.0.0 255.255.0.0   192.168.1.1 1500  jkloud.com False False

You’ll notice only the private is set to DHCP. So we’ll set the public to do so as well:

[root@stacki7 coreos]# stack set network pxe public pxe=True

Verify:

[root@stacki7 coreos]# stack list network
NETWORK    ADDRESS     MASK          GATEWAY     MTU   ZONE       DNS   PXE
openstack: 10.3.1.0    255.255.255.0 10.3.1.100  1500  openstack  False False
private:   10.2.0.0    255.255.0.0   10.2.1.1    1500  jkloud.com False True
public:    192.168.0.0 255.255.0.0   192.168.1.1 1500  jkloud.com False True

Do a:

# stack sync config

Now a CoreOS machine should be able to get the right public network info via DHCP from the frontend, and pulling Docker images ought to be easy:

Running a Docker instance

We’ll do one node as an example:

Login as core@backend-0-0. This should be passwordless because we have ssh keys in for that account.

Now you should be able to connect to it.

Add Docker httpd container:

docker pull httpd

Start it:

docker run -d -p 9000:80 --name=TestHTTPD httpd

Check it:

[root@stacki7 coreos]# wget http://192.168.1.41:9000
--2015-12-18 18:59:15--  http://192.168.1.41:9000/
Connecting to 192.168.1.41:9000... connected.
HTTP request sent, awaiting response... 200 OK
Length: 45 [text/html]
Saving to: ‘index.html’

100%[====================================================================>] 45          --.-K/s   in 0s

2015-12-18 18:59:15 (6.05 MB/s) - ‘index.html’ saved [45/45]

[root@stacki7 coreos]# cat index.html
<html><body><h1>It works!</h1></body></html>

There is so much more to CoreOS than this basic tutorial, and I’m sure there are ways in which interfacing with Stacki may help some of the difficulties with more complex CoreOS deployments.

These things include:

- Fleet, flannel, and etcd2.
- Kubernetes and Mesos
- Running without outside access (most of this tutorial requires it.)
- Running an internal (to your network) Docker registry.
- Using other container technologies other than Docker.

Let us know if exploring those issues will be useful.