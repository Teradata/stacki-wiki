## Storage Controller Configuration

Stacki manages storage at both the [Partition](Partitioning-Configuration) level and the hardware RAID controller level.

There are two ways to configure a storage controller: using a spreadsheet and the command line.

Using a spreadsheet is easier and a *Stacki best practice*, so, use a spreadsheet.

### Raid Controllers

Stacki can automatically configure LSI MegaRAID controllers.

This allows you to not ever have to touch a keyboard/mouse/console to configure your LSI RAID card.

All other controllers require proprietary CLI interfaces which we can no longer distribute because Stacki is now fully open source. Sorry about that?

There are also a number of on-board RAID controllers that do "Fake Raid." Stacki can't talk to those because, again, proprietary crap.

"Fake Raid" is software raid done with a hardware BIOS config. If you're not dual booting Windows and Linux, then it's colossally stupid to enable it deliberately. Turn it off and do real Linux software raid, which we can do easily.

### Spreadsheet

The configuration of disk controllers can be specified in a
spreadsheet with the following columns:

1. **Name**. A host name, appliance type or global.  
1. **Slot**. The slot of a specific disk in the array.  
1. **Raid Level**. The RAID level for the disks. This can be 0, 1, 10, 5, 6, 50, 60.  
1. **Array Id**. The order in which the RAID groups will be constructed.
1. **Options**. Any additional options to be passed on to the ```storcli``` or ```MegaRaid``` command.

A sample spreadsheet is shown below.

| <sub>NAME</sub>            | <sub>SLOT</sub> | <sub>RAID LEVEL</sub> | <sub>ARRAY ID</sub> | <sub>OPTIONS</sub>          |
|:---------------------------|:----------------|:----------------------|:--------------------|:----------------------------|
| <sub>global</sub>          | <sub>0</sub>    | <sub>1</sub>          | <sub>1</sub>        |                             |
|                            | <sub>1</sub>    | <sub>1</sub>          | <sub>1</sub>        |                             |
|                            | <sub>*</sub>    | <sub>0</sub>          | <sub>*</sub>        |                             |
| <sub>backend</sub>         | <sub>0</sub>    | <sub>60</sub>         | <sub>1</sub>        |                             |
|                            | <sub>1</sub>    | <sub>60</sub>         | <sub>1</sub>        |                             |
|                            | <sub>2</sub>    | <sub>60</sub>         | <sub>1</sub>        |                             |
|                            | <sub>3</sub>    | <sub>60</sub>         | <sub>1</sub>        |                             |
|                            | <sub>4</sub>    | <sub>60</sub>         | <sub>1</sub>        |                             |
|                            | <sub>5</sub>    | <sub>60</sub>         | <sub>1</sub>        |                             |
|                            | <sub>6</sub>    | <sub>60</sub>         | <sub>1</sub>        |                             |
|                            | <sub>7</sub>    | <sub>60</sub>         | <sub>1</sub>        |                             |
|                            | <sub>8</sub>    | <sub>60</sub>         | <sub>1</sub>        |                             |
|                            | <sub>9</sub>    | <sub>60</sub>         | <sub>1</sub>        |                             |
|                            | <sub>10</sub>   | <sub>60</sub>         | <sub>1</sub>        |                             |
|                            | <sub>11</sub>   | <sub>60</sub>         | <sub>1</sub>        |                             |
|                            | <sub>12</sub>   | <sub>Hotspare</sub>   | <sub>1</sub>        |                             |
| <sub>backend-lsi-0-1</sub> | <sub>0</sub>    | <sub>1</sub>          | <sub>2</sub>        | <sub>size=136gb force</sub> |
|                            | <sub>13</sub>   | <sub>1</sub>          | <sub>2</sub>        |                             |
|                            | <sub>1</sub>    | <sub>1</sub>          | <sub>3</sub>        |                             |
|                            | <sub>2</sub>    | <sub>1</sub>          | <sub>3</sub>        |                             |
|                            | <sub>3</sub>    | <sub>10</sub>         | <sub>1</sub>        |                             |
|                            | <sub>4</sub>    | <sub>10</sub>         | <sub>1</sub>        |                             |
|                            | <sub>5</sub>    | <sub>10</sub>         | <sub>1</sub>        |                             |
|                            | <sub>6</sub>    | <sub>hotspare</sub>   | <sub>1</sub>        |                             |
|                            | <sub>7</sub>    | <sub>10</sub>         | <sub>1</sub>        |                             |

