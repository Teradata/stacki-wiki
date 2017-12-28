#### When I ssh into the frontend or the a backend node, ssh takes a lonnnggggg time.

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

#### Can I change the private network after installation?

No, not possible. Don't get that bit wrong. If you get it wrong, reinstall the frontend.

This warning was in the frontend installation documentation. Did you not heed it?

_**Do not get this network wrong! Changing it after the fact means a REINSTALL of the frontend.**_

#### How do I update or add an rpm to a node?

You have ssh password-less access to all the backend nodes and a parallel command to run commands on all of those.

Assuming that the RPM you want to install is in one of your pallet or cart repositories just do:

```
# stack run host command="yum -y install myrpmname"
```

You'll want to put the RPM name in a cart between package tags so it's there for new install or re-installs

```
<stack:package>myrpmname</stack:package>
```

#### Help, my stack commands no longer work!

Yesterday things like "stack list host" worked. Today you have a horrible traceback error. What's wrong?

Likely, your disk is full. Check:

```df -h```

If a partition is full, clean it out. Then reboot the frontend. Yes, no harm will come to you or your cluster.

Reboot it. Really. I can wait. Try the command again.

If you don't reboot, I have to give you a list of all the services that need to be restarted because you managed to not watch something so simple as the fullness of your partitions. No.

#### How do i subscribe my machines. I'm using RedHat?

When was the last time you had a problem that could be traced back to the OS and not yours or someone else's code?

That's.What.I.Thought.

But you are in an SYA-style organization that requires software licenses for an OS that rarely breaks. I get it.

So this is me, showing you, how to throw your money away.

##### Subscribe a frontend connected to the wurld-wide-interwebzz.

On the frontend, that has RHEL7.4 as it's base os. (Yeah, not gonna work if you don't. But that's a whole ['nother topic](CreateJumboPallets). )

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
