## load networkfile

### Usage

`stack load networkfile [file=string] [processor=string]`

### Description

Take rows from a spreadsheet that describe how a host's disk controller
	should be configured and then place those values into the database.

### Examples

* `stack load networkfile file=mynets.csv`

   Read disk controller configuration from controller.csv and use the
	default processor to parse the data.



