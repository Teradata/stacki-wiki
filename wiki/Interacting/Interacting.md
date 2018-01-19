There are two ways to interact with your cluster:

## ["stack" command line](Command-Line)

The stack command line provides commands to:
* Run parallel commands on hosts
* Configure the database without mysql for proper backend configuration
* Generate information from hosts.


## [stack rest api](Stacki-Rest)

The rest api allows access to the stack command line. The Rest API is more limited in scope than the "stack" command line.

The API is configurable to allow only certain users to use certain commands and is available anywhere there is a connection to the Stacki frontend webserver within your site.
