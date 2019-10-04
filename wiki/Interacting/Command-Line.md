## Stacki command line

The stacki command line is where you'll interact with your cluster for configuration and on-going management. The full details of every command are available in the [Reference CLI section](stacki-CLI-documentation).

This is a basic primer.

The command line is English language sentence structure: subject+verb+object.
(This is common for most CLI tools that the kewl kdzz are using, but we used it first so git offa my lawn.)

You're going to use the "stack" command always as the subject.

A verb can be one of: ***add, compile, config, create, disable, dump, enable, help, iterate, list, load, pack, remove, report, run, set, swap, sync, unload, unpack.***

The verbs act on a number of objects: ***access, api, appliance, attr, attrfile, bootaction, box, cart, config, copyright, dbhost, dhcpd, dns, environment, firewall, group, help, host, hostfile, keys, mirror, named, network, networkfile, new, node, os, package, pallet, password, route, script, storage, system, version, zones.***

This seems daunting, but you will not be using every one of these verbs against every one of these objects.

The most common verbs you'll use are: ***list, add, set, load, enable, disable, report, run, and sync.***

The most common objects those verbs will use are: ***host, cart, pallet, hostfile, attrfile, config, and box.***

Loading spreadsheets also short-cuts running many of these commands at the command line.

This documentation has numerous examples of "stack" commands, and are the ones you will most commonly use. And many others are available at hand in the [Stacki Cheat Sheet](CheatSheet).

## The most common command

The most common command for interacting with your backend machines on a daily basis is:

`stack run host command="something"`

By default that command runs on any host that has an attribute (key/value pair) where "managed" is "True." By default only the frontend on an initial install is set to managed=False. All backends are to "managed=True"

Let's do something real:

```
# stack run host command="uptime"
HOST        OUTPUT
backend-0-0 11:28:21 up 2 min,  0 users,  load average: 3.33, 1.55, 0.59
backend-0-1 11:28:20 up 2 min,  0 users,  load average: 3.47, 1.40, 0.52
backend-0-2 11:28:20 up 2 min,  0 users,  load average: 3.35, 1.52, 0.58
backend-0-3 11:28:20 up 2 min,  0 users,  load average: 3.00, 1.43, 0.55
backend-0-4 11:28:19 up 4 min,  0 users,  load average: 1.32, 1.34, 0.64
```

## Ways to define hosts

When running a command on hosts you can do:

By appliance type:
`a:backend` which is all the backend nodes.

List:
`backend-0-0 backend-0-2` which would only run on backend-0-0 and backend-0-2.

Regex:
`backend-0-[0-2]` which is backend-0-0, backend-0-1, and backend-0-2.

These three methods work for all commands.

In action with a list and a regex:

```
# stack run host backend-0-0 backend-0-[24] command="yum clean all; yum -y install screen"
```

Output only on backend-0-0, backend-0-2, and backend-0-4.
```
<snip>
backend-0-4 Installed:
backend-0-4   screen.x86_64 0:4.1.0-0.23.20120314git3c2946.el7_2
backend-0-4
backend-0-4 Complete!
</snip>
```

## Rule of thumb

If you don't know how to do something with the stack command line, we probably do, ask on the Slack list or Googlegroups.

If you are finding yourself reaching for some other tool, odds are good we already do it on the command line, ask.

For further, exhaustive documentation you can read it here:

[Reference CLI section][stacki-CLI-documentation]

Or:

```
stack
```

Will list all commands and every command has a docstring which renders when you do: `stack <verb> <object> help`

Example:

```
# stack report hostfile help
stack report hostfile

Description

	Outputs a host file in CSV format.
```
