---
layout: page
title: sw raid
permalink: /sw-raid
---

| <sub>NAME</sub> | <sub>DEVICE</sub> | <sub>MOUNTPOINT</sub> | <sub>SIZE</sub> | <sub>TYPE</sub> | <sub>OPTIONS</sub> |
| ---- | ------ | ---------- | ---- | ---- | ------- |
| <sub>node207</sub> | <sub>md0</sub> | <sub>/</sub> | <sub>0</sub> | <sub>ext4</sub> | <sub>--level=RAID1 raid.01 raid.02</sub> |
|  | <sub>md1</sub> | <sub>/var</sub> | <sub>0</sub> | <sub>xfs</sub> | <sub>--level=RAID0 raid.03 raid.04</sub> |
|  | <sub>md2</sub> | <sub>/export</sub> | <sub>0</sub> | <sub>xfs</sub> | <sub>--level=RAID1 raid.05 raid.06</sub> |
|  | <sub>sda</sub> | <sub>biosboot</sub> | <sub>1</sub> | <sub>biosboot</sub> |  |
|  | <sub>sdb</sub> | <sub>biosboot</sub> | <sub>1</sub> | <sub>biosboot</sub> |  |
|  | <sub>sda</sub> | <sub>raid.01</sub> | <sub>16000</sub> | <sub>raid</sub> |  |
|  | <sub>sdb</sub> | <sub>raid.02</sub> | <sub>16000</sub> | <sub>raid</sub> |  |
|  | <sub>sda</sub> | <sub>raid.03</sub> | <sub>16000</sub> | <sub>raid</sub> |  |
|  | <sub>sdb</sub> | <sub>raid.04</sub> | <sub>16000</sub> | <sub>raid</sub> |  |
|  | <sub>sda</sub> | <sub>raid.05</sub> | <sub>0</sub> | <sub>raid</sub> |  |
|  | <sub>sdb</sub> | <sub>raid.06</sub> | <sub>0</sub> | <sub>raid</sub> |  |
