
## Reinstall backend nodes - preserve data

```
# stack set host boot a:backend action=install

% Check
# stack list host

% Reboot
# stack run host command="reboot"

(or powercycle - however your site does that)
```

## Reinstall backend nodes - nuke data
```
# stack set host attr a:backend attr=nukedisks value=True
# stack set host boot a:backend action=install

% Check
# stack list host

% Reboot
# stack run host command="reboot"

(or powercycle - however your site does that)
```
