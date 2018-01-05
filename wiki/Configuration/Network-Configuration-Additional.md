### Managing /etc/hosts



### DNS

The Stacki frontend can serve DNS or not. It can serve it for some networks and not others. When you installed the frontend, you added nameservers.

If all your backends and frontends have hostnames served by your site DNS, you should be putting your site DNS servers in as the nameservers.

If you don't have site nameservers, the frontend can act as the named server. Set any network you want to resolve to DNS True. You can also set the "zone" which is the domainname part of the FQDN.

So for example in my two networks: "corporate" and "private" I'll set the frontend to serve DNS.

```
# stack set network dns private dns=True
# stack set network dns corporate dns=True
```

Assuming the frontend was designated as a nameserver, I will now have fqdns served by the frontend. So if I ssh to "backend-0-0.corporate", I should get to an IP address on the backend (assuming you set this up) mapping to backend-0-0.corporate on the 10.2.0.0 subnet. Same thing with the private.

#### Adding additional hosts to DNS

You can add additional site related hosts to

### bonding

### vlan

### MTU

You can use a different MTU on a network by setting the network MTU. We've
