---
layout: page
title: Network Configuration
permalink: /Network-Configuration
---

Adding a second installation network

```
# stack list network
NETWORK  ADDRESS  MASK        GATEWAY      MTU   ZONE       DNS  PXE 
private: 10.1.0.0 255.255.0.0 192.168.16.1 1500  stacki.com True True
```

```
# stack add network corporate address=10.2.0.0 mask=255.255.0.0 gateway=10.2.2.201 pxe=true zone=corporate dns=false
```

```
# stack list network
NETWORK    ADDRESS  MASK        GATEWAY      MTU   ZONE       DNS   PXE 
private:   10.1.0.0 255.255.0.0 192.168.16.1 1500  stacki.com True  True
corporate: 10.2.0.0 255.255.0.0 10.2.2.201   1500  corporate  False True
```

```
# stack add host route localhost address=10.2.0.0 netmask=255.255.0.0 gateway=10.1.2.201
```

```
# dhcrelay -d em2 10.1.2.220
Internet Systems Consortium DHCP Relay Agent 4.1.1-P1
Copyright 2004-2010 Internet Systems Consortium.
All rights reserved.
For info, please visit https://www.isc.org/software/dhcp/
Listening on LPF/em2/54:9f:35:10:1b:9a
Sending on   LPF/em2/54:9f:35:10:1b:9a
Sending on   Socket/fallback
```