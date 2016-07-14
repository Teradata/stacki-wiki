# Stacki REST API

## Installing Stacki REST API

The Stacki REST API is distributed as a web service
running as a Django Application. To install the API
you will need to install the stacki-pro pallet.

## Installing the Stacki Pro Pallet

1. Download the Stacki-pro pallet.

1. Install the stacki-pro pallet on the frontend.

   * `# stack add pallet stacki-pro-3.2-7.x.x86_64.disk1.iso`
   * `# stack enable pallet stacki-pro`
   * `# stack run pallet stacki-pro > /tmp/stacki-pro.sh`

1. Reboot the frontend.

Once your frontend reboots, the Stacki REST API is available.
By default, Stacki includes a webservice client, and creates
admin credentials to help validate the API.

The webservice client is called **wsclient**. The webservice
admin credentials are placed in `/root/stacki-ws.cred`

To test the web service client, run
```shell
# wsclient list host
```
```json
[{"box": "default", "status": "up", "installaction": "install", "appliance": "frontend", "runaction": "os", "cpus": 1, "rank": "0", "environment": "", "host": "node234-002", "rack": "0"}, {"box": "default", "status": "up", "installaction": "install", "appliance": "backend", "runaction": "os", "cpus": 2, "rank": "25", "environment": "", "host": "node211", "rack": "0"}, {"box": "default", "status": "up", "installaction": "install", "appliance": "backend", "runaction": "os", "cpus": 2, "rank": "26", "environment": "", "host": "node210", "rack": "0"}, {"box": "default", "status": "up", "installaction": "install", "appliance": "backend", "runaction": "os", "cpus": 4, "rank": "28", "environment": "", "host": "node209", "rack": "0"}, {"box": "default", "status": "up", "installaction": "install", "appliance": "backend", "runaction": "os", "cpus": 4, "rank": "30", "environment": "", "host": "node207", "rack": "0"}, {"box": "default", "status": "up", "installaction": "install", "appliance": "backend", "runaction": "os", "cpus": 4, "rank": "6", "environment": "", "host": "node217", "rack": "0"}]
```

This should print a JSON string that contains output
from the command.

