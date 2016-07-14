# Stacki REST API

## Installing Stacki REST API

The Stacki REST API is distributed as a web service
running as a Django Application. To install the API
you will need to install the stacki-pro pallet.

## Installing the Stacki Pro Pallet

1. Download the Stacki-pro pallet.
2. Install the stacki-pro pallet on the frontend.
	```# stack add pallet stacki-pro-3.2-7.x.x86_64.disk1.iso```
	```# stack enable pallet stacki-pro```
	```# stack run pallet stacki-pro > /tmp/stacki-pro.sh```
3. Reboot the frontend.

Once your frontend reboots, the Stacki REST API is available.
By default, Stacki includes a webservice client, and creates
admin credentials to help validate the API.

The webservice client is called `wsclient`. The webservice
admin credentials are placed in `/root/stacki-ws.cred`

To test the web service client, run
# wsclient list host

This should print a JSON string that contains output
from the command.
