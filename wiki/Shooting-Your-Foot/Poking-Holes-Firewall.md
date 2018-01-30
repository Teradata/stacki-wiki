## How to poke holes in your firewall

It used to be, a long time ago in the long distant past of a darker age, you could multiplex all the backend traffic out to your "public" subnet.[^1]

We turned the public off by default because people are people and they do things no sane person should. We are putting this document here because we allow you to shoot your foot - we just don't recommend it. This is one of the ways you can shoot your foot, especially given Meltdown and Spectre.

However, we get it if you have an AD or LDAP server or something else that backends should get to when they don't share the corporate network, so these instructions are for you. If you run a zero day exploit farm or you're mining something that's going to make/lose you a lot of money, these instructions are for you too. But don't tell us you're doing that - plausible deniability dontcha know.

This document presumes you have a "private" network for install/monitoring/etc. This is common to the frontend and backends.  We also assume you have a "public" network on the frontend only.

The firewall is managed by iptables. You manage iptables with rules in the database.

See what is common to all the nodes:
```
# stack list firewall
NAME            TABLE  SERVICE PROTOCOL CHAIN ACTION NETWORK OUTPUT-NETWORK FLAGS
LOOPBACK-NET    filter all     all      INPUT ACCEPT ------- -------------- -i lo
SSH             filter ssh     tcp      INPUT ACCEPT ------- -------------- -m state --state NEW
PRIVATE-RELATED filter all     all      INPUT ACCEPT ------- -------------- -m state --state RELATED,ESTABLISHED
PRIVATE-NET     filter all     all      INPUT ACCEPT private --------------
REJECT-ALL      filter all     all      INPUT REJECT ------- --------------
```

See what is on the frontend:
```
# stack list host firewall a:frontend
HOST   NAME            TABLE  SERVICE PROTOCOL CHAIN ACTION NETWORK OUTPUT-NETWORK FLAGS                                COMMENT                                    SOURCE
centos LOOPBACK-NET    filter all     all      INPUT ACCEPT all     -------------- -i lo                                Accept all traffic over loopback interface G
centos SSH             filter ssh     tcp      INPUT ACCEPT all     -------------- -m state --state NEW                 Accept all ssh traffic on all networks     G
centos PRIVATE-RELATED filter all     all      INPUT ACCEPT all     -------------- -m state --state RELATED,ESTABLISHED Accept related and established connections G
centos PRIVATE-NET     filter all     all      INPUT ACCEPT private -------------- ------------------------------------ Accept all traffic on private network      G
centos REJECT-ALL      filter all     all      INPUT REJECT all     -------------- ------------------------------------ Block all traffic                          G
```

We're going to add a couple of rules for forwarding and masquerading to the frontend, all backend nodes should now be able to ping a machine outside of its "private" subnet.

These command are only on the fronted. You don't have to do anything to the backend nodes.

### Example 1 - Basic

Immma gonna  give you a script you can cut and paste.
```
#!/bin/bash
HOST=`hostname -s`

/opt/stack/bin/stack add host firewall ${HOST} output-network=public table=nat rulename=MASQUERADE service="all" protocol="all" action="MASQUERADE" chain="POSTROUTING"

/opt/stack/bin/stack add host firewall ${HOST} network=public output-network=private table=filter rulename=FORWARD_PUB service="all" protocol="all" action="ACCEPT" chain="FORWARD"

/opt/stack/bin/stack add host firewall ${HOST} network=private output-network=public table=filter rulename=FORWARD_PRIV service="all" protocol="all" action="ACCEPT" chain="FORWARD"

echo "net.ipv4.ip_forward=1" > /etc/sysctl.conf
sysctl -p /etc/sysctl.conf

stack sync host firewall ${HOST} restart=true
```

Which should produce this:
```
# stack list host firewall a:frontend
HOST   NAME            TABLE  SERVICE PROTOCOL CHAIN       ACTION     NETWORK OUTPUT-NETWORK FLAGS                                COMMENT                                    SOURCE
centos LOOPBACK-NET    filter all     all      INPUT       ACCEPT     all     -------------- -i lo                                Accept all traffic over loopback interface G
centos SSH             filter ssh     tcp      INPUT       ACCEPT     all     -------------- -m state --state NEW                 Accept all ssh traffic on all networks     G
centos PRIVATE-RELATED filter all     all      INPUT       ACCEPT     all     -------------- -m state --state RELATED,ESTABLISHED Accept related and established connections G
centos PRIVATE-NET     filter all     all      INPUT       ACCEPT     private -------------- ------------------------------------ Accept all traffic on private network      G
centos FORWARD_PUB     filter all     all      FORWARD     ACCEPT     public  private        ------------------------------------ ------------------------------------------ H
centos FORWARD_PRIV    filter all     all      FORWARD     ACCEPT     private public         ------------------------------------ ------------------------------------------ H
centos MASQUERADE      nat    all     all      POSTROUTING MASQUERADE ------- public         ------------------------------------ ------------------------------------------ H
centos REJECT-ALL      filter all     all      INPUT       REJECT     all     -------------- ------------------------------------ Block all traffic                          G
```

Try that, if it doesn't work, remove the rules we just created with `stack remove host firewall rulename=` and send a message to the list or on Slack.

### Another example - even more holes

Let's say you have Grafana and Prometheus on the frontend and you want to be able to get to it from the corporate network. This script assumes Prometheus is running on port 9090 and Grafana on 3000. It also contains the above forwarding and masquerading rules.

```
#!/bin/bash
HOST=`hostname -s`

/opt/stack/bin/stack add host firewall ${HOST} output-network=public table=nat rulename=MASQUERADE service="all" protocol="all" action="MASQUERADE" chain="POSTROUTING"

/opt/stack/bin/stack add host firewall ${HOST} network=public output-network=private table=filter rulename=FORWARD_PUB service="all" protocol="all" action="ACCEPT" chain="FORWARD"

/opt/stack/bin/stack add host firewall ${HOST} network=private output-network=public table=filter rulename=FORWARD_PRIV service="all" protocol="all" action="ACCEPT" chain="FORWARD"

/opt/stack/bin/stack add host firewall ${HOST} network=all table=filter rulename=PROMETHEUS service="9090" protocol="tcp" action="ACCEPT" chain="INPUT" flags="-m state --state NEW" comment="Prometheus"

/opt/stack/bin/stack add host firewall ${HOST} network=all table=filter rulename=GRAFANA service="3000" protocol="tcp" action="ACCEPT" chain="INPUT" flags="-m state --state NEW" comment="Prometheus"

echo "net.ipv4.ip_forward=1" > /etc/sysctl.conf
sysctl -p /etc/sysctl.conf

stack sync host firewall ${HOST} restart=true
```

That should give you an idea of how to open holes in your firewall.

[^1]: I put "public" in quotes because it might be your corporate network or the actual interwebzz you want them to have access to.
