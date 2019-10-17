## Adding firmware for Dell

Adding firmware for your Dell switches is a bit more complicated since it has a separate boot firmware.

`stack add firmware 3.0.0.94 source=/path/to/firmware/dell/x10xx-30094.ros make=dell model=x1052-software hosts=a:switch`

`stack add firmware 1.0.0.25 source=/path/to/firmware/dell/x10xx_boot-10025.rfb make=dell model=x1052-boot hosts=a:switch`

Stacki is preset to understand the make `dell` and the "model" numbers `x1052-software` and `x1052-boot`. These two "model"
numbers are used to differentiate between the two different upgradeable pieces of firmware on the dell x1052 switch, the boot
firmware and the software package. Be sure you use these values when adding dell firmware to be tracked by stacki.

For full details of all the parameters to this command, see the command reference for [stack add firmware](add-firmware).

## Listing current firmware on Dell hosts

The same as the general case

`stack list host firmware`

If stacki reports back no results for your switches, ensure you have mapped firmware to them and ensure that the
`switch_username` and `switch_password` attributes are set on the Dell switch hosts to the admin account's username
and password.

For full details of all the parameters to this command, see the command reference for [stack list host firmware](list-host-firmware)

## Syncing firmware to the Dell hosts

Syncing works the same as the general case.

`stack sync host firmware`

If stacki does not attempt to sync the firmware for your switches, ensure you have mapped firmware to them and ensure that the
`switch_username` and `switch_password` attributes are set on the Dell hosts to the admin account's username and password.
Also note that stacki will not sync the firmware if the same version is already applied. Use `force=True` to override that behavior.

The Dell implementations can perform both upgrades and downgrades to the boot firmware and software packages.

There may be dependencies between software packages and boot firmware, but stacki is not aware of these so make sure you have the right
mapping before syncing. The Dell docs provided with your firmware package should note if there are any.

For full details of all the parameters to this command, see the command reference for [stack list sync firmware](sync-host-firmware)

**Note:** syncing firmware will take a long time.
