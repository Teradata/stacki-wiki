## set network pxe

### Usage

`stack set network pxe [network ...] {pxe=boolean}`

### Description


Enables or Disables PXE for one of more networks.

All hosts must be connected to atleast one network that has
PXE enabled.



### Arguments

* `{network}`

   The names of zero of more networks. If no network is specified
        the PXE is set for all existing networks.


### Parameters
* `[pxe=boolean]`

   Set to True to enable PXE for the given networks.

### Examples

* `stack set network pxe private pxe=true`

   Enables PXE on the "private" network.



