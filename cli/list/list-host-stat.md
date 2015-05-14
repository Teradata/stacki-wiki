## list host stat

### Usage

`stack list host stat [host]... [minutes=string] [samples=string] [start=string] [stop=string]`

### Description

List host stats.

### Arguments

* `[host]`

   Zero, one or more host names. If no host names are supplied, info about
	all the known hosts is listed.


### Parameters
* `[minutes=string]`

   The size of the sample window in minutes. Default: 10.
* `[samples=string]`

   Number of samples to display. Default: 10.
* `[start=string]`

   Start time for the sample window. Must be in the format of
	"%m/%d/%Y %H:%M:%S", for example: "07/10/2013 11:00:00".
* `[stop=string]`

   Stop time for the sample window. Must be in the format of
	"%m/%d/%Y %H:%M:%S", for example: "07/10/2013 11:30:00".

### Examples

* `stack list host stat compute-0-0`

   List info for compute-0-0.

* `stack list host stat`

   List info for all known hosts.



