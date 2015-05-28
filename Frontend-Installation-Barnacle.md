## Installing a Frontend on an Existing CentOS/RHEL Server

If you have a server that is already running CentOS or RHEL and you would like to transform it into a Frontend, this section describes how.


### Requirements

The server you wish to transform into a Frontend has the same requirements
as described in [section](Frontend-Installation), in addition, it must
be running the x86_64 version of CentOS 6.x or RHEL 6.x.


### Procedure

Download two ISOs and put them on your server:

1. **stacki**. The stacki ISO can be found [here](http://stacki.s3.amazonaws.com/1.0/stacki-1.0-I.x86_64.disk1.iso).

2. **CentOS** or **RHEL** installation ISO. An CentOS installation ISO can be found [here](http://isoredirect.centos.org/centos/6/isos/x86_64/).

Mount the stacki ISO:

`
mount -o loop stacki*iso /media
`

Copy frontend-install.py from the ISO to your local disk:

`
cp /media/frontend-install.py /tmp
`

Execute frontend-install.py:

`
/tmp/frontend-install.py stacki*iso stacki 1.0 CentOS*iso CentOS 6.6
`

The above step will take several minutes to complete.
It will pop open a window that
is the _stacki installation wizard_ so you will need to be running in a
graphical environment when you execute frontend-install.py (or you will
need to have X11 forwarded to your laptop/workstation).

For details on the _stacki installation wizard_ see section
**Installation Wizard** in this [section](Frontend-Installation).

Reboot your server.

When the server reboots, it will be ready to install backend nodes!

