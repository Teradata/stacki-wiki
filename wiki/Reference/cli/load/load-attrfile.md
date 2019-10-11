## load attrfile

### Usage

`stack load attrfile [file=string] [processor=string]`

### Description


	Load attributes into the database. The attribute csv file needs to have a mandatory 'target'
	column with hostnames. There are 2 ways of specifying attribute name, value:
	1. Add 'attrName', 'attrVal' columns  with attribute name and value respectively.
	2. The attribute name can also be a column in the spreadsheet and the cell at the
	intersection of a hostname row can contain the attribute value.

	

### Parameters
* `{file=string}`
* `{processor=string}`

   The processor used to parse the file and to load the data into the
	database. Default: default.

### Examples

* `stack load attrfile file=attrs.csv`

   Load all the attributes in file named attrs.csv and use the default
	processor.


### Related
[unload attrfile](unload-attrfile)


