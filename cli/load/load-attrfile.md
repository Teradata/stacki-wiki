## load attrfile

### Usage

`stack load attrfile [file=string] [processor=string]`

### Description

Load attributes into the database

### Parameters
* `[file=string]`

   The file that contains the attribute data to be loaded into the
	database.
* `[processor=string]`

   The processor used to parse the file and to load the data into the
	database. Default: default.

### Examples

* `stack load attrfile file=attrs.csv`

   Load all the attributes in file named attrs.csv and use the default
	processor.


### Related
[unload attrfile](unload-attrfile)


