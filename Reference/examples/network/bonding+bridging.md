---
layout: page
title: bonding+bridging
permalink: /bonding+bridging
---

| <sub>NAME</sub> | <sub>DEFAULT</sub> | <sub>APPLIANCE</sub> | <sub>RACK</sub> | <sub>RANK</sub> | <sub>IP</sub> | <sub>MAC</sub> | <sub>INTERFACE</sub> | <sub>NETWORK</sub> | <sub>CHANNEL</sub> | <sub>OPTIONS</sub> | <sub>VLAN</sub> |
| ---- | ------- | --------- | ---- | ---- | -- | --- | --------- | ------- | ------- | ------- | ---- |
| <sub>node240</sub> | <sub>TRUE</sub> | <sub>backend</sub> | <sub>1</sub> | <sub>7</sub> | <sub>10.1.2.240</sub> |  | <sub>br0</sub> | <sub>private</sub> |  | <sub>bridge</sub> |  |
| <sub>node240</sub> |  |  |  |  |  |  | <sub>bond0</sub> |  | <sub>br0</sub> | <sub>bonding-opts="mode=1 primary=em1"</sub> |  |
| <sub>node240</sub> |  |  |  |  |  | <sub>ec:f4:bb:d6:c3:a8</sub> | <sub>em1</sub> |  | <sub>bond0</sub> |  |  |
| <sub>node240</sub> |  |  |  |  |  | <sub>ec:f4:bb:d6:c3:a9</sub> | <sub>em2</sub> |  | <sub>bond0</sub> |  |  |
| <sub>node240</sub> |  |  |  |  |  | <sub>ec:f4:bb:d6:c3:aa</sub> | <sub>em3</sub> |  |  |  |  |
| <sub>node240</sub> |  |  |  |  |  | <sub>ec:f4:bb:d6:c3:ab</sub> | <sub>em4</sub> |  |  |  |  |
