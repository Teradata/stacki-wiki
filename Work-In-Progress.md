New Data format for Stacki

```
{
	"software" :
		{
			"pallet": [
				{"name" : "tdc-infrastructure", "version": "1.0", "release":"sles11", "url":"https://", "box" : ["default", "sles12"]},
				{"name" : "netapp", "version": "1.0", "release":"sles12", "box": []},
				{"name" : "kubernetes", "version": "1.0", "release":"sles12sp3", "box": []}
			],
			"cart" : [
				{"name": "mycart-12.2", "url":"https://", "box":["default", "sles12"]},
				{"name": "mycart-11.3", "url":"https://", "box":["sles11"]}
			],
			"box": [
				{ "name": "default", "os": "sles"},
				{ "name": "sles12", "os": "sles" },
				{ "name": "sles11", "os": "sles" }
			]
		}

	"host":[
		{
		"name":"backend-0-1",
		"rack": "0",
		"rank": "1",
		"interface":[
			{"name":"eth0", "mac":"010203", "ip":"auto", "network": "private", "alias":[]},
			{"name":"eth1", "mac":"010204", "ip":"auto", "network": "public", "alias":[]}
			]
		"attrs":[{"name":"attrname","val":"attrval","shadow":"T/F"},
			{"name":"attr2name","val":"attr2val","shadow":"T/F"}]
		"firewall": []
		"box":"default",
		"appliance": "",
		"comment": "comment",
		"metadata": "meta-data",
		"environment":"",
		"osaction":"", "installaction":"",
		"route":[],
		"group":["f1, g1"],
		"partition":[],
		"controller":[]
		},
	],

	"network":[
		{"name":"private","address":"10.25.241.0","gateway":"","netmask":"255.255.255.0", "dns":"t/f", "pxe":"t/f","mtu":"1500", "zone": "labs.td.com"},
		{"name":"public","address":"10.25.241.0","gateway":"","netmask":"255.255.255.0", "dns":"t/f", "pxe":"t/f","mtu":"1500", "zone": "labs.td.com"}

	],

	"global":{
		"attrs":[],
		"route":[],
		"firewall":[],
		"partition":[],
		"controller":[]
	}
	"os / env / appliance ":[
		{
			"name":"osname",
			"attrs":[],
			"route":[],
			"firewall":[],
			"partition":[],
			"controller":[]
		}
	]
	"group": [{"name":"group1"}, {"name":"group2"},{"name":"group3"}],
	"bootaction":[
		{"name", "kernel", "ramdisk","type", "args", "os"}
		]
	]

}
```
