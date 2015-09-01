## unload hostfile

### Usage

`stack unload hostfile [file=string] [processor=string]`

### Description

Unload (remove) hosts from the database

### Parameters
* `[file=string]`

   The file that contains the host data to be removed from the database.
* `[processor=string]`

   The processor used to parse the file and to remove the data into the
	database. Default: default.

### Examples

* `stack unload hostfile file=hosts.csv`

   Remove all the hosts in file named hosts.csv and use the default
	processor.


### Related
[load hostfile](load-hostfile)


