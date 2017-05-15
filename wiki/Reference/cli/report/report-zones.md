## report zones

### Usage

`stack report zones`

### Description

Prints out all the named zone.conf and reverse-zone.conf files in XML.
	To actually create these files, run the output of the command through
	"stack report script"

### Examples

* `stack report zones`

   Prints contents of all the zone config files

* `stack report zones | stack report script`

   Creates zone config files in /var/named


### Related
[sync dns](sync-dns)


