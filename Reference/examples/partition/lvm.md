---
layout: page
title: lvm
permalink: /lvm
---

| <sub>NAME</sub> | <sub>DEVICE</sub> | <sub>MOUNTPOINT</sub> | <sub>SIZE</sub> | <sub>TYPE</sub> | <sub>OPTIONS</sub> |
| ---- | ------ | ---------- | ---- | ---- | ------- |
| <sub>node207</sub> | <sub>sda</sub> | <sub>swap</sub> | <sub>8192</sub> | <sub>swap</sub> |  |
|  | <sub>sda</sub> | <sub>biosboot</sub> | <sub>1</sub> | <sub>biosboot</sub> |  |
|  | <sub>sda</sub> | <sub>/</sub> | <sub>0</sub> | <sub>ext4</sub> |  |
|  | <sub>sdb</sub> | <sub>pv.01</sub> | <sub>1</sub> | <sub>lvm</sub> | <sub>--grow</sub> |
|  | <sub>pv.01</sub> | <sub>volgrp01</sub> | <sub>0</sub> | <sub>volgroup</sub> |  |
|  | <sub>volgrp01</sub> | <sub>/var/lib/mysql</sub> | <sub>0</sub> | <sub>xfs</sub> | <sub>--name=mysql_libs</sub> |
