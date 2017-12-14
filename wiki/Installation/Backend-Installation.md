## Installing bakend nodes

After the frontend is up and running, backend nodes can be installed.

### Requirements

A backend has the following hardware requirements.

**Resource** | Minimum | Recommended
--- | --- | ---
**System Memory** | 3 GB | 8 GB
**Network Interfaces** | 1 (PXE-Capable) | 1 or more (PXE-Capable)
**Disk Capacity** | 40 GB | 100 GB

BIOS _boot order_

1. PXE (Network Boot)
2. CD/DVD Device (Optional - Only if device is present)
3. Hard Disk

### [Discovery](Backend-Install-Discovery) or [Spreadsheet](Backend-Install-Spreadsheet)

You have a frontend. It's useless if it's not managing backend nodes.

To install a new backend node, Stacki needs to add information about
the server (IP address, MAC address, appliance type, etc) to the
configuration database.

You can add backend hosts either with a spreadsheet or discovery.

When using discovery, the frontend acts as a promiscuous DHCP server. This is not always acceptable on enterprise networks.

The frontend will attempt to install any machine making a successful pxe/dhcp request. Afer the initial installation of backends, the frontend no longer acts as a promiscuous DHCP server. This is acceptable on most networks.

Do [Discovery](Backend-Install-Discovery) if:
  * You have full control of the network.
  * Your security/network teams aren't freaked about promiscuous DHCP,  no matter how short-lived.
  * You're lazy and don't want to create a spreadsheet detailing the hostname/mac/ip pairings.

Do [Spreadsheet](Backend-Install-Spreadsheet):
  * You don't control the network.
  * Your security and/or network teams consider this the start of The Apocalypse.
  * You love spreadsheets.

ALL backend nodes have to have PXE set first in the BIOS boot order. A must. An absolute requirement. A categorical imperative (Yeaaah, you know your Kant). You're not installing anything automated or at scale if you're not doing this. Don't argue. I have 15 years of arguments waiting to be used.

If the vendor does not set PXE first on your machines, you have to go do it.
  * Boot the machine.
  * Select BIOS Setup.
  * Enable PXE on the NIC wired to the installation network.
  * In the boot order set that NIC to the first boot device.
  * Save settings and exit.

**Please note:** Installing laptops as backends is not supported. Ever. Eeeeeeeevverrrrrrr. Don't write. Don't call. Don't text if you're trying to install a laptop as a backend server. Our most acidic mockery is reserved for you. (pH level = 0 = battery acid) If you're successful, great, don't tell us, we don't care.
