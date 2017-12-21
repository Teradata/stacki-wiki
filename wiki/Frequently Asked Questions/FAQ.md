### When I ssh into the frontend or the a backend node, ssh takes a looonnngg time.

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

### Can I change the private network after installation?

No, not possible. Don't get that bit wrong. If you get it wrong, reinstall the frontend.

This warning was in the frontend installation documentation. Did you not heed it?

_**Do not get this network wrong! Changing it after the fact means a REINSTALL of the frontend.**_

### how do I updated or add an rpm to a node?
