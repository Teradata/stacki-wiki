## load hostfile

### Usage

`stack load hostfile [file=string] [processor=string]`

### Description

Load host info into the database.

### Parameters
* `[file=string]`

   The file that contains the host data to be loaded into the
	database.
* `[processor=string]`

   The processor used to parse the file and to load the data into the
	database. Default: default.

### Examples

* `stack load hostfile file=hosts.csv`

   Load all the host info in file named hosts.csv and use the default
	processor.


### Related
[unload hostfile](unload-hostfile)


