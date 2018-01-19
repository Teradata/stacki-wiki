
We have a sayin' 'round these parts. (Well, I have a saying.)

_"Stacki gives you the gun, you have to find your foot."_

There are some advanced techniques that we sometimes use and sometimes tell our users to use, because we want them to go away.

These are not guaranteed to work for you. You should have fairly deep experience with Stacki and want to do something the Stacki doesn't currently do natively.

You're forewarned, apparently armed, and your foot is down. Help is in Stacki Slack or Googlegroups, but man, are we gonna laugh.

**tl;dr**

* [Using the Include Directive](Include-Directive) - Relatively safe.
* [Setting Cart Order](Setting-Cart-Order) - Relatively safe but confusing.
* [IP Address Change](IP-Address-Change) - Here be Monsters.
* [Replacing and extending Stacki XML](Replacing-Extending-XML) - Relatively safe.

## Don't decide you want a different private network

You read the warnings right? Get the *private* network correct. The right answer is to reinstall if you didn't. Seriously, you'll be happier, and we'll support you if you do that. All bets are off if you decide to attempt to change everything on the frontend that would need to change in order to fix your private network.

All right fine.

If you want to change this, go to the [Changing the Private Network](IP-Address-Change) docs.

## Don't change the /root/.ssh/id_rsa.pub key.

Don't change the permissions on it. They should be 644 or rw-r--r--. This is what gets put into /root/.ssh/authorized_keys on the backend nodes. If you change the permissions to something more restrictive...Bang! no password-less ssh to the backends.

Don't. Do. It. Dammit.

## Using additional repositories

Using the Centos*.repo files are a recipe for disaster. If you feel you must use them, considering mirroring the repository and adding them as pallets as described in [Creating Software Pallet](Creating-Software-Pallets).

If you don't want to do that, then Stacki is likely not the solution you are looking for. Do more research for something more suitable for your site.

Try:
* [Cobbler](https://cobbler.github.io/) There is some question to Cobbler's viability.
* [Spackewalk](https://spacewalkproject.github.io/)
* [MaaS](https://maas.io/) Install all your base with images. Or, in other words: 1995 called and wants their technology back.
* [Rocks](https://rocksclusters.org) Really good, especially for HPC.
* [Satellite](https://access.redhat.com/products/red-hat-satellite) Install all your base, really, really slowly, using the most expensive software in existence for doing such a simple job.

There may be others. Use Google.


## When I ssh into the frontend or the a backend node, ssh takes a lonnnggggg time.

Usually this means DNS isn't resolving correctly.

Solve this for the frontend by putting:

```
UseDNS no
```
In /etc/ssh/sshd_config and then restarting the sshd service.

```
systemctl restart sshd_config
```

For backends either:

```
stack set attr attr=ssh.use_dns value=True
```

And reinstall, or turn on the named server on the frontend.

```
# stack list network
NETWORK ADDRESS     MASK          GATEWAY      MTU  ZONE   DNS   PXE
private 10.3.1.0    255.255.255.0 10.3.1.1     1500 local  False True
public  192.168.0.0 255.255.0.0   192.168.10.1 1500 jkloud False False

[root@barnacle ~]# stack set network dns private dns=True

[root@barnacle ~]# stack list network
NETWORK ADDRESS     MASK          GATEWAY      MTU  ZONE   DNS   PXE
private 10.3.1.0    255.255.255.0 10.3.1.1     1500 local  True  True
public  192.168.0.0 255.255.0.0   192.168.10.1 1500 jkloud False False
```

## How do I update or add an rpm to a node?

You have ssh password-less access to all the backend nodes and a parallel command to run commands on all of those.

Assuming that the RPM you want to install is in one of your pallet or cart repositories just do:

```
# stack run host command="yum -y install myrpmname"
```

You'll want to put the RPM name in a cart between package tags so it's there for new install or re-installs

```
<stack:package>myrpmname</stack:package>
```

## Help, my stack commands no longer work!

Yesterday things like "stack list host" worked. Today you have a horrible traceback error. What's wrong?

Likely, your disk is full. Check:

```df -h```

If a partition is full, clean it out. Then reboot the frontend. Yes, no harm will come to you or your cluster.

Reboot it. Really. I can wait. Try the command again.

If you don't reboot, I have to give you a list of all the services that need to be restarted because you managed to not watch something so simple as the fullness of your partitions. No.

## How do i subscribe my machines. I'm using RedHat?

When was the last time you had a problem that could be traced back to the OS and not yours or someone else's code?

That's.What.I.Thought.

But you are in an SYA-style organization that requires software licenses for an OS that rarely breaks. I get it.

So this is me, showing you, how to throw your money away.

##### Subscribe a frontend connected to the wurld-wide-interwebzz.

On the frontend, that has RHEL7.4 as it's base os. (Yeah, not gonna work if you don't. But that's a whole ['nother topic](Create-Jumbo-Pallets). )

```
# yum -y install subscription-manager subscription-manager-migration-data
```

Now use subscription-manager command line tool to register this frontend using `<username>`, `<password>`, and '<fqdn>' where `<username>` and `<password>` are YOUR username and password for YOUR RedHat subscription, and `<fqdn>` is the fully qualified domain name of the frontend.

```

# subscription-manager register --username `<username>` --password `<password` --name=`<fqdn>` --auto-attach
```

We are no longer in the business of providing commercial support for RedHat.

If you need further assistance for subscription of RHEL machines follow their [RHSM documentation](https://access.redhat.com/documentation/en-US/Red_Hat_Subscription_Management/1/html-single/RHSM/).

Much of the command line contortions you would have to go through for offline machines can be put into a cart to make this automatic. If you need help with this, ask on [Slack](https://stacki.slack.com) or [Stacki Google Groups](https://stacki.googlegroups.com).
