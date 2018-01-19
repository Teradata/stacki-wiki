We are putting this here because it is a common task especially when getting your configuration correct.

There are several reasons to reinstall a backend node.

* You're customizing and figuring out if the node's configuration is correct.
* You added software or a cart and want to refresh the OS.
* You want to nuke the whole thing and start over.

## Reinstall to refresh

```
# stack set host boot a:backend action=install

# stack run host command="reboot"
```

## Reinstall to start over

Do this if:
* Your level of certainty is no longer high.
* You've changed partitioning schemas.
* You've changed controller schemas.

```
# stack set host boot a:backend action=install
# stack set host attr a:backend attr=nukedisks value=True
```
If you have controller config you also are redoing:
```
# stack set host attr a:backend attr=nukecontroller value=True
```
Check it:
```
# stack list host boot
HOST        ACTION  NUKEDISKS NUKECONTROLLER
stacki50    os      False     False
backend-0-0 install True      True
```
Reboot:
```
# stack run host command="reboot"
```

Or power-cycle with your magic power-cycle scripts. (I have those, doesn't everybody have those?)

Or go push the buttons.
