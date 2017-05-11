## list bootaction

### Usage

`stack list bootaction`

### Description


Lists the set of boot actions for hosts. Each boot action is a label
that points to a command string. The command string is placed into
a host-specific pxelinux configuration file. Example labels are
'install' and 'os' which point to command strings used to install
and boot hosts respectively.



### Examples

* `stack list bootaction`

   List the boot actions available for all known hosts.



