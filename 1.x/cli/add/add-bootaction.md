## add bootaction

### Usage

`stack add bootaction [action=string] [args=string] [kernel=string] [ramdisk=string]`

### Description

Add a bootaction specification to the system.

### Parameters
* `[action=string]`

   Label name for the bootaction. You can see the bootaction label names by
	executing: 'rocks list bootaction [host(s)]'.
* `[args=string]`

   The second line for a pxelinux definition (e.g., ks ramdisk_size=150000
	lang= devfs=nomount pxe kssendmac selinux=0)
* `[kernel=string]`

   The name of the kernel that is associated with this boot action.
* `[ramdisk=string]`

   The name of the ramdisk that is associated with this boot action.

### Examples

* `stack add bootaction action=os kernel="localboot 0"`

   Add the 'os' bootaction.

* `stack add bootaction action=memtest command="memtest"`

   Add the 'memtest' bootaction.



