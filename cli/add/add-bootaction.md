## add bootaction

### Usage

`stack add bootaction [action=string] [args=string] [kernel=string] [ramdisk=string]`

### Description

Add a bootaction specification to the system.

### Examples

* `stack add bootaction action=os kernel="localboot 0"`

   Add the 'os' bootaction.

* `stack add bootaction action=memtest command="memtest"`

   Add the 'memtest' bootaction.



