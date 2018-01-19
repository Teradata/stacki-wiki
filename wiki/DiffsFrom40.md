This describes some changes between Stacki 4.0 and Stacki 5.0 for those who are needing some translation.

## Spreadsheet headers have changed

Be aware. Spreadsheet headers have changed for "hostfile" and "networkfile".

In most instances, old spreadsheets will work, but you'll have to change a couple things in your hostfile spreadsheet.

RUNACTION is now "OSACTION"

and the individual nodes need RUNACTION or OS ACTION to be set to default, or whatever bootaction is still there.

## Bootaction

* Bootactions now have a type of either "install" or "os"
* Several have been added.
* The default bootaction is "default"
* There is a "console" action for use with serial console input.

## Saving Carts

Carts can now be passed around and packed and unpacked.

```
stack pack cart <cartname>
```

Tar-gzips your cart for passing it around like baseball cards.

Use:

```
stack unpack cart <cartname>
```

To unpack the cart into /export/stack/carts on the frontend. If the cart does not exist, it is added to the database but NOT enabled.

## Cart syntax

Syntax for XML nodes files in carts has changed. To make immediate changes to make sure the kickstart builds, check your files for this:

```
<?xml version="1.0" standalone="no"?>
<kickstart>
.stuff
..stuff
...more stuff
....lots of stuff
</kickstart>
```

Take out the "xml version" line.

and change the kickstart tags to:

```
<stack:stack>
.stuff
..stuff
...more stuff
....lots of stuff
</stack:stack>
```

Make sure a:

```
stack list host profile somenodename
```

Completes without syntax errors.

To see further changes go to [Stacki Universal XML](SUX) documentation.

## Command Line

When referencing machines in your cluster, in stacki 4.0 you could use the appliance name to get all the appliances of that type. It was a quick and dirty way to regex.

In Stacki 5.0 you have to prefix the "backend" with a "classifier".

Current classifiers:
* 'a' for appliance
* 'e' for environment
* 'o' for os
* 'b' for box
* 'g' for group
* 'r' for rack

Example:

In 4.0
```
# stack set host boot backend action=install
```

Now in 5.0
```
# stack set host boot a:backend action=installs
```

Regexes and lists are still supported.

Similarly "rack0" now becomes "r:0" and "frontend" becomes "a:frontend."

## Base Python

The base language for the stack command line is now Python 3.6. This shouldn't affect the CentOS/RHEL Python base which is 2.7 (finally!), since they sit in different trees. "python" still resolves to /usr/bin/python.

If you want to use python3, you can invoke /opt/stack/bin/python3. There's a learning curve there.
