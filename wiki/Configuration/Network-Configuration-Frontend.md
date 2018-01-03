## Adding networks

An initial installation defaults to having one network defined as "private." This is the network the frontend and the backend machines speak to each other on. Think of it as the "management network" which, apparently, is a thing.

You can have one network. You can have many. You can serve dhcp for multiple subnets or one. Lots of variations, all get configured using along a similar theme: Spreadsheets or command line.

To use a network on backend nodes, you have to define it on the frontend. Make sure your network infrastructure is connected for any additional networks.

To see how you use a defined network on the frontend for backend nodes, go to the [Backend Network Configuration](Backend-Network-Configuration) docs.


### Command line

Networks on the command line are easy so I don't always use a spreadsheet. If you have a complicated network topology, a network spreadsheet helps a lot.

Adding a second installation network

# stack list network
NETWORK ADDRESS  MASK        GATEWAY   MTU  ZONE  DNS   PXE
private 10.5.0.0 255.255.0.0 10.5.1.10 1500 local False True


```
# stack add network corporate address=10.2.0.0 mask=255.255.0.0 gateway=10.2.2.201 pxe=true zone=corporate dns=false
```

```
# stack list network
NETWORK    ADDRESS  MASK        GATEWAY      MTU   ZONE       DNS   PXE
private:   10.1.0.0 255.255.0.0 192.168.16.1 1500  local      True  True
corporate: 10.2.0.0 255.255.0.0 10.2.2.201   1500  corporate  False True
```

### Spreadsheet

Sometimes I'm just lazy and I would rather edit than type out the command for adding a network. So I do this:

```
# stack report networkfile > nets.csv
```

```
# cat nets.csv
NETWORK,ADDRESS,MASK,GATEWAY,MTU,ZONE,DNS,PXE
private,10.5.0.0,255.255.0.0,10.5.1.10,1500,local,False,True
```

Now I'm just gonna 'vi' into nets.csv and edit it with my "corporate" network information:

```
# vi nets.csv
NETWORK,ADDRESS,MASK,GATEWAY,MTU,ZONE,DNS,PXE
private,10.5.0.0,255.255.0.0,10.5.1.10,1500,local,False,True
```

Copy line:

```
NETWORK,ADDRESS,MASK,GATEWAY,MTU,ZONE,DNS,PXE
private,10.5.0.0,255.255.0.0,10.5.1.10,1500,local,False,True
private,10.5.0.0,255.255.0.0,10.5.1.10,1500,local,False,True
```

Edit line:
```
NETWORK,ADDRESS,MASK,GATEWAY,MTU,ZONE,DNS,PXE
private,10.5.0.0,255.255.0.0,10.5.1.10,1500,local,False,True
corporate,10.2.0.0,255.255.0.0,10.2.2.201,1500,corporate,False,True
```

Save the file and dump it back in:

```
# stack load networkfile file=nets.csv
/export/stack/spreadsheets/RCS/nets.csv,v  <--  /export/stack/spreadsheets/nets.csv
initial revision: 1.1
done
/export/stack/spreadsheets/RCS/nets.csv,v  -->  /export/stack/spreadsheets/nets.csv
revision 1.1 (locked)
done
```

RCS shows me where it's saved and that I'm "done" which is good.

Verify:
```
# stack list network
NETWORK   ADDRESS  MASK        GATEWAY    MTU  ZONE      DNS   PXE
corporate 10.2.0.0 255.255.0.0 10.2.2.201 1500 corporate False True
private   10.5.0.0 255.255.0.0 10.5.1.10  1500 local     False True
```

You'll note that we are answering PXE requests on either network. If we want to have additional interfaces for backend nodes, but are not installing on those interfaces then use the `stack set network pxe "networkname" pxe=False` command.

```stack set network help``` to see other network related commands.

### bonding

### vlan

### mtu

### dns