> **Note**:  Example spreadsheets for controller configuration are also available on your frontend in `/opt/stack/share/examples/spreadsheets`. Look for files with 'controller' in the name.

The _Name_ column can contain a specific host name (e.g., _backend-lsi-0-1_), an
appliance type (e.g., _backend_) or it can be set to _global_.

1. In the sample spreadsheet, the default configuration is _global_
   1. The first logical disk (the Linux kernel will see this as ```sda```) is a RAID 1 mirror composed of the disks in slot 0 and 1
   1. The remaining disks (the disks in slots 2 and up) will be configured as individual RAID 0 disks.
      This is analogous to setting up the controller in JBOD mode.
      We specify this with the wildcard symbol "*" for the _Slot_ and _Array Id_ cells.
      Wildcards are useful when your backend hosts have different number of disks drives.
1. The next configuration is for all _backend_ hosts.
   1. The first logical disk (```sda```) will be a RAID 1 and it will be constructed with the disk in slot 5 and the disk in slot 15.
   1. The second logical disk (```sdb```) will be a RAID 5 composed of the disks in slots 0 through 4.
   1. The third logical disk (```sdc```) will be a RAID 5 composed of the disks in slots 16 through 21.
   1. The fourth logical disk (```sdd```) will be a RAID 6 composed of the disks in slots 6 through 12 and
      the disks in slots 13 and 14 will be hot spares associated with only this array.
   1. The disks in slots 22 and 23 are designated as hot spares that can be used as replacements for any failed drive in any array.
   > **Note**: When using RAID 10, the MegaRAID controller has a span limit of 8 spans.
   > By default, Stacki configures each span to be 2 drives wide. This will limit the
   > total number of disks in a RAID10 to 16 disks.

1. The next configuration is for the host named _backend-lsi-0-1_.
   1. This first logical disk(```sda```) is a RAID 10 set composed of disks 3 through 7
   1. The second logical disk(```sdb```) is a RAID 1 set with disks 0, and 13 with a size of 136 GB.
   1. The third logical disk(```sdc```) is a RAID 1 set with disks 1, and 2.
   > **Note**: This configuration is for an LSI controller that uses `storcli` as the primary
   > configuration utility.

When you are finished editing your spreadsheet, save it as a CSV file, then copy the CSV file to your frontend. Then, load the CSV file into the database on the frontend by executing:

```
# stack load storage controller file=controller.csv
```

If the controller spreadsheet contains advanced configuration, the ```force=y``` argument will need to be appended to the above command:

```
# stack load storage controller file=controller.csv force=y
```

You can view your storage controller configuration by executing:
```
# stack list storage controller
```

### The _nukecontroller_ attribute

A host's hardware RAID controller will only be reconfigured if the _nukecontroller_ attribute is set to _true_.
As an example, to set the _nukecontroller_ attribute for host _backend-0-0_, execute:

```
# stack set host attr backend-0-0 attr=nukecontroller value=true
```

Then, the next time _backend-0-0_ is installed, it will remove the current hardware RAID controller configuration, then configure it as you specified in your spreadsheet.

Like the _nukedisks_ attribute, _nukecontroller_ is set to _false_ on the initial installation of a backend node. If the RAID controller has been configured by hand with a keyboard and monitor, that configuration is safe unless the _nukecontroller_ attribute is set to _true_.

After the host has completed installation, the _nukecontroller_ attribute for that host is reset to _false_.

This ensures that the controller will not be reconfigured on the next installation.

### Command line

The command line tools can do that same thing that using a spreadsheet does. So if you prefer typing the same command over and over with only slight changes, look at the "storage controller" commands:

```
# stack | grep "storage controller"

add storage controller {scope} [adapter=int] [arrayid=string] [enclosure=int] [hotspare=int] [raidlevel=int] [slot=int]
dump storage controller
list storage controller [host]
load storage controller [file=string] [processor=string]
remove storage controller {scope} [adapter=int] [enclosure=int] [slot=int]
report host storage controller {host}
```
