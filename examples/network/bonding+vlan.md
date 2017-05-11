| <sub>NAME</sub> | <sub>DEFAULT</sub> | <sub>APPLIANCE</sub> | <sub>RACK</sub> | <sub>RANK</sub> | <sub>IP</sub> | <sub>MAC</sub> | <sub>INTERFACE</sub> | <sub>NETWORK</sub> | <sub>CHANNEL</sub> | <sub>OPTIONS</sub> | <sub>VLAN</sub> |
| ---- | ------- | --------- | ---- | ---- | -- | --- | --------- | ------- | ------- | ------- | ---- |
| <sub>node219</sub> | <sub>TRUE</sub> | <sub>backend</sub> | <sub>1</sub> | <sub>9</sub> | <sub>10.1.2.219</sub> | <sub>90:b1:1c:09:eb:af</sub> | <sub>eno1</sub> | <sub>private</sub> |  |  |  |
| <sub>node219</sub> |  |  |  |  |  | <sub>90:b1:1c:09:eb:b0</sub> | <sub>eno2</sub> |  |  |  |  |
| <sub>node219</sub> |  |  |  |  |  | <sub>90:b1:1c:09:eb:b1</sub> | <sub>eno3</sub> |  | <sub>bond0</sub> |  |  |
| <sub>node219</sub> |  |  |  |  |  | <sub>90:b1:1c:09:eb:b2</sub> | <sub>eno4</sub> |  | <sub>bond0</sub> |  |  |
| <sub>node219</sub> |  |  |  |  |  |  | <sub>bond0</sub> |  |  | <sub>bonding-opts="mode=1 primary=eno3"</sub> |  |
| <sub>node219</sub> |  |  |  |  | <sub>10.11.2.219</sub> |  | <sub>bond0.77</sub> | <sub>vlad</sub> |  |  | <sub>77</sub> |
| <sub>node240</sub> | <sub>TRUE</sub> | <sub>backend</sub> | <sub>1</sub> | <sub>7</sub> | <sub>10.1.2.240</sub> | <sub>ec:f4:bb:d6:c3:a8</sub> | <sub>em1</sub> | <sub>private</sub> |  |  |  |
| <sub>node240</sub> |  |  |  |  |  | <sub>ec:f4:bb:d6:c3:a9</sub> | <sub>em2</sub> |  |  |  |  |
| <sub>node240</sub> |  |  |  |  |  |  | <sub>bond0</sub> |  |  | <sub>bonding-opts="mode=1 primary=em3"</sub> |  |
| <sub>node240</sub> |  |  |  |  |  | <sub>ec:f4:bb:d6:c3:aa</sub> | <sub>em3</sub> |  | <sub>bond0</sub> |  |  |
| <sub>node240</sub> |  |  |  |  |  | <sub>ec:f4:bb:d6:c3:ab</sub> | <sub>em4</sub> |  | <sub>bond0</sub> |  |  |
| <sub>node240</sub> |  |  |  |  | <sub>10.11.2.240</sub> |  | <sub>bond0.77</sub> | <sub>vlad</sub> |  |  | <sub>77</sub> |
