## load storage partition

### Usage

`stack load storage partition [file=string] [processor=string]`

### Description

Take rows from a spreadsheet that describe how a host's disk partitions
	should be configured and then place those values into the database.

### Parameters
* `[file=string]`

   The file that contains the storage disk partition configuration.
* `[processor=string]`

   The processor used to parse the file.
	Default: default.

### Examples

* `stack load storage partition file=partitions.csv`

   Read disk partition configuration from partitions.csv and use the
	default processor to parse the data.



