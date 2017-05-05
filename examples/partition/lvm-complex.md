| <sub>NAME</sub> | <sub>DEVICE</sub> | <sub>MOUNTPOINT</sub> | <sub>SIZE</sub> | <sub>TYPE</sub> | <sub>OPTIONS</sub> |
| ---- | ------ | ---------- | ---- | ---- | ------- |
| <sub>backend-0-0</sub> | <sub>sda</sub> | <sub>biosboot</sub> | <sub>1</sub> | <sub>biosboot</sub> |  |
|  | <sub>sda</sub> | <sub>/boot</sub> | <sub>500</sub> | <sub>xfs</sub> |  |
|  | <sub>sda</sub> | <sub>pv.01</sub> | <sub>25000</sub> | <sub>lvm</sub> |  |
|  | <sub>pv.01</sub> | <sub>vg_sys</sub> | <sub>0</sub> | <sub>volgroup</sub> |  |
|  | <sub>vg_sys</sub> | <sub>/</sub> | <sub>2048</sub> | <sub>xfs</sub> | <sub>--name=lv_root</sub> |
|  | <sub>vg_sys</sub> | <sub>swap</sub> | <sub>1024</sub> | <sub>xfs</sub> | <sub>--name=lv_swap</sub> |
|  | <sub>vg_sys</sub> | <sub>/usr</sub> | <sub>6144</sub> | <sub>xfs</sub> | <sub>--name=lv_usr</sub> |
|  | <sub>vg_sys</sub> | <sub>/var</sub> | <sub>4096</sub> | <sub>xfs</sub> | <sub>--name=lv_var --fsoptions=defaults,nodev</sub> |
|  | <sub>vg_sys</sub> | <sub>/var/log</sub> | <sub>2048</sub> | <sub>xfs</sub> | <sub>--name=lv_var_log --fsoptions=defaults,nodev,noexec,nosuid</sub> |
|  | <sub>vg_sys</sub> | <sub>/home</sub> | <sub>500</sub> | <sub>xfs</sub> | <sub>--name=lv_home --fsoptions=defaults,nodev,nosuid</sub> |
|  | <sub>vg_sys</sub> | <sub>/opt</sub> | <sub>2560</sub> | <sub>xfs</sub> | <sub>--name=lv_opt --fsoptions=defaults,nodev,nosuid</sub> |
|  | <sub>vg_sys</sub> | <sub>/tmp</sub> | <sub>2048</sub> | <sub>xfs</sub> | <sub>--name=lv_tmp --fsoptions=defaults,nodev,noexec,nosuid</sub> |
