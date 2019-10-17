## Firmware management

Stacki can be used to manage device firmware and keep it in sync. Right now it only supports the Mellanox m7800 and m6036 models of
infiniband switches and the Dell x1052 model of ethernet switch out of the box.

What follows below is a general overview of the commands you're most likely to use. There are some additional specifics for the
Mellanox and Dell switches which need to be taken into account in order to use these commands.

For information on the specifics of managing Mellanox switch firmware, see the
[Mellanox firmware docs](Firmware-Configuration-Mellanox).

For information on the specifics of managing Dell X1052 switch firmware, see the [Dell firmware docs](Firmware-Configuration-Dell).

## Adding firmware

Adding firmware for hosts is fairly straight forward.

`stack add firmware 3.6.5002 source=/path/to/firmware/file.whatever make=device-make model=9001 hosts=switch-0-0,switch-0-1`

This will add the firmware file pointed to by the `source` parameter to be tracked by stacki, tagging it as version `3.6.5002`
for the make and model of the device specified, and mapping this firmware to the `hosts` that are specified. This has told
stacki to manage the firmware for hosts `switch-0-0` and `switch-0-1`, and to set the `3.6.5002` firmware version as the desired
version to be applied to the switches.

Stacki will hash the firmware file downloaded to ensure that any subsequent fetching does not result in a corrupted firmware file.
You can provide an expected hash ahead of time using the `hash` parameter. The hash algorithm defaults to MD5, but can be
controlled with the `hash_alg` parameter. Specifying the hash of the file ahead of time is recommended, especially when fetching
the firmware file over a network.

For full details of all the parameters to this command, see the command reference for [stack add firmware](add-firmware).

## Listing current firmware

Listing the current firmware on the hosts is now possible since we've adde firmware and mapped it to the hosts.
This is a bit quirky in that stacki needs firmware to be mapped to the host before it attempts to list what the current firmware is.

In order for this to work properly for both of the supported switches, two host attributes need to be set that specify which `username`
and `password` to use to log into the switch's administration interface:
* `switch_username` - the username to log in with
* `switch_password` - the password to use when logging in with the username above

If these are not set, defaults are used that correspond to what was the default username/password combo for the switches the
last time we updated that code.

`stack list host firmware`

This will attempt to reach out and talk to each host with firmware mapped to it. Stacki wll use the appropriate implementation
based on which firmware is mapped to the host to determine what firmware is currently on the hosts. For hosts without any firmware
mapped to them, stacki will return no results.

For full details of all the parameters to this command, see the command reference for [stack list host firmware](list-host-firmware)

**Note:** This may take some time to come back depending on the implementation and whether the username/password combo is right.

## Syncing firmware

Now that the firmware has been added, mapped to the hosts, and the list command confirmed our mapping, we can sync it.

`stack sync host firmware`

This will go through each host with firmware mapped to it, check if the current firmware version matches the requested version,
and if not will sync the requested firmware version.

To force syncing the firmware version even if the current version matches, such as if you want both banks to be flashed with
the same firmware version, pass `force=True` to the `stack sync host firmware` command.

This command will skip syncing hosts that have no firmware mapped to them.

For full details of all the parameters to this command, see the command reference for [stack list sync firmware](sync-host-firmware)

**Note:** syncing firmware will take a long time, but the process is performed in parallel if there are multiple hosts to sync.

## Adding new firmware mappings

Under the hood, `stack add firmware` when passed the `hosts` parameter creates a firmware mapping for each host. This can also be done
manually when, for example, you add another host and want to map an existing firmware version to it.

`stack add host firmware mapping switch-0-2 switch-0-3 make=device-make model=9001 version=3.6.5002`

This will add a new mapping for the firmware with the specified make, model, and version to the switch-0-2 and switch-0-3 hosts. Now
running the `stack list firmware` or `stack sync firmware` commands will operate on these new hosts based on the firmware mapped to
them.

For full details of all the parameters to this command, see the command reference for
[stack add host firmware mapping](add-host-firmware-mapping)

## Listing existing firmware mappings

To see how the firmware is currently mapped to hosts, you can run:

`stack list host firmware mapping`

This will list out all of the firmware versions and what hosts they are mapped to.

For full details of all the parameters to this command, see the command reference for
[stack list host firmware mapping](list-host-firmware-mapping)

## Removing firmware mappings

To unmap firmware from hosts, so that the firmware version will no longer be listed or synced to them, run:

`stack remove host firmware mapping switch-0-3 make=device-make model=9001 version=3.6.5002`

This will remove that specific version of firmware from being mapped to the `switch-0-3` host.

**Note:** running this command with no args will remove **all** firmware mappings. This might not be what you want to do.

For full details of all the parameters to this command, see the command reference for
[stack remove host firmware mapping](remove-host-firmware-mapping)

## Removing firmware

Sometimes you might want to remove an old firmware file to make way for a new version. This can be accomplished using:

`stack remove firmware 3.6.5002 1.2.3 make=device-make model=9001`

This will remove thw two firmware versions `3.6.5002` and `1.2.3` for the specified make and model. This will automatically
unmap those firmware versions from any hosts they were mapped to.

**Note:** running this command with no args will remove **all** firmware. This might not be what you want to do.

For full details of all the parameters to this command, see the command reference for
[stack remove firmware](remove-firmware)
