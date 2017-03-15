<h2>Upgrading to CentOS 7.3 on Stacki-3.2</h2>

Are you sure you want to do this?

No. Are you really sure you want to do this?

Because stacki-4.0 is about a month away, and you don't have to do anything to get 7.3 on that. And it will be better.

No?

Okay. Fine. 

If Pontius Pilate<sup name="a1">[1](#f1)</sup> has any genetic material left 2000+ years later, I'm claiming it's in me. Because I'll give you the instructions on how to do this, but then I'm washing my hands of you.

To be fair, I'm currently doing this on every stacki-os-3.2 frontend I install to do testing. So, it works. I don't know if there are long-term consequences - you get to find that out. 

And I'll give you the gentle version first, which doesn't include your frontend. 

Download the [CentOS 7.3 Everything DVD](http://isoredirect.centos.org/centos/7/isos/x86_64/CentOS-7-x86_64-Everything-1611.iso). You know you want to. There's no reason not to since you've come this far.

You can also get it from us [here.](https://s3.amazonaws.com/stacki/public/os/centos/7/CentOS-7-x86_64-Everything-1611.iso)

<h3>Some things to fix</h3>
Before you do a <b>stack add pallet</b>, there's something you should know and something you should fix. CentOS/RedHat changed the disc information on their isos, which causes the <b>add pallet</b> command to read the CentOS-7.3 iso as BaseOS, which is a bald-faced lie, and we don't lie here anymore because all of our salespeople are gone and we don't remember how. 

This means we gonna fix it and be "we" I mean "you." Which means you're going to have to write some python code. You, yes, you have to open up an editor and get your fingers on. Do the following:

```
# cd /opt/stack/lib/python2.6/site-packages/stack/commands/add/pallet

[root@stackdock pallet]# ls
imp_foreign_redhat.py   imp_mounted_redhat.py  imp_mount_redhat.pyc  imp_native_redhat.pyc  imp_umount_redhat.pyc  __init__.pyc
imp_foreign_redhat.pyc  imp_mount_redhat.py    imp_native_redhat.py  imp_umount_redhat.py   __init__.py

```

The file we care about is "imp_foreign_redhat.py." Open this in your favorite editor. I use vi because everything else is unmitigated garbage. Go to line 128. (Bolded for instructive purposes.)

```
# vi imp_foreign_redhat.py


                        if key == 'family':
                                if value == 'Red Hat Enterprise Linux':
                                        name = 'RHEL'
                                **elif value == 'CentOS':**
                                        name = 'CentOS'
```

Change line 128 to be this:

```

                        if key == 'family':
                                if value == 'Red Hat Enterprise Linux':
                                        name = 'RHEL'
                                **elif 'CentOS' in value:**
                                        name = 'CentOS'
```

Save it, write it, now you should be good to finish the rest. 

<h3>Adding the Updates</h3>
There are two ways to get the Updates from that repository. Download it from us here.

Or do a ```stack create mirror``` command. That's a little more complicated, so let's add an actual html header for it.

<h3>Mirroring CentOS 7 updates.</h3>





<h6>Footnotes</h6>

<sup name="f1">[1](#a1)</sup> 25 points for Classical Reference.