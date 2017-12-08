Stacki is an extremly fast and scalable data center bare metal installer and 
is part of the Teradata family of open source projects - developed and 
supported by the Shared Services team at Teradata.

So yeah, there's that.

On Stacki 5.0 we currently DO NOT support installing CentOS/RHEL 6.x systems.

### Download 


### Install
To get a functioning system stacki you must do the following.

* Install a frontend
* Install backends

You can't install backend without a frontend.

You can't install a frontend without an OS pallet AND the stacki pallet.

Which means the [stackios](http://teradata-stacki.s3.amazonaws.com/release/stacki/5.x/stackios-5.0_20171128_b0ed4e3-redhat7.x86_64.disk1.iso)
pallet is ideal for the majority of you.

If you just want to get going and don't want too much detail,
follow the [Quickstart](Quickstart).

If you want to install on an already existing machine follow:
[Frontend Installation On Preinstalled System](Frontend-Installation-On-Preinstalled-System).

If you want to have more detail than the Quickstart and you're using the stackios pallet:
[Frontend Installation From Iso](Frontend-Installation-From-Iso)

Then install backends, either using [Quickstart](Quickstart) or

If you control your installing network and you're lazy: [Backend Installation Via Discovery](Backend-Installation-Via-Discovery)

If you have enterprisy needs: [Backend Installation Via Spreadsheet](Backend-Installation-Via-Spreadsheet)
