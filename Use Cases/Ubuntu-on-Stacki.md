---
layout: page
title: Ubuntu on Stacki
permalink: /Ubuntu-on-Stacki
---

<h5>The Guide to Installing Ubuntu with Stacki</h5>

In almost every meet-up and conference one of us has spoken at in the last 6 months, there is always at least one guy who asks "Can you install Ubuntu"? And the answer for the past 6 months has been "No, we don't."<sup name="a1">[1](#f1)</sup>

Until today.<sup name="a2">[2](#f2)</sup>

Okay, well mostly. I'm going to give you all the caveats first, and then if you really want to go down this road, it's less painful now because I walked it for you.<sup name="a3">[3](#f3)</sup> And we would be really excited to work on making it great with any community members who would like to spend some time on it. 

Installing Ubuntu, much like the installation of CoreOS, is a Phase 1 project.<sup name="a4">[4](#f4)</sup> A Phase 1 project for us means: it's going to work, at least as good as what you have, possibly simpler or better than what you have, but it will work. You'll be able to install backend nodes with the version of Ubuntu you want, while still maintaining your CentOS/RHEL stack.

Phase 1 does not have any of the special things we do for CentOS/RHEL variants: disk controller configuration<sup name="a5">[5](#f5)</sup>, parallel disk partitioning, automatic kickstart generation, parallel file-sharing of packages, and the use of attributes to dynamically populate values in kickstart or preseed. Those pieces are for Phase 2, assuming there is sufficient sturm und drang to push us to get there.

This tutorial will follow the same basic outline as CoreOS. Both are effectively the same procedure we use for prototyping any new OS or application we are automating:

- Get the software.
- Set up the bootaction.
- Put the files into tftp.
- Create a preseed.cfg
- Set machines to boot from the bootaction.
- Install
- Validate
- Bask in Ubuntuness
- Turning it to 11
- Future directions.

<h5>Get the software.</h5>

I've only tried this for Trusty Tahr and Wiley Weasel<sup name="a6">[6](#f6)</sup>, so I don't know if older versions work. We'll do Trusty Tahr since that's what is currently have set up on in the lab. 

Ubuntu has a very complete (i.e. somewhat crazy) distribution set-up. If you want absolutely every piece of software from Ubuntu, you can mirror it to your drive. However, it's about 680G of data so you better a) have a big drive and b) have a lot of time and/or great bandwidth. I tried mirroring the whole thing, but it took approximately 3 days to get about 260G. 

I'm not a patient person, so I figured that was the wrong way to go. 

I then just started pulling the distribution iso that I wanted, much simpler, and mirroring that. The only problem with this is that you're strictly limited to the software on the ISO. Unless your backend nodes have internet access (most don't if you're running a real cluster), getting other packages can be tricky. There is a middle way to pull in more packages available in any given Ubuntu distro. I'll give details for that in the "Turning it to 11" section of this document. 

So really, let's get the software. On some internet connected machine, get the Ubuntu ISO of the distribution you want. Use the Ubuntu x86_64 server version. I guess you could use Desktop also; I just haven't done it.

I either use the torrents from the [Ubuntu Alternative Downloads](http://www.ubuntulinux.org/download/alternative-downloads)

Or just download it directly like this:
```
wget http://releases.ubuntu.com/14.04.4/ubuntu-14.04.4-server-amd64.iso
```

Scp or sftp or Filezilla this to your frontend if you didn't just pull it directly there. I usually dump this sort of thing into /export (or /state/partition1 which /export is symlinked to) and do stuff to it from there. 

Mount it:
```
mount -o loop ubuntu-14.04.4-server-amd64.iso /mnt/cdrom
```

We need to copy its contents to a directory that is available via HTTP from the frontend, where, amazingly enough, we have a webserver rooted at /var/www/html/install which symlinks to the directory /export/stack. So we'll copy the contents of the mounted iso to a directory in /export/stack.

```
mkdir -p /export/stack/ubuntu
cp -a /mnt/cdrom/* /export/stack/ubuntu
```

It should look like this when you're done:
```
# ls /export/stack/ubuntu

boot  dists  doc  EFI  install  isolinux  md5sum.txt  pics  pool  preseed  README.diskdefines  ubuntu
```

Now you have an Ubuntu distribution of Trusty Tahr available for installing an Ubuntu server style OS. We'll set-up tftp to set a machine to install Ubuntu.

<h5>Put the necessary files into tftp.</h5>

We need to boot from the Ubuntu vmlinuz and initrd.gz files in order to get the Ubuntu installer (based on busybox). Let's go to the /export/stack/ubuntu directory and get those files from the "netboot" directory. We'll put them in /tftpboot/pxelinux since that's where we drive the pxe/dhcp call response from.

```
# cd /export/stack/ubuntu

ls install/netboot/ubuntu-installer/amd64/

boot-screens  initrd.gz  linux  pxelinux.0  pxelinux.cfg
```

Copy linux and initrd.gz to /tftpboot/pxelinux to something we can use:
```
cp install/netboot/ubuntu-installer/amd64/initrd.gz /tftpboot/pxelinux/initrd.trusty
cp install/netboot/ubuntu-installer/amd64/linux /tftpboot/pxelinux/vmlinuz.trusty
```

I've given the two files a ".trusty" suffix so it's easier to know which one I'm pointing to and what I'm going to get. There are other ways to arrange this that are likely more intelligent. But this is Phase 1 so getting it up and working is the paramount goal. 

Remember also, that we expect the kernel and ramdisk to start with "vmlinuz" and "initrd" respectively. When we set a bootaction, the code needs those two names at the beginning.<sup name="a7">[7](#f7)</sup>

You also have to make "vmlinuz.trusty" executable, so do that:
```
chmod 755 /tftpboot/pxelinux/vmlinuz.trusty
```



Next we need a bootaction we can assign to machines. 

<h5>Set up the bootaction.</h5>

Let's create the bootaction from the command line. Note, there is some stuff in this bootaction I'll do my best to explain, but sometimes I don't get it. Know that it's required to get the preseed file to install without asking any questions. 

```
stack add bootaction action=ubuntu kernel=vmlinuz.trusty ramdisk=initrd.trusty args="install auto=true url=http://10.1.1.1/install/ubuntu/preseed.cfg console=tty0 console=ttyS0,115200n8 ksdevice=bootif biosdevname=0 hostname=unassigned locale=en_US.UTF-8 keyboard-configuration/layout=us live-installer/net-image=http://10.1.1.1/install/ubuntu/install/filesystem.squashfs ramdisk_size=16392 nousb interface=auto netcfg/get_nameservers=10.1.1.1 priority=critical"
```

Note that in the arguments there is an awful lot of hard-coded stuff. The IP address of the frontend, the url, the nameservers. Horrible by my standards. This sort of thing improves in Phase 2 stages. Also note that we are using a preseed.cfg to do the auto install. There may be a combination of kickstart and preseed that may be more conducive to Stacki style auto-installations, but that's for further exploration. 

You don't need the serial console lines. The lab here requires it because I refuse to turn around, get out of my chair, and walk the 12 feet necessary to hook up a console and a monitor to see what a machine is doing. Hey, call me lazy, but laziness is the system administrator's raison d'etre for creating automation. 

<h5>Create a preseed.cfg</h5>

The preseed.cfg is the file we'll use to do the automation. As a Phase 1 project, this is the minimal amount that will get you what you want. This took a lot of time and playing around to get it right. It doesn't do anything fancy other than install a machine with a basic filesystem (per Ubuntu's choices) and installs ssh so we can get to the machine from the frontend.

Here is the preseed.cfg we'll be using. It lives in the /export/stack/ubuntu directory as "preseed.cfg."

```
d-i debian-installer/locale string en_US
d-i debconf/priority select critical
d-i auto-install/enabled boolean true
d-i time/zone string America/Denver
d-i console-setup/ask_detect boolean false
d-i keyboard-configuration/layoutcode string us
d-i netcfg/choose_interface select auto
d-i netcfg/get_nameservers string 10.1.1.1
d-i netcfg/get_hostname string unassigned-hostname
d-i netcfg/get_domain string unassigned-domain
d-i pkgsel/update-policy select none
d-i apt-setup/security-updates boolean false
d-i mirror/country string manual
d-i mirror/http/hostname string 10.1.1.1
d-i mirror/http/directory string /install/ubuntu
d-i mirror/http/proxy string
d-i mirror/codename string trusty
d-i mirror/suite string trusty
d-i mirror/udeb/suite string trusty
d-i apt-setup/security_host string 10.1.1.1
d-i apt-setup/security_path string /install/ubuntu
d-i pkgsel/update-policy select none
d-i pkgsel/update-policy select none
d-i apt-setup/security_protocol string http
d-i apt-setup/security_host string 10.1.1.1
d-i apt-setup/security_path string /install/ubuntu
d-i mirror/country string manual
d-i live-installer/net-image string http://10.1.1.1/install/ubuntu/install/filesystem.squashfs
## start of partitioning configuration
## order is critical here or you'll get asked questions
d-i partman-auto/init_automatically_partition select entire_disk
d-i partman-auto/choose_recipe select All files in one partition (recommended for new users)
d-i partman-auto/disk string /dev/sda
d-i partman-auto/method string lvm
d-i partman-auto/purge_lvm_from_device boolean true
d-i partman-lvm/device_remove_lvm boolean true
d-i partman-lvm/device_remove_lvm_span boolean true
d-i partman-lvm/confirm boolean true
d-i partman/choose_partition select finish
d-i partman-lvm/menu/finish select finish
d-i partman-auto-lvm/guided_size string max
d-i partman-auto/choose_recipe select atomic
d-i partman/default_filesystem string ext4
d-i partman/confirm_write_new_label boolean true
d-i partman/confirm boolean true
d-i partman-lvm/confirm boolean true
d-i partman-lvm/confirm_nooverwrite boolean true
#d-i passwd/root-login boolean false
d-i passwd/root-login boolean true
d-i passwd/root-password-crypted password $1$gq/i3vdY$OPGoAlRURKPIEZo/mvOm/.
d-i passwd/make-user boolean true
d-i passwd/user-fullname string Ubuntu User
d-i passwd/username string ubuntu
d-i passwd/user-password-crypted password $1$gq/i3vdY$OPGoAlRURKPIEZo/mvOm/.
d-i passwd/user-uid string
d-i user-setup/allow-password-weak  boolean false
d-i user-setup/encrypt-home boolean false
# network console
#d-i anna/choose_modules string network-console
#d-i network-console/authorized_keys_url http://10.1.1.1/install/ubuntu/authorized_keys
#d-i network-console/password password
#d-i network-console/password-again password
# clock
d-i clock-setup/utc boolean true
d-i clock-setup/ntp boolean true
d-i clock-setup/ntp-server string 10.1.1.1
# ssh
tasksel tasksel/first   select  OpenSSH server
d-i pkgsel/include string curl
# last commands
d-i preseed/late_command string in-target /usr/bin/curl -s -k -o /dev/null \
    https://10.1.1.1/install/sbin/public/setPxeboot.cgi?params='\{"action":"os"\}' ; \
    in-target mkdir -p /root/.ssh ; \
    in-target wget -O /root/.ssh/authorized_keys http://10.1.1.1/install/ubuntu/authorized_keys
    in-target chmod 600 /root/.ssh/authorized_keys ; \
    in-target chmod 700 /root/.ssh ;
# finish
d-i grub-installer/only_debian boolean true
d-i finish-install/reboot_in_progress note
```

Note again all the hard-coded IPs and the drive. We would fix that in Phase 2. Also note at the bottom, I'm pulling in the authorized_keys from the webserver. This is probably bad. We'll figure out a better way to do this. In the meantime:

```
cp /root/.ssh/id_rsa.pub /export/stack/ubuntu/authorized_keys
chown root:apache /export/stack/ubuntu/authorized_keys
chmod 644 /export/stack/ubuntu/authorized_keys
```

Will make that part work. We also run the setPxeBoot.cgi to change the boot flag to "os" so that it boots from local disk after installation. This is similar to what we've done for CoreOS. The above file comes with the "Well, it works on my machine," caveat. 

<h5>Set machines to boot from the bootaction.</h5>

We want to actually install Ubuntu, so we have to set the installaction for some of our machines to the "ubuntu" bootaction:

What are they now?
```
HOST         RACK RANK CPUS APPLIANCE BOX  RUNACTION INSTALLACTION
stacki37:    0    0    1    frontend  kilo os        install
backend-0-0: 0    0    2    backend   kilo os        install serial
backend-0-1: 0    1    2    backend   kilo os        install serial
backend-0-2: 0    2    2    backend   kilo os        install serial
backend-0-3: 0    3    2    backend   kilo os        install serial
backend-0-4: 0    4    2    backend   kilo os        install serial
```

Oh that's messed up. So we'll set them back to the "default" box and the "ubuntu" installaction. (Yours are probably already in the "default" box. So you probably don't have to change the box. "ubuntu" is the name of the bootaction we created above. 

```
stack set host box backend box=default
stack set host installaction backend action=ubuntu

stack list host

HOST         RACK RANK CPUS APPLIANCE BOX     RUNACTION INSTALLACTION
stacki37:    0    0    1    frontend  kilo    os        install
backend-0-0: 0    0    2    backend   default os        ubuntu
backend-0-1: 0    1    2    backend   default os        ubuntu
backend-0-2: 0    2    2    backend   default os        ubuntu
backend-0-3: 0    3    2    backend   default os        ubuntu
backend-0-4: 0    4    2    backend   default os        ubuntu
```

That looks good.

<h5>Install</h5>
We'll set the boot flag for these to install. They have the correct installaction so we'll set the thing they do on the next boot to be "install" and they'll start installing Ubuntu. This is going to wipe out your disk partitioning and formatting, but shouldn't mess with your controller configuration.

```
stack set host boot backend action=install
```

They should now be set to boot from the preseed.cfg and install. If you're neurotic (I am) and don't believe it (I don't) check the pxe cfg file for your machines:

```
cat /tftpboot/pxelinux/pxelinux.cfg/0*
```

Will show something like this for the machines getting Ubuntu:
```
label stack
	kernel vmlinuz.trusty
	append install auto=true url=http://10.1.1.1/install/ubuntu/preseed.cfg console=tty0 console=ttyS0,115200n8 ksdevice=bootif biosdevname=0 hostname=unassigned locale=en_US.UTF-8 keyboard-configuration/layout=us live-installer/net-image=http://10.1.1.1/install/ubuntu/install/filesystem.squashfs ramdisk_size=16392 nousb interface=auto netcfg/get_nameservers=10.1.1.1 priority=critical ip=10.1.255.254 gateway=10.1.1.1 netmask=255.255.0.0 dns=10.1.1.1 nextserver=10.1.1.1 initrd=initrd.trusty
	ipappend 2
```

There's one last thing, we have to change group permissions on some (or all) of the files in /export/stack/ubuntu to the "apache" group, or the installer won't pull them.

It's easiest to use the 64000ft method:

```
chgrp -R apache /export/stack/ubuntu
```

Now kick the machines over. If you have ssh access right now:

```
stack run host command="reboot"
```

Or power cycle/reboot them by whatever means are available to you.

<h5>Validate</h5>
Once they've installed, check that you can get to them. We installed ssh with the id_rsa.pub from root on the frontend, so do that. (Oh yeah, the preseed creates a "root" user, not recommended by Ubuntu.)

```
stack run host command="uptime"
```

or 

```
stack run host command="uname -a"
```
Which should give you an idea of what they are running. Should be a Trusty Tahr kernel. You might have to clean out the /root/.ssh/known_hosts file to get these commands to run cleanly. If you you get a password prompt, something aint right.  

<h5>Bask in Ubuntuness</h5>
Ubuntu is up. Bask in pure Ubuntu awesomeness. Give the machines to a developer, when they've thoroughly broken it, reinstall it and scold them with a proper sysadmin scowl.

The apt repositories for this machine are the frontend. If you need to change that, you can add them through the preseed file, or after the fact. Or install from a known apt-repository, which sort of defeats the purpose of this.

You should be able to ssh into any of these machines as root if you've followed the instructions here. Alternatively, since we have created a root user you should be able to do use the stack command line to communicate with them.

```
stack run command backend command="uptime"
```

You may have to remove the nodes from your /root/.ssh/known_hosts file to get them to not show the error headers. 

<h5>Turning it to 11</h5>
Okay, so this gets you one release and then it's only the software on that iso. What if you want more? I always want more, but the entire Ubuntu repo is too much. So let's get just enough. 

You can mirror the full repository for one release of Ubuntu. We'll do Trusty Tahr. This is my explanation of a process delineated [by another guy named Joe.](https://sjoeboo.github.io/blog/2012/01/26/mirroring-ubuntu-on-centos/) so I can't take credit for it. Here it is adapted for Stacki.

You're gonna need these:
```
 yum -y install perl-LockFile-Simple.noarch perl-Net-INET6Glue.noarch
```

Get mirroring software. I created a /export/stack/umirror and did everything in that directory.

```
wget http://archive.ubuntu.com/ubuntu/pool/universe/d/debmirror/debmirror_2.16ubuntu1.tar.gz
```

Untar in some directory and change to the "debmirror" directory:
```
tar -xzvf debmirror_2.16ubuntu1.tar.gz

cd debmirror-2.16ubuntu1
```

Use the following script file stolen and adapted from the blog post above (save as mirror.sh):

```
#!/bin/bash
arch=amd64
section=main,restricted,universe,multiverse
release=trusty,wily
server=us.archive.ubuntu.com
inPath=/ubuntu
proto=rsync
#proxy=http://proxy.local:8888
outpath=/export/stack/ubuntu

debmirror       -a $arch \
                --no-source \
                -s $section \
                -h $server \
                -d $release \
                -r $inPath \
                --progress \
                --ignore-release-gpg \
                --no-check-gpg \
                -e $proto \
                $outpath
```

Note that we are getting trusty and wily, you can do both, or one or the other. Each distro is about 60G, and has the software packages in main, multiverse, restricted, and universe.

Our output directory is /export/stack/ubuntu. If you did the previous procedure, this will overwrite your ubuntu install from ISO. If you don't want that, make sure your output directory is named differently but still under /export/stack so it's available via HTTP.

Run the mirror.sh code.
```
chmod 755 mirror.sh

./mirror.sh
```

Wait and wait and wait. Wait some more depending on your bandwidth, or wait less. Godot really is coming, he's just not here yet. 

When it's downloaded, you can adjust your bootaction and preseed.cfg to point to this directory. This will now be the directory of choice in the apt sources list for your backend machines, giving you a greater number of packages to be consumed. 

If you didn't do the previous ISO install and just jumped to here, find the vmlinuz and initrd.gz and copy them to the /tftpboot/pxelinux directory as above before proceeding with the rest of the install. 

<h5>Future Directions</h5>
As a Phase 1 project, this has a bunch of things you have to do by hand. We don't like that. When managing machines, you want your command line actions and set-up to be ones that will affect the entire cluster. It's the fulcrum on which you lever your machines to a standard. 

Phase 2 would explore the following (in no apparent order):
* Automatic kickstart/preseed generation
* Use of Stacki attributes (key/value pairs) in preseed.cfg and kickstart.
* Auto partitioning. 
* Disk controller configuration.
* Creating Ubuntu ISOS as a pallet (we can actually add Ubuntu as a pallet now, but the code has yet to be checked in.)
* Creating the ability to mirror Ubuntu repos automatically from the frontend.
* Integrating the Ubuntu installer to pull deb packages via the peer-to-peer installer.
* Figuring out how to do parallel partitioning of disks. 

Which direction Ubuntu takes will be driven by our community. So if you have any ideas about the direction you would like us to go, please let us know on the mailing list.

<h6>Footnotes</h6>

<sup name="f1">[1](#a1)</sup> One of you is going to say "What about SUSE?", and I'm going to say make an argument for the need, and we'll start a Phase 1 and see how far it goes. Or we'll help you start a Phase 1 project and see how far it goes. Or, write us a check, and we'll have you believing in magic again.<sup name="b1">[1](#g1)</sup>

<sup name="f2">[2](#a2)</sup> Cue thunderous applause.

<sup name="f3">[3](#a3)</sup> And, I, might add, left it on the mat, put my heart and soul into it, laughed, cried, became a part of it, spilt my life's blood, cursed the Gods on your behalf, all while wondering how anyone has been able to install an entire cluster of this OS in a timely fashion - for you, yes you, that guy who always asks me: "Can I install Ubuntu?"

<sup name="f4">[4](#a4)</sup> Meaning, that it's going to work, it will have some special sauce, but the two whole beef patties will be missing, which means you can eat it but you'll be wondering where the beef is.

<sup name="f5">[5](#a5)</sup> Okay, so disk controller set-up is a killer problem. If you really want the RAID setup correctly using this procedure, import the controller setup in a spreadsheet, install the backend nodes with CentOS/RHEL, and then reinstall them with this procedure for Ubuntu. Magic. You have your controllers set-up and you have Ubuntu. The Ubuntu install takes longer but you'll have the RAID set-up the way you expect with the small constraint of having an extra install. But that takes what, 10-15 minutes for as many nodes as you have?

<sup name="f6">[6](#a6)</sup> That might be "Wiley " "Walrus" or "Woodchuck" or "Werewolf" even, so don't quote me on that.
 
<sup name="f7">[7](#a7)</sup> Don't ask me why, I don't know. Don't let it disharmonize your wa or disrupt your chi. Accept that it is and be one with it. Until some one fixes it. Which someone will, any day now, really, someone.any.day.now.

<h7>Footnotes to the Footnotes</h7>

<sup name="f1">[1](#g1)</sup> Once the check has cleared.