## Adding firmware for Mellanox

Adding firmware for your Mellanox switches is the same as the general case.

`stack add firmware 3.6.5002 source=/path/to/firmware/mellanox/img-3.6.5002.img make=mellanox model=m7800 hosts=a:switch`

Stacki is preset to understand the make `mellanox` and the model numbers `m7800` and `m6036`. Be sure you use these values
when adding Mellanox firmware to be tracked by stacki.

For full details of all the parameters to this command, see the command reference for [stack add firmware](add-firmware).

## Listing current firmware on Mellanox hosts

The same as the general case

`stack list host firmware`

If stacki reports back no results for your switches, ensure you have mapped firmware to them and ensure that the
`switch_username` and `switch_password` attributes are set on the Mellanox hosts to the admin account's username
and password.

For full details of all the parameters to this command, see the command reference for [stack list host firmware](list-host-firmware)

**Note:** This may take some time to come back depending on the model of `mellanox` switch. The `m6036` models are very slow.

## Syncing firmware to the Mellanox hosts

Syncing works the same as the general case.

`stack sync host firmware`

If stacki does not attempt to sync the firmware for your switches, ensure you have mapped firmware to them and ensure that the
`switch_username` and `switch_password` attributes are set on the Mellanox hosts to the admin account's username and password.
Also note that stacki will not sync the firmware if the same version is already applied. Use `force=True` to override that behavior.

The Mellanox implementations can perform both upgrades and downgrades to firmware, though it should be noted that a downgrade
will perform a factory reset of the switch.

For full details of all the parameters to this command, see the command reference for [stack list sync firmware](sync-host-firmware)

**Note:** syncing firmware will take a long time, especially for the `m6036` model.
